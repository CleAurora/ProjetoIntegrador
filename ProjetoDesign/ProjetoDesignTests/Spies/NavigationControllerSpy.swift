//
//  NavigationControllerSpy.swift
//  ProjetoDesignTests
//
//  Created by Cleís Aurora Pereira on 04/02/21.
//

import UIKit

final class NavigationControllerSpy: UINavigationController {
    var invokedSetNavigationBarHidden = false
    var invokedSetNavigationBarHiddenCount = 0
    var invokedSetNavigationBarParameters: (hidden: Bool, animated: Bool)?
    var invokedSetNavigationBarParametersList = [(hidden: Bool, animated: Bool)]()

    // MARK: - UINavigationController conforms

    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        super.setNavigationBarHidden(hidden, animated: animated)

        invokedSetNavigationBarHidden = true
        invokedSetNavigationBarHiddenCount += 1
        invokedSetNavigationBarParameters = (hidden, animated)
        invokedSetNavigationBarParametersList.append((hidden, animated))
    }
}
