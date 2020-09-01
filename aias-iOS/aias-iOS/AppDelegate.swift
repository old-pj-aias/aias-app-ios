//
//  AppDelegate.swift
//  aias-iOS
//
//  Created by shunta nakajima on 2020/08/25.
//  Copyright © 2020 ShuntaNakajima. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SMSAuthViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

