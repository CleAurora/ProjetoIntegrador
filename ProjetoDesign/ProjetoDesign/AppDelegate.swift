//
//  AppDelegate.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import IQKeyboardManagerSwift
import Firebase
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - UIApplicationDelegate conforms

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UITabBar.appearance().unselectedItemTintColor = UIColor.green

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        FirebaseApp.configure()

        Database.database().isPersistenceEnabled = true
    }
}
