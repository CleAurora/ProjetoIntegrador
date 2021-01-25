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
        do {
            try Auth.auth().signOut()
        }
        catch {
            debugPrint(#function, error)
        }

        if let signViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() {
            UIApplication.shared.keyWindow?.rootViewController = signViewController
        }
    }
}
