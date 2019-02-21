//
//  AwesomeThingViewController.swift
//  SiriShortcuts
//
//  Created by Nic Laughter on 2/21/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import UIKit
import SAConfettiView

class AwesomeThingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let confettiView = SAConfettiView(frame: self.view.frame)
        self.view.addSubview(confettiView)
        confettiView.alpha = 0
        confettiView.startConfetti()
        
        UIView.animate(withDuration: 0.3) {
            confettiView.alpha = 1
        }
        
        let displayCount = UserDefaults.standard.integer(forKey: "greetingCount")
        let hasSeenSiri = UserDefaults.standard.bool(forKey: "hasSeenSiri")
        if displayCount > 1, (displayCount + 1) % 3 == 0, !hasSeenSiri {
            guard let addToSiriViewController = UIStoryboard(name: "AddToSiri", bundle: nil).instantiateInitialViewController() else { return }
            self.present(addToSiriViewController, animated: true, completion: nil)
        } else if !hasSeenSiri {
            UserDefaults.standard.set(displayCount + 1, forKey: "greetingCount")
        }
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
