//
//  UIView+AccessibilityIdentifier.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 02/02/21.
//

import class UIKit.UIView

extension UIView {
    func findBy<T: UIView>(acessibilityIdentifier id: String) -> T? {
        if accessibilityIdentifier == id, let element = self as? T {
            return element
        }

        for subview in subviews {
            if let element = subview.findBy(acessibilityIdentifier: id) as? T {
                return element
            }
        }

        return nil
    }
}
