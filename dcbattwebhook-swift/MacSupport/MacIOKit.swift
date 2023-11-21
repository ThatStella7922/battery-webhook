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

/**
 Returns the current power source as string.
 
 - Returns:
 Battery Power, AC Power or Unknown
 
 - Warning: Only available on macOS
 */
func getPowerSource() -> String {
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
#endif
