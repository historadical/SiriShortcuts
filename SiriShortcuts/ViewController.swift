//
//  ViewController.swift
//  SiriShortcuts
//
//  Created by Nicholas Laughter on 2/20/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import UIKit
import Intents
import IntentsUI
import CoreSpotlight
import CoreServices

class ViewController: UIViewController {

    let myUserActivity: NSUserActivity = {
        return NSUserActivity(activityType: "tech.gaire.siri-shortcuts.\(UUID().uuidString.components(separatedBy: "-").last!)")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(sayHello), name: .SiriShortcutReceived, object: nil)
        if !UserDefaults.standard.bool(forKey: "hasCreatedActivity") {
            self.createUserActivity()
        }

        let addToSiriButton = INUIAddVoiceShortcutButton(style: .whiteOutline)
        addToSiriButton.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(addToSiriButton)
        self.view.centerXAnchor.constraint(equalTo: addToSiriButton.centerXAnchor).isActive = true
        self.view.centerYAnchor.constraint(equalTo: addToSiriButton.centerYAnchor).isActive = true

        addToSiriButton.addTarget(self, action: #selector(self.addToSiri(_:)), for: .touchUpInside)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    @IBAction func sayHiButtonTapped(_ sender: Any) {
        self.sayHello()
    }

    @objc func sayHello() {
        guard let awesomeThingViewController = UIStoryboard(name: "AwesomeThing", bundle: nil).instantiateInitialViewController() else { return }
        self.present(awesomeThingViewController, animated: true, completion: nil)
    }

    // Present the Add Shortcut view controller after the
    // user taps the "Add to Siri" button.
    @objc func addToSiri(_ sender: Any) {
        let viewController = INUIAddVoiceShortcutViewController(shortcut: INShortcut(userActivity: self.myUserActivity))
        viewController.modalPresentationStyle = .formSheet
        viewController.delegate = self // self conforming to INUIAddVoiceShortcutViewControllerDelegate.
        present(viewController, animated: true, completion: nil)
    }

    private func createUserActivity() {
        NSUserActivity.deleteAllSavedUserActivities {

            self.myUserActivity.title = "Awesome Thing" // Always localize user-facing strings!

            self.myUserActivity.suggestedInvocationPhrase = "Get awesome"

            self.myUserActivity.isEligibleForSearch = true
            self.myUserActivity.isEligibleForPrediction = true

            let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
            attributes.contentDescription = "Siri can do the awesome thing for you!"

            attributes.thumbnailData = UIImage(named: "awesome-thing")?.pngData()
            self.myUserActivity.contentAttributeSet = attributes

            self.userActivity = self.myUserActivity
            UserDefaults.standard.set(true, forKey: "hasCreatedActivity")
        }
    }
}

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        print("did it! \(voiceShortcut?.invocationPhrase ?? "No phrase")")
        controller.dismiss(animated: true, completion: nil)
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        print("didn't work!")
        controller.dismiss(animated: true, completion: nil)
    }
}
