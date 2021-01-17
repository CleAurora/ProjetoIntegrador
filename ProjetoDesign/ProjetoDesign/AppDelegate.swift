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

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UITabBar.appearance().unselectedItemTintColor = UIColor.green
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

        FirebaseApp.configure()

        Database.database().isPersistenceEnabled = true

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
}
