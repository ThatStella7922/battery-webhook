//
//  SettingsUtils.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/16/22.
//

import Foundation

private let defaults = UserDefaults.standard

func ResetAllSettings() -> Void {
    let domain = Bundle.main.bundleIdentifier!
    defaults.removePersistentDomain(forName: domain)
    defaults.synchronize()
}
