//
//  ViewController.swift
//  SiriShortcuts
//
//  Created by Nicholas Laughter on 2/20/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(sayHello), name: .SiriShortcutReceived, object: nil)
        if !UserDefaults.standard.bool(forKey: "hasCreatedActivity") {
            self.createUserActivity()
        }
    }

    @IBAction func sayHiButtonTapped(_ sender: Any) {
        self.sayHello()
    }

    @objc func sayHello() {
        guard let awesomeThingViewController = UIStoryboard(name: "AwesomeThing", bundle: nil).instantiateInitialViewController() else { return }
        self.present(awesomeThingViewController, animated: true, completion: nil)
    }

    private func createUserActivity() {
        NSUserActivity.deleteAllSavedUserActivities {
            let userActivity = NSUserActivity(activityType: "tech.gaire.siri-shortcuts.\(UUID().uuidString)")
            userActivity.title = "Awesome Thing" // Always localize user-facing strings!
            userActivity.isEligibleForSearch = true
            userActivity.isEligibleForPrediction = true
            self.userActivity = userActivity
            UserDefaults.standard.set(true, forKey: "hasCreatedActivity")
        }
    }
}
