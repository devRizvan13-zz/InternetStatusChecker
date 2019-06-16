//
//  AppDelegate.swift
//  Example
//
//  Created by Rizvan on 16/06/2019.
//  Copyright © 2019 R13App. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        _ = InternetStatusChecker.shared
        
        return true
    }
}

