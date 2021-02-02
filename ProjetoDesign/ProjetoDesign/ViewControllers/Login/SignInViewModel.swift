//
//  SignInViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora on 1/19/21.
//

import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

protocol SignOutProvider {
    func signOut()
}

protocol GoogleSignInProvider {
    func set(presentingViewController: UIViewController?)
    func reSignInWithGoogle()
    func signInWithGoogle()
}

protocol FacebookSignInProvider {
    func signInWithFacebook(on viewController: UIViewController)
}

protocol SignInDataStore {
    var error: Error? { get }
    var window: UIWindow? { get set }
}

typealias SignInViewModelProtocol = FacebookSignInProvider & GoogleSignInProvider

final class SignInViewModel: NSObject, FacebookSignInProvider, GIDSignInDelegate, GoogleSignInProvider, SignInDataStore,
                             SignOutProvider {
    static let shared: FacebookSignInProvider & GIDSignInDelegate & GoogleSignInProvider & SignInDataStore & SignOutProvider = SignInViewModel()

    // MARK: - Private constants

    private let googleSignIn = GIDSignIn.sharedInstance()
    private let facebookSignIn = LoginManager()
    private let auth = Auth.auth()
    private let databaseReference = Database.database().reference()

    // MARK: - Variables

    weak var window: UIWindow?
    private(set) var error: Error?

    // MARK: - Initializer

    private override init() {
        super.init()

        googleSignIn?.delegate = self
    }

    // MARK: - FacebookSignInProvider conforms

    func signInWithFacebook(on viewController: UIViewController) {
        facebookSignIn.logIn(permissions: [.email, ], viewController: viewController) { [self] loginResult in
            if case let LoginResult.failed(error) = loginResult {
                return proxy(failure: error)
            } else if case let LoginResult.success(granted: _, declined: _, token: accessToken) = loginResult {
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                return firebaseSignIn(with: credential)
            }

            return proxy(failure: NSError(domain: #function, code: 403, userInfo: ["FBSDKLoginKit": "canceled"]))
        }
    }

    // MARK: - GoogleProviderSignIn conforms

    func set(presentingViewController: UIViewController?) {
        googleSignIn?.presentingViewController = presentingViewController
    }

    /**
     Asks to login using Google SignIn.

     First check if the e-mail are registered both in authentication and database.

     This e-mail is registered in DB?
        - Go to logged area (feed).

     This e-mail isn't registered in DB?
        - Register user in the using data from Google.
        - Go to logged area (feed).
     */
    func signInWithGoogle() {
        googleSignIn?.signIn()
    }

    func reSignInWithGoogle() {
        guard auth.currentUser != nil else {
            return signOut()
        }

        redirectToLoggedArea()
    }

    // MARK: - SignOutProvider conforms

    func signOut() {
        try? auth.signOut()
        googleSignIn?.signOut()
        facebookSignIn.logOut()
    }

    // MARK: - GIDSignInDelegate conforms

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            return proxy(failure: error)
        }

        guard let authentication = user.authentication else {
            return proxy(failure: NSError(domain: #function, code: 403, userInfo: [:]))
        }

        let credential = GoogleAuthProvider.credential(
            withIDToken: authentication.idToken, accessToken: authentication.accessToken
        )

        firebaseSignIn(with: credential)
    }

    private func handleFirebaseSignIn(error: Error) {
        let firebaseError = error as NSError
        let keyExpected = "FIRAuthErrorUserInfoNameKey"
        let valueExpected = "ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL"
        let isKeyAndValueExpected = firebaseError.userInfo.first(
            where: { key, value in key == keyExpected && value as? String == valueExpected }
        )

        guard firebaseError.domain == "FIRAuthErrorDomain", isKeyAndValueExpected != nil else {
            return proxy(failure: error)
        }
    }

    private func firebaseSignIn(with credential: AuthCredential) {
        auth.signIn(with: credential) { [self] (authDataResult, firebaseSignError) in
            guard firebaseSignError == nil else {
                return proxy(failure: firebaseSignError)
            }

            guard let result = authDataResult else {
                return proxy(failure: NSError(domain: "auth data result is nil", code: 0, userInfo: [:]))
            }

            checkUserOnDatabase(user: result.user)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        do {
            try auth.signOut()
        } catch {
            proxy(failure: error)
        }
    }

    // MARK: - Private functions

    private func proxy(failure: Error?) {
        error = failure
    }

    private func redirectToLoggedArea() {
        set(presentingViewController: nil)

        if let feedViewController = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() {
            window?.rootViewController = feedViewController
        }
    }

    private func checkUserOnDatabase(user: FirebaseAuth.User) {
        databaseReference.child("users").child(user.uid).observeSingleEvent(of: .value) { [self] dataSnapshot in
            guard dataSnapshot.exists() else {
                return createNewUserOnDataFrom(user: user)
            }

            redirectToLoggedArea()
        }
    }

    private func createNewUserOnDataFrom(user: FirebaseAuth.User) {
        let email = user.email ?? ""
        let displayName = user.displayName ?? ""
        let profileUrl = user.photoURL?.absoluteString ?? ""
        let random = Int.random(in: 0...9)
        let displayNameWithoutDiacriticsAndSpaces = displayName.lowercased().folding(
            options: .diacriticInsensitive, locale: nil
        ).replacingOccurrences(of: " ", with: "\(random)")
        let nickname = "@\(displayNameWithoutDiacriticsAndSpaces.lowercased())"
        let value = [
            "Name": displayName,
            "Email": email,
            "profileUrl": profileUrl,
            "UserID": user.uid,
            "Nickname": nickname,
            "Bio": "",
            "Followers": 0,
            "Following": 0,
            "followers": [
                "first": " "
            ],
            "following": [
                "first": " "
            ]
        ] as [String: Any]

        databaseReference.child("users").child(user.uid).setValue(value) { [self] (databaseError, ref) in
            guard databaseError == nil else {
                return proxy(failure: error)
            }

            redirectToLoggedArea()
        }
    }
}
