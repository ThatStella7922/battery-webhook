//
//  SettingsUtils.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/16/22.
//

import Foundation
import SwiftUI

/// Global declaration of Battery Webhook's shared UserDefaults
public let defaults = UserDefaults(suiteName: "group.thatstel.la.battery-webhook.shared")!

/// Resets all user settings in legacy **and** shared containers (Clears everything)
func ResetAllSettings() -> Void {
    defaults.removePersistentDomain(forName: "thatstel.la.battery-webhook")
    defaults.removePersistentDomain(forName: "group.thatstel.la.battery-webhook.shared")
    defaults.synchronize()
}

/// Resets user settings in the legacy container. (Clears UserDefaults)
func ResetSettings() -> Void {
    defaults.removePersistentDomain(forName: "thatstel.la.battery-webhook")
    defaults.synchronize()
}

/// Resets user settings in the shared container. (Clears UserDefaults in the shared container)
func ResetSettingsShared() -> Void {
    defaults.removePersistentDomain(forName: "group.thatstel.la.battery-webhook.shared")
    defaults.synchronize()
}

/// Returns the entire UserDefaults (Settings) as a Dictionary object
func GetSettingsAsDictionary() -> Dictionary<String, Any> {
    return defaults.dictionaryRepresentation()
}

/**
 Does internal first time launch housekeeping tasks.
 
 For now this sets `IsFirstLaunch` in UserDefaults to `true`.
*/
func DoAppFirstTimeLaunch() -> Void {
    defaults.set(true, forKey: "IsFirstLaunch")
    SaveAutomationCurrentDate() // Saves automations current date so no "275 months"
    SaveCurrentDate() // Saves manual current date so no "275 months"
    EnsureSharedSettings() // makes sure that this isn't because of the move to the shared container
}

/// Checks that the user's settings are saved in the shared container, and if not, copies them over.
func EnsureSharedSettings() {
    if !(UserDefaults.standard.bool(forKey: "IsUsingSharedSettings")) {
        MoveToSharedSettings() // do the moving !
        UserDefaults.standard.setValue(true, forKey: "IsUsingSharedSettings")
    }
}

func UndoEnsureSharedSettings() {
    UserDefaults.standard.setValue(false, forKey: "IsUsingSharedSettings")
}

/// (To be used by EnsureSharedSettings) Copy the user's settings to the shared container
func MoveToSharedSettings() {
    NSLog("MoveToSharedSettings: Start")
    SaveAutomationCurrentDate()
    SaveCurrentDate()
    NSLog("MoveToSharedSettings: Saved New Dates, Beginning Copy")
    for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
        print("MoveToSharedSettings:\nKey \(key) with value \"\(value)\" has been moved\n")
        defaults.setValue(value, forKey: key)
    }
    NSLog("MoveToSharedSettings: Done")
}
