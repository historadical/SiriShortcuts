//
//  AppDelegate.swift
//  SiriShortcuts
//
//  Created by Nicholas Laughter on 2/20/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 12.0, *),
            let dictionary:NSDictionary = launchOptions?[UIApplication.LaunchOptionsKey.userActivityDictionary] as? NSDictionary,
            let actionInfo = dictionary["UIApplicationLaunchOptionsUserActivityTypeKey"] as? String,
            let intent = actionInfo.components(separatedBy: ".").last {
            SiriShortcutManager.shared.intent = intent
        }
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if #available(iOS 12.0, *),
            let intent = userActivity.activityType.components(separatedBy: ".").last {
            SiriShortcutManager.shared.intent = intent
        }
        return true
    }
}

