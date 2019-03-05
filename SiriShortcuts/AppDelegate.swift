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
        if let userActivity = launchOptions?[.userActivityDictionary] as? NSUserActivity {
            SiriShortcutManager.shared.intent = userActivity.activityType
        }
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        SiriShortcutManager.shared.intent = userActivity.activityType
        return true
    }
}

