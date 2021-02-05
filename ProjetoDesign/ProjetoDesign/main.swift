//
//  main.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 01/02/21.
//

import func Foundation.NSStringFromClass
import func UIKit.UIApplicationMain

#if TEST
let appDelegateClass = NSStringFromClass(TestAppDelegate.self)
#else
let appDelegateClass = NSStringFromClass(AppDelegate.self)
#endif

_ = UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
