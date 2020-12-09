//
//  LogoutSegue.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 11/10/20.
//

import UIKit
import FirebaseAuth
final class LogoutSegue: UIStoryboardSegue {
    override func perform() {

            // call from any screen

            do { try Auth.auth().signOut() }
            catch { print("already logged out") }

//            navigationController?.popToRootViewController(animated: true)

        source.dismiss(animated: false, completion: nil)
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
