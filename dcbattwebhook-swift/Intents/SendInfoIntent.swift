//
//  SendInfoIntent.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/2/23.
//

import Foundation
import AppIntents
import SwiftUI

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct SendInfoIntent: AppIntent {
    @Parameter(title: "Report that the device was plugged in")
    var userDidPlugIn: Bool
    
    @Parameter(title: "Report that the device was unplugged")
    var userDidUnplug: Bool
    
    @Parameter(title: "Report that the device reached full charge")
    var userDidHit100: Bool
    
    static let title: LocalizedStringResource = "Send Battery Info (Standard)"
    static let description: LocalizedStringResource = "Sends battery info using the configuration set in the Battery Webhook app. Prefer this action instead of the Legacy action as it is more efficient."
    static let openAppWhenRun = false

    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        // Ensure user does not enable more than a single option
        var throwMultiOptionError = false
        if (userDidPlugIn || userDidUnplug || userDidHit100) {
            if (userDidPlugIn && userDidUnplug && userDidHit100) {
                throwMultiOptionError = true
            } else if (userDidPlugIn && userDidUnplug) {
                throwMultiOptionError = true
            } else if (userDidPlugIn && userDidHit100) {
                throwMultiOptionError = true
            } else if (userDidUnplug && userDidPlugIn) {
                throwMultiOptionError = true
            } else if (userDidUnplug && userDidHit100) {
                throwMultiOptionError = true
            } else if (userDidHit100 && userDidPlugIn) {
                throwMultiOptionError = true
            } else if (userDidHit100 && userDidUnplug) {
                throwMultiOptionError = true
            }
            if (throwMultiOptionError) {
                throw MyIntentError.message("Configuration Error", "You cannot enable more than one automation event in a single action at a time. Please create seperate Shortcuts Automations if you want to send battery info when more than one automation event is triggered.")
            }
        }
        
        // Validate the settings
        let isSettingsValid = ValidateSettings()
        
        if (isSettingsValid.err == true) {
            throw MyIntentError.message("Configuration Error", isSettingsValid.errMsg)
        }
        else {
            let ResultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: userDidPlugIn, didGetUnplugged: userDidUnplug, didHitFullCharge: userDidHit100)
            SaveAutomationCurrentDate()
            if (ResultsVar.err) {
                throw MyIntentError.message("Network Error", ResultsVar.errMsg)
            }
            else {
                return .result(dialog: "Battery info was sent.")
            }
        }
        
        
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
enum MyIntentError: Swift.Error, CustomLocalizedStringResourceConvertible {
    case generic
    case message(_ title: String, _ message: String)

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case let .message(title, message): return "\(title): \(message)"
        case .generic: return "An unknown Intents error occurred. Please try again."
        }
    }
}
