//
//  AppDelegate.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        UITabBar.appearance().unselectedItemTintColor = UIColor.green
        IQKeyboardManager.shared.enable = true
    }
}
