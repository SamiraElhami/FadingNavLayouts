//
//  AppDelegate.swift
//  FadingNavLayouts
//
//  Created by Samira on 11/2/18.
//  Copyright © 2018 elhami. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = FadingNavViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

