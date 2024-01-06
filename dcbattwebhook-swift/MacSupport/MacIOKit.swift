//
//  MacIOKit.swift
//  Battery Webhook
//
//  Created by Stella Luna on 11/21/23.
//

#if os(macOS)
import Foundation
import IOKit
import IOKit.ps

func HandleMacPowerStateChange() {
    switch GetMacPowerSource() {
    case "Battery Power":
        if (GetMacAutomationSetting(automationSetting: "MacSendOnUnplugged")) {
            let isSettingsValid = ValidateSettings()
            
            if (isSettingsValid.err == true) {
                // config error
            }
            else {
                let ResultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: true, didHitFullCharge: false)
                SaveAutomationCurrentDate()
                if (ResultsVar.err) {
                    // network error
                }
                else {
                    // success
                }

            }
        }
    case "AC Power":
        if (GetMacAutomationSetting(automationSetting: "MacSendOnPluggedIn")) {
            let isSettingsValid = ValidateSettings()
            
            if (isSettingsValid.err == true) {
                // config error
            }
            else {
                let ResultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: true, didGetUnplugged: false, didHitFullCharge: false)
                SaveAutomationCurrentDate()
                if (ResultsVar.err) {
                    // network error
                }
                else {
                    // success
                }

            }
        }
    default:
        print("Unknown")
    }
}

func HandleMacHitFullCharge() {
    if (GetMacAutomationSetting(automationSetting: "MacSendOnHitFullCharge")) {
        let isSettingsValid = ValidateSettings()
        
        if (isSettingsValid.err == true) {
            // config error
        }
        else {
            let ResultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: false, didHitFullCharge: true)
            SaveAutomationCurrentDate()
            if (ResultsVar.err) {
                // network error
            }
            else {
                // success
            }

        }
    }
}

/**
 Returns the current power source as string.
 
 - Returns:
 Battery Power, AC Power or Unknown
 
 - Warning: Only available on macOS
 */
func GetMacPowerSource() -> String {
    guard let snapshot = IOPSCopyPowerSourcesInfo()?.takeRetainedValue() else { return "Unknown" }
    guard let sources: NSArray = IOPSCopyPowerSourcesList(snapshot)?.takeRetainedValue() else { return "Unknown" }
    for ps in sources {
        guard let info: NSDictionary = IOPSGetPowerSourceDescription(snapshot, ps as CFTypeRef)?.takeUnretainedValue() else { return "Unknown" }

        if let powerSource = info[kIOPSPowerSourceStateKey] as? String {
            return powerSource
        }
    }
    
    return "Unknown"
}

/**
 Returns whether or not the Mac is charging
 
 - Returns:
 it's a bool
 
 - Warning: Only available on macOS
 */
func GetMacIsCharging() -> Bool {
    guard let snapshot = IOPSCopyPowerSourcesInfo()?.takeRetainedValue() else { return false }
    guard let sources: NSArray = IOPSCopyPowerSourcesList(snapshot)?.takeRetainedValue() else { return false }
    for ps in sources {
        guard let info: NSDictionary = IOPSGetPowerSourceDescription(snapshot, ps as CFTypeRef)?.takeUnretainedValue() else { return false }

        if let isCharging = info[kIOPSIsChargingKey] as? Bool {
            return isCharging
        }
    }
    
    return false
}
#endif
