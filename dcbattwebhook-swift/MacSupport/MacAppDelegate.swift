//
//  MacAppDelegate.swift
//  Battery Webhook
//
//  Created by Stella Luna on 11/17/23.
//

#if os(macOS)
import Foundation
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NotificationCenter.default.addObserver(self, selector: #selector(powerStateChanged(_:)), name: Notification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    }
    
    
    @objc func powerStateChanged(_ notification: Notification) {
        print("caught a low power mode state change")
    }
}
#endif
