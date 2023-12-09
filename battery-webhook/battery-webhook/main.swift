//
//  main.swift
//  battery-webhook
//
//  Created by Stella Luna on 12/8/23.
//

import Foundation

/// Name of the app
public let prodName = "Battery Webhook"
/// Base version of the app, use `version` if you want the running OS as well
let versionNum = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
let versionBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
let versionType = "Dev"

#if DEBUG
public let versionBase = "\(versionNum)(\(versionBuild)) \(versionType)"
#else
public let versionBase = "\(versionNum)"
#endif

#if os(macOS)
//public var macAutomationsSavedPowerSource = GetMacPowerSource()
public let version = "\(versionBase) on macOS"
#elseif os(watchOS)
public let version = "\(versionBase) on watchOS"
#elseif os(visionOS)
public let version = "\(versionBase) on visionOS"
#elseif os(tvOS)
public let version = "\(versionBase) on tvOS"
#elseif os(iOS)
public let version = "\(versionBase)"
#endif

NSLog("[main] \(prodName) \(versionBase) launched...")

#if os(macOS)
import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// start up the app
_ = NSApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv
)
#elseif os(iOS)
import UIKit

let app = UIApplication.shared
let delegate = IOSAppDelegate()

_ = UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(UIApplication.self),
    NSStringFromClass(IOSAppDelegate.self)
)
#endif
