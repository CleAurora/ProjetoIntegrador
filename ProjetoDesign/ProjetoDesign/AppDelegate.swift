//
//  AppDelegate.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import Firebase
import GoogleSignIn
import IQKeyboardManagerSwift
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var window: UIWindow?

    // MARK: - UIApplicationDelegate conforms

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UITabBar.appearance().unselectedItemTintColor = UIColor.green

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        FirebaseApp.configure()

        Database.database().isPersistenceEnabled = true

        GIDSignIn.sharedInstance().clientID = "1014045513958-sd8mjssit23948ic7esijph1n9u7n1fc.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
    }
}
