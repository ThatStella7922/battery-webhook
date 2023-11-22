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
    
    if defaults.object(forKey: "MacSendOnPluggedIn") == nil {
        macSendOnPluggedIn = false
    } else { macSendOnPluggedIn = defaults.bool(forKey: "MacSendOnPluggedIn") }
    if defaults.object(forKey: "MacSendOnUnplugged") == nil {
        macSendOnUnplugged = false
    } else { macSendOnUnplugged = defaults.bool(forKey: "MacSendOnUnplugged") }
    if defaults.object(forKey: "MacSendOnHitFullCharge") == nil {
        macSendOnHitFullCharge = false
    } else { macSendOnHitFullCharge = defaults.bool(forKey: "MacSendOnHitFullCharge") }
    
    switch automationSetting {
    case "MacSendOnPluggedIn":
        return macSendOnPluggedIn
    case "MacSendOnUnplugged":
        return macSendOnUnplugged
    case "MacSendOnHitFullCharge":
        return macSendOnHitFullCharge
    default:
        return false
    }
}

#endif
