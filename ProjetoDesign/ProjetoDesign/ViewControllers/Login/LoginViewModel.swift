//
//  LoginViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 27/11/20.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

final class LoginViewModel {
    var titleBtnLogin: String {
        return "Login"
    }

    var titleBtnRegister: String {
        return "Register"
    }

    var imageBtnInstagram: String {
        return "google"
    }

    var imageBtnFaceBook: String {
        return "face"
    }

    private weak var viewController: SignInViewController?

    init(view: SignInViewController) {
        self.viewController = view
    }

    func doLogin(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if let viewController = viewController, let email = viewController.emailTextField.text,
           let password = viewController.passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
                guard error == nil else {
                    return completionHandler(false, error)
                }

                return completionHandler(true, nil)
            }
        } else {
            completionHandler(false, NSError(domain: #function, code: 0, userInfo: [:]))
        }
    }

    func isAlreadyLogged(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        let isLogged = Auth.auth().currentUser?.uid != nil

        completionHandler(isLogged, nil)
    }
}
