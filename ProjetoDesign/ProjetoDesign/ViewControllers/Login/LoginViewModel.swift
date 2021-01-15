//
//  LoginViewModel.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 27/11/20.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

class LoginViewModel {
    var titleBtnLogin: String{
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
    var view = ViewController()

    init(view: ViewController) {
        self.view = view
    }

    func doLogin(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){

        do{
            Auth.auth().signIn(withEmail: view.emailTextField.text!, password: view.passwordTextField.text!) { [weak self] user, error in
               if error != nil{
                   print("me")
                   print(error!.localizedDescription)
                   return
               }
               completionHandler(true,nil)
           }
        }catch{
            completionHandler(false,nil)
        }
    }

    func isAlreadyLogged(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        do{
            if let user = Auth.auth().currentUser?.uid {
                completionHandler(true,nil)
            }
        }catch{
            completionHandler(false,nil)
        }
    }
}
