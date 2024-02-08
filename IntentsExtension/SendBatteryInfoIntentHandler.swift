//
//  SendBatteryInfoIntentHandler.swift
//  IntentsExtension
//
//  Created by Stella Luna on 2/8/24.
//

import Foundation
import Intents

class BatteryWebhookIntentHandler: NSObject, SendBatteryInfoIntentHandling {
    func handle(intent: SendBatteryInfoIntent, completion: @escaping (SendBatteryInfoIntentResponse) -> Void) {
        let userDidPlugIn = Bool(truncating: intent.userDidPlugIn!)
        let userDidUnplug = Bool(truncating: intent.userDidUnplug!)
        let userDidHit100 = Bool(truncating: intent.userDidHit100!)
        
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
                completion(SendBatteryInfoIntentResponse(code:.multiOptionError, userActivity: nil))
            }
        }
        
        var isSettingsValid = ValidateSettings()
        
        if (isSettingsValid.err == true) {
            completion(SendBatteryInfoIntentResponse.configError(configErrorMsg: isSettingsValid.errMsg))
        } else {
            let resultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: userDidPlugIn, didGetUnplugged: userDidUnplug, didHitFullCharge: userDidHit100)
            SaveAutomationCurrentDate()
            if (resultsVar.err) {
                completion(SendBatteryInfoIntentResponse.networkError(networkErrorMsg: resultsVar.errMsg))
            }
            else {
                completion(SendBatteryInfoIntentResponse(code:.success, userActivity: nil))
            }
        }
        
        
    }
}
