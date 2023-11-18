//
//  SettingsUtils.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/16/22.
//

import Foundation
import SwiftUI

private let defaults = UserDefaults.standard

/// Resets all user settings. (Clears UserDefaults)
func ResetAllSettings() -> Void {
    let domain = Bundle.main.bundleIdentifier!
    defaults.removePersistentDomain(forName: domain)
    defaults.synchronize()
}

/// Returns the entire UserDefaults (Settings) as a Dictionary object
func GetSettingsAsDictionary() -> Dictionary<String, Any> {
    return UserDefaults.standard.dictionaryRepresentation()
}

/**
 Does internal first time launch housekeeping tasks.
 
 For now this sets `IsFirstLaunch` in UserDefaults to `true`.
*/
func DoAppFirstTimeLaunch() -> Void {
    defaults.set(true, forKey: "IsFirstLaunch")
}
