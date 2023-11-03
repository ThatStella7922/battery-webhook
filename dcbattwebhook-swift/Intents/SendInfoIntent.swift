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
    //@Parameter(title: "Report plugging in device")
    //var userDidPlugIn: Bool
    
    //@Parameter(title: "Report unplugging device")
    //var userDidUnplug: Bool
    
    //@Parameter(title: "Report reaching full charge")
    //var userDidHit100: Bool
    
    static let title: LocalizedStringResource = "Send Battery Info"
    static let description: LocalizedStringResource = "Sends battery info using the configuration set in the Battery Webhook app"
    static let openAppWhenRun = false

    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        // Validate the settings
        let isSettingsValid = ValidateSettings()
        
        if (isSettingsValid.err == true) {
            //errAlert = ErrorAlertStruct(msg: isSettingsValid.errMsg, title: "Configuration Error")
            return .result(dialog: "Configuration Error")
        }
        else {
            let ResultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: false, didHitFullCharge: false)
            SaveCurrentDate()
            if (ResultsVar.err) {
                // See L#58 in SendBatteryInfo.swift, this will never trigger unless that is improved
                //errAlert = ErrorAlertStruct(msg: ResultsVar.errMsg, title: "Error")
                return .result(dialog: "Error while sending")
            }
            else {
                //errAlert = ErrorAlertStruct(msg: "The battery info was sent.", title: "Success")
                return .result(dialog: "Battery info was sent.")
            }
        }
        
        
    }
}
