//
//  LogoutSegue.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 11/10/20.
//

import UIKit

final class LogoutSegue: UIStoryboardSegue {
    override func perform() {
        source.dismiss(animated: false, completion: nil)
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
