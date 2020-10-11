//
//  DismissSegue.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 11/10/20.
//

import UIKit

final class DismissSegue: UIStoryboardSegue {
    override func perform() {
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
