//
//  AddToSiriViewController.swift
//  SiriShortcuts
//
//  Created by Nic Laughter on 2/21/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import UIKit
import IntentsUI
import CoreSpotlight
import MobileCoreServices

class AddToSiriViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addToSiriButton = INUIAddVoiceShortcutButton(style: .blackOutline)
        addToSiriButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(addToSiriButton)
        self.view.centerXAnchor.constraint(equalTo: addToSiriButton.centerXAnchor).isActive = true
        self.view.centerYAnchor.constraint(equalTo: addToSiriButton.centerYAnchor).isActive = true
        
        addToSiriButton.addTarget(self, action: #selector(self.addToSiri(_:)), for: .touchUpInside)
        
        let notNowButton = UIButton(frame: addToSiriButton.frame)
        notNowButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(notNowButton)
        self.view.centerXAnchor.constraint(equalTo: notNowButton.centerXAnchor).isActive = true
        self.view.centerYAnchor.constraint(equalTo: notNowButton.centerYAnchor, constant: addToSiriButton.frame.height).isActive = true
        
        notNowButton.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
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
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddToSiriViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        print("Added voice shortcut")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        print("Cancelled voice shortcut")
        controller.dismiss(animated: true, completion: nil)
    }
}
