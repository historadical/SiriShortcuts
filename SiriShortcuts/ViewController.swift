//
//  ViewController.swift
//  SiriShortcuts
//
//  Created by Nicholas Laughter on 2/20/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import UIKit
import IntentsUI
import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = INUIAddVoiceShortcutButton(style: .blackOutline)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true

        button.addTarget(self, action: #selector(addToSiri(_:)), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(helloTokyo), name: .SiriShortcutReceived, object: nil)
    }


    // Present the Add Shortcut view controller after the
    // user taps the "Add to Siri" button.
    @objc
    func addToSiri(_ sender: Any) {
        let userActivity = NSUserActivity(activityType: "tech.gaire.siri-shortcuts.awesome-thing")

        userActivity.isEligibleForSearch = true
        userActivity.isEligibleForPrediction = true

        userActivity.title = "Do Awesome Thing"
        userActivity.suggestedInvocationPhrase = "Do the awesome thing"
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.contentDescription = "Siri can do the awesome thing for you!"
        attributes.thumbnailData = UIImage(named: "awesome-thing")?.pngData()

        userActivity.contentAttributeSet = attributes

        self.userActivity = userActivity

        let shortcut = INShortcut(userActivity: userActivity)
        INVoiceShortcutCenter.shared.setShortcutSuggestions([shortcut])

        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        viewController.modalPresentationStyle = .formSheet
        viewController.delegate = self // Object conforming to `INUIAddVoiceShortcutViewControllerDelegate`.
        present(viewController, animated: true, completion: nil)
    }

    @objc
    func helloTokyo() {
        print("did an awesome thing!")
        guard let awesomeThing = UIStoryboard(name: "AwesomeThing", bundle: nil).instantiateInitialViewController() else { return }
        self.present(awesomeThing, animated: true, completion: nil)
    }
}

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        print("Added voice shortcut")
        controller.dismiss(animated: true, completion: nil)
    }

    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        print("Cancelled voice shortcut")
        controller.dismiss(animated: true, completion: nil)
    }
}
