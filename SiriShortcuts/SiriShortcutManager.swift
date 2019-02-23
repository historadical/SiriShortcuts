//
//  SiriShortcutManager.swift
//  SiriShortcuts
//
//  Created by Nicholas Laughter on 2/20/19.
//  Copyright © 2019 Gaire Tech, LLC. All rights reserved.
//

import Foundation

class SiriShortcutManager {

    static let shared = SiriShortcutManager()

    var intent: String? {
        didSet {
            guard self.intent != nil else { return }
            NotificationCenter.default.post(Notification(name: .SiriShortcutReceived))
        }
    }
}
