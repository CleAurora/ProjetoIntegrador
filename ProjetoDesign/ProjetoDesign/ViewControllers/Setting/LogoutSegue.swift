//
//  LogoutSegue.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 11/10/20.
//

import UIKit

final class LogoutSegue: UIStoryboardSegue {
    override func perform() {
        SignInViewModel.shared.signOut()

        if let signViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() {
            UIApplication.shared.keyWindow?.rootViewController = signViewController
        }
    }
}
