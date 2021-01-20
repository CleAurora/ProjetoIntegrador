//
//  SignInViewModel.swift
//  ProjetoDesign
//
//  Created by Rafael Ferreira on 1/19/21.
//

import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

protocol SignOutProvider {
    func signOut()
}

protocol GoogleSignInProvider {
    func set(presentingViewController: UIViewController)
    func signInWithGoogle()
}

final class SignInViewModel: NSObject, GIDSignInDelegate, GoogleSignInProvider, SignOutProvider {
    static let shared: GIDSignInDelegate & GoogleSignInProvider & SignOutProvider = SignInViewModel()

    // MARK: - Private variables

    private let googleSignIn = GIDSignIn.sharedInstance()
    private let auth = Auth.auth()
    private let databaseReference = Database.database().reference()

    // MARK: - Variables

    var error: Error?

    // MARK: - Initializer

    private override init() {
        super.init()
    }

    // MARK: - GoogleProviderSignIn conforms

    func set(presentingViewController: UIViewController) {
        googleSignIn?.presentingViewController = presentingViewController
    }

    /*
     Asks to login using Google SignIn.

     First check if the e-mail are registered both in authentication and database.

     This e-mail is registered in DB?
        - Go to logged area (feed).

     This e-mail isn't registered in DB?
        - Register user in the using data from Google.
        - Go to logged area (feed).
     */
    func signInWithGoogle() {
        googleSignIn?.delegate = self

        googleSignIn?.signIn()
        // pedir o login via google.
        // verificar se já existe esse e-mail cadastrado como login/db
            // tem usuário no db:
                // entrar na tela de feed
            // n
    }

    // MARK: - SignOutProvider conforms

    func signOut() {
        googleSignIn?.signOut()
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

        auth.signIn(with: credential) { [self] (authDataResult, firebaseSignError) in
            guard firebaseSignError == nil else {
                return proxy(failure: firebaseSignError)
            }

            guard let result = authDataResult else {
                return proxy(failure: NSError(domain: "auth data result is nil", code: 0, userInfo: [:]))
            }

            checkUserOnDatabase(user: result.user)
        }
        debugPrint(#function)

        if let user = user {
            debugPrint(user)
        }

        if let error = error {
            debugPrint(error)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        debugPrint(#function)

        if let user = user {
            debugPrint(user)
        }

        if let error = error {
            debugPrint(error)
        }
    }

    // MARK: - Private functions

    private func proxy(failure: Error?) {
        error = failure
    }

    private func redirectToLoggedArea() {
        // Redirect to Feed page.
        debugPrint(#function)
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
