//
//  ViewController.swift
//  SiriShortcuts
//
//  Created by Nicholas Laughter on 2/20/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let uuid = UUID().uuidString.components(separatedBy: "-").last!

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
            let userActivity = NSUserActivity(activityType: "tech.gaire.siri-shortcuts.\(self.uuid)")
            userActivity.title = "Awesome Thing: \(self.uuid)" // Always localize user-facing strings!
            
            userActivity.isEligibleForSearch = true
            userActivity.isEligibleForPrediction = true
            self.userActivity = userActivity
        }
    }
}
