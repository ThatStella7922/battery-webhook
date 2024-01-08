//
//  MacSettingsUtils.swift
//  Battery Webhook
//
//  Created by Stella Luna on 11/21/23.
//

#if os(macOS)
import Foundation

/**
 Gets a Mac Automation Setting and returns it
 
 - Parameters:
   - automationSetting: a valid setting to retrieve as described below
 
 A valid setting is one of the following strings:
 ```
 MacSendOnPluggedIn
 MacSendOnUnplugged
 MacSendOnHitFullCharge
 MacSendOnAppOpened
 ```
 
 - Returns:
 Value of the Mac Automation Setting as Bool
 
 - Warning: Only available on macOS, and returns `false` if an invalid setting is specified
 */
func GetMacAutomationSetting(automationSetting: String) -> Bool {
    let defaults = UserDefaults.standard
    
    var macSendOnPluggedIn = false
    var macSendOnUnplugged = false
    var macSendOnHitFullCharge = false
    var macSendOnAppOpened = false
    
    switch automationSetting {
    case "MacSendOnPluggedIn":
        macSendOnPluggedIn = defaults.bool(forKey: "MacSendOnPluggedIn")
        return macSendOnPluggedIn
    case "MacSendOnUnplugged":
        macSendOnUnplugged = defaults.bool(forKey: "MacSendOnUnplugged")
        return macSendOnUnplugged
    case "MacSendOnHitFullCharge":
        macSendOnHitFullCharge = defaults.bool(forKey: "MacSendOnHitFullCharge")
        return macSendOnHitFullCharge
    case "MacSendOnAppOpened":
        macSendOnAppOpened = defaults.bool(forKey: "MacSendOnAppOpened")
        return macSendOnAppOpened
    default:
        return false
    }
}

#endif
