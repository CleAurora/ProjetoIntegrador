//
//  LoginViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 27/11/20.
//

import FirebaseAuth

protocol LoginViewModelProtocol {
    var titleBtnLogin: String { get }
    var titleBtnRegister: String { get }
    var imageBtnInstagram: String { get }
    var imageBtnFaceBook: String { get }

    func doLogin(email: String?, password: String?, completionHandler: @escaping (Result<Bool, Error>) -> Void)
}

final class LoginViewModel: LoginViewModelProtocol {
    let titleBtnLogin: String = "Login"
    let titleBtnRegister: String = "Register"
    let imageBtnInstagram: String = "google"
    let imageBtnFaceBook: String = "face"

    // MARK: - LoginViewModelProtocol conforms

    func doLogin(email: String?, password: String?, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        if let email = email, let password = password {
            Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
                if let error = error {
                    return completionHandler(.failure(error))
                }

                return completionHandler(.success(true))
            }
        } else {
            completionHandler(.failure(NSError(domain: #function, code: 0, userInfo: [:])))
        }
    }
}
