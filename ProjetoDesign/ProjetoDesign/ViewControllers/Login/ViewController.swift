//
//  ViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var googleButtonTapped: GIDSignInButton!
    @IBOutlet weak var faceButtonTapped: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var loginModel: LoginViewModel?
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "login2")
        backgroundImageView.layer.maskedCorners = CACornerMask(rawValue: UIRectCorner([.bottomLeft, .bottomRight]).rawValue)
        loginButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        setupView()

        setupUI()
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            <#code#>
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance()?.signIn()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.loginModel = LoginViewModel(view: self)
        loginModel?.isAlreadyLogged(completionHandler: { success, _ in
            if success {
                if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? SHCircleBarController{
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
    }

    func setupUI(){
        self.loginModel = LoginViewModel(view: self)
        self.loginButton.setTitle(loginModel?.titleBtnLogin, for: .normal )
        self.registerButton.setTitle(loginModel?.titleBtnRegister, for: .normal)
        self.faceButtonTapped.setImage(UIImage(named: loginModel!.imageBtnFaceBook), for: .normal)
        //self.googleButtonTapped.setImage(UIImage(named: loginModel!.imageBtnInstagram), for: .normal)
    }

    // MARK: - Methods
    func setupView(){
        loginView.layer.shadowPath = UIBezierPath(rect: loginView.bounds).cgPath
        loginView.layer.shadowRadius = 15
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowOpacity = 1
    }

    // MARK: - IBActions

    @IBAction func loginButton(_ sender: Any) {
        self.loginModel = LoginViewModel(view: self)
        loginModel?.doLogin(completionHandler: { success, _ in
            if success {
                if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? SHCircleBarController{
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
    }

    @IBAction func registerButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Registrar", bundle: nil).instantiateInitialViewController() as? RegistrarViewController {
            present(vc, animated: true, completion: nil)
        }
    }

    @IBAction func faceButtonTapped(_ sender: Any) {
        showUnderDevelopment()
    }

    @IBAction func googleButtonTapped(_ sender: Any) {
        //showUnderDevelopment()

//        func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//            if let error = error {
//                return
//            }
//
//            guard let authentication = user.authentication else { return }
//            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//        }
    }

//    func loginWithGoogle(credential: AuthCredential, completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
//        Auth.auth().signIn(with: credential) { (authResult, error) in
//          if let error = error {
//            let authError = error as NSError
//            if (isMFAEnabled && authError.code == AuthErrorCode.secondFactorRequired.rawValue) {
//              // The user is a multi-factor user. Second factor challenge is required.
//              let resolver = authError.userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//              var displayNameString = ""
//              for tmpFactorInfo in (resolver.hints) {
//                displayNameString += tmpFactorInfo.displayName ?? ""
//                displayNameString += " "
//              }
//              self.showTextInputPrompt(withMessage: "Select factor to sign in\n\(displayNameString)", completionBlock: { userPressedOK, displayName in
//                var selectedHint: PhoneMultiFactorInfo?
//                for tmpFactorInfo in resolver.hints {
//                  if (displayName == tmpFactorInfo.displayName) {
//                    selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
//                  }
//                }
//                PhoneAuthProvider.provider().verifyPhoneNumber(with: selectedHint!, uiDelegate: nil, multiFactorSession: resolver.session) { verificationID, error in
//                  if error != nil {
//                    print("Multi factor start sign in failed. Error: \(error.debugDescription)")
//                  } else {
//                    self.showTextInputPrompt(withMessage: "Verification code for \(selectedHint?.displayName ?? "")", completionBlock: { userPressedOK, verificationCode in
//                      let credential: PhoneAuthCredential? = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: verificationCode!)
//                      let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator.assertion(with: credential!)
//                      resolver.resolveSignIn(with: assertion!) { authResult, error in
//                        if error != nil {
//                          print("Multi factor finanlize sign in failed. Error: \(error.debugDescription)")
//                        } else {
//                          self.navigationController?.popViewController(animated: true)
//                        }
//                      }
//                    })
//                  }
//                }
//              })
//            } else {
//              self.showMessagePrompt(error.localizedDescription)
//              return
//            }
//            // ...
//            return
//          }
//          // User is signed in
//          // ...
//        }
//    }

    private func showUnderDevelopment(){
        let alert = UIAlertController(
            title: "This option still under development", message: nil, preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }

}
