//
//  MacAppDelegate.swift
//  Battery Webhook
//
//  Created by Stella Luna on 11/17/23.
//

#if os(macOS)
import Foundation
import IOKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        let source = IOPSNotificationCreateRunLoopSource(
            {
                _ in
                if macAutomationsSavedPowerSource != GetMacPowerSource() {
                    HandleMacPowerStateChange()
                    macAutomationsSavedPowerSource = GetMacPowerSource()
                } else if (hasBattery) && (getBatteryLevel() != macAutomationsCurrentBattery) {
                    if (getBatteryLevel() == 100) {
                        HandleMacHitFullCharge()
                        macAutomationsCurrentBattery = getBatteryLevel()
                    } else {
                        macAutomationsCurrentBattery = getBatteryLevel()
                    }
                }
                                
            },nil).takeRetainedValue()
        
        CFRunLoopAddSource(CFRunLoopGetCurrent(),source,.defaultMode)
    }
}
#endif
