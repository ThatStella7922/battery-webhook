//
//  SettingsUtils.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/16/22.
//

import Foundation

private let defaults = UserDefaults.standard

/// Resets all user settings. (Clears UserDefaults)
func ResetAllSettings() -> Void {
    let domain = Bundle.main.bundleIdentifier!
    defaults.removePersistentDomain(forName: domain)
    defaults.synchronize()
}

/**
 Does internal first time launch housekeeping tasks.
 
 For now this sets `IsFirstLaunch` in UserDefaults to `true`.
*/
func DoAppFirstTimeLaunch() -> Void {
    defaults.set(true, forKey: "IsFirstLaunch")
}
