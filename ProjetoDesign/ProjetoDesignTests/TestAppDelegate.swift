//
//  TestAppDelegate.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 01/02/21.
//

#if TEST

import Firebase
import IQKeyboardManagerSwift
import UIKit

final class TestAppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: UIApplicationDelegate conforms

    func applicationDidFinishLaunching(_ application: UIApplication) {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        FirebaseApp.configure()

        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.makeKeyAndVisible()
        newWindow.rootViewController = UIViewController()

        window = newWindow
    }
}

#endif
