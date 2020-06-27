//
//  AppDelegate.swift
//  Transbank
//
//  Created by kevinOlivet on 06/27/2020.
//  Copyright (c) 2020 kevinOlivet. All rights reserved.
//

import Transbank
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

        var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch and to enableStubs
        TransbankStubs().enableStubs()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let viewController = TransbankFactory().getExampleRootViewController()
        window?.rootViewController = viewController
        return true
    }
}

