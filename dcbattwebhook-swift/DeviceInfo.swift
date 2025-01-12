//
//  DeviceInfo.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import Foundation
#if os(watchOS)
import WatchKit
#endif
#if !os(macOS)
import UIKit
#else
import IOKit
import IOKit.ps
#endif

public struct DeviceInfo {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        #if os(macOS)
        #if arch(x86_64)
        var MacModelIdentifier: String {
            let service = IOServiceGetMatchingService(kIOMasterPortDefault,
                                                      IOServiceMatching("IOPlatformExpertDevice"))
            var modelIdentifier: String?
            if let modelData = IORegistryEntryCreateCFProperty(service, "model" as CFString, kCFAllocatorDefault, 0).takeRetainedValue() as? Data {
                modelIdentifier = String(data: modelData, encoding: .utf8)?.trimmingCharacters(in: .controlCharacters)
            }
            
            IOObjectRelease(service)
            return modelIdentifier ?? "Unknown: \(identifier)"
        }

        return MacModelIdentifier

        
        #else
        // Prpduct Name detection for Apple Silicon Macs
        let entry = IORegistryEntryFromPath(kIOMainPortDefault,"IOService:/AppleARMPE/product")
        defer { IOObjectRelease(entry) }
        let deviceName = IORegistryEntryCreateCFProperty(entry, "product-name" as CFString, kCFAllocatorDefault, 0)
        if (deviceName == nil) {
            return "Unknown: \(identifier)"
        }
        return String(decoding: deviceName!.takeUnretainedValue() as! Data, as: UTF8.self).trimmingCharacters(in: CharacterSet(charactersIn: "\u{00}"))
        #endif
        #endif
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(visionOS)
            switch identifier {
            case "RealityDevice14,1":      return "Apple Vision Pro"
            case "i386", "x86_64", "arm64":return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "visionOS"))"
            default: return identifier
            }
            #elseif os(iOS)
            switch identifier {
            case "iPod9,1":                                       return "iPod touch (7th generation)"
            case "iPhone8,1":                                     return "iPhone 6s"
            case "iPhone8,2":                                     return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
            case "iPhone11,2":                                    return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
            case "iPhone11,8":                                    return "iPhone XR"
            case "iPhone12,1":                                    return "iPhone 11"
            case "iPhone12,3":                                    return "iPhone 11 Pro"
            case "iPhone12,5":                                    return "iPhone 11 Pro Max"
            case "iPhone13,1":                                    return "iPhone 12 mini"
            case "iPhone13,2":                                    return "iPhone 12"
            case "iPhone13,3":                                    return "iPhone 12 Pro"
            case "iPhone13,4":                                    return "iPhone 12 Pro Max"
            case "iPhone14,4":                                    return "iPhone 13 mini"
            case "iPhone14,5":                                    return "iPhone 13"
            case "iPhone14,2":                                    return "iPhone 13 Pro"
            case "iPhone14,3":                                    return "iPhone 13 Pro Max"
            case "iPhone14,7":                                    return "iPhone 14"
            case "iPhone14,8":                                    return "iPhone 14 Plus"
            case "iPhone15,2":                                    return "iPhone 14 Pro"
            case "iPhone15,3":                                    return "iPhone 14 Pro Max"
            case "iPhone15,4":                                    return "iPhone 15"
            case "iPhone15,5":                                    return "iPhone 15 Plus"
            case "iPhone16,1":                                    return "iPhone 15 Pro"
            case "iPhone16,2":                                    return "iPhone 15 Pro Max"
            case "iPhone17,3":                                    return "iPhone 16"
            case "iPhone17,4":                                    return "iPhone 16 Plus"
            case "iPhone17,1":                                    return "iPhone 16 Pro"
            case "iPhone17,2":                                    return "iPhone 16 Pro Max"
            case "iPhone8,4":                                     return "iPhone SE"
            case "iPhone12,8":                                    return "iPhone SE (2nd generation)"
            case "iPhone14,6":                                    return "iPhone SE (3rd generation)"
            case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            case "iPad13,18", "iPad13,19":                        return "iPad (10th generation)"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
            case "iPad13,16", "iPad13,17":                        return "iPad Air (5th generation)"
            case "iPad14,10", "iPad14,11":                        return "iPad Air (13-inch, M2)"
            case "iPad14,8", "iPad14,9":                          return "iPad Air (11-inch, M2)"
            case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            case "iPad16,1", "iPad16,2":                          return "iPad mini (A17 Pro)"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
            case "iPad14,3", "iPad14,4":                          return "iPad Pro (11-inch) (4th generation)"
            case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            case "iPad14,5", "iPad14,6":                          return "iPad Pro (12.9-inch) (6th generation)"
            case "iPad16,5", "iPad16,6":                          return "iPad Pro (13-inch, M4, waste of sand)"
            case "iPad16,3", "iPad16,4":                          return "iPad Pro (11-inch, M4, waste of sand)"
            case "i386", "x86_64", "arm64":                       return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                              return "Unknown: \(identifier)"
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3":      return "Apple TV HD"
            case "AppleTV6,2":      return "Apple TV 4K (1st generation)"
            case "AppleTV11,1":     return "Apple TV 4K (2nd generation)"
            case "AppleTV14,1":     return "Apple TV 4K (3rd generation)"
            case "i386", "x86_64", "arm64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #elseif os(watchOS)
            switch identifier {
            case "Watch3,1", "Watch3,3":                         return "Apple Watch Series 3 38mm"
            case "Watch3,2", "Watch3,4":                         return "Apple Watch Series 3 42mm"
            case "Watch4,1", "Watch4,3":                         return "Apple Watch Series 4 40mm"
            case "Watch4,2", "Watch4,4":                         return "Apple Watch Series 4 44mm"
            case "Watch5,1", "Watch5,3":                         return "Apple Watch Series 5 40mm"
            case "Watch5,2", "Watch5,4":                         return "Apple Watch Series 5 44mm"
            case "Watch6,1", "Watch6,3":                         return "Apple Watch Series 6 40mm"
            case "Watch6,2", "Watch6,4":                         return "Apple Watch Series 6 44mm"
            case "Watch5,9", "Watch5,11":                        return "Apple Watch SE 40mm"
            case "Watch5,10", "Watch5,12":                       return "Apple Watch SE 44mm"
            case "Watch6,6", "Watch6,8":                         return "Apple Watch Series 7 41mm"
            case "Watch6,7", "Watch6,9":                         return "Apple Watch Series 7 45mm"
            case "Watch6,14", "Watch6,16":                       return "Apple Watch Series 8 41mm"
            case "Watch6,15", "Watch6,17":                       return "Apple Watch Series 8 45mm"
            case "Watch6,10", "Watch6,12":                       return "Apple Watch SE (2nd generation) 40mm"
            case "Watch6,11", "Watch6,13":                       return "Apple Watch SE (2nd generation) 44mm"
            case "Watch6,18":                                    return "Apple Watch Ultra"
            case "Watch7,1", "Watch7,2", "Watch7,3", "Watch7,4": return "Apple Watch Series 9"
            case "Watch7,5":                                     return "Apple Watch Ultra 2"
            case "Watch7,9", "Watch7,11":                        return "Apple Watch Series 10"
            case "i386", "x86_64", "arm64":return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "watchOS"))"
            default: return identifier
            }
            #else
            return identifier
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

/// Return the user-set name of the device as a string, as reported by the system API. **Using on iOS 16 and later results in a generic device name being returned (such as iPhone)**
func getSystemReportedDeviceUserDisplayName() -> String {
    #if os(macOS)
    return Host.current().localizedName ?? "Mac"
    #elseif os(watchOS)
    return WKInterfaceDevice.current().name
    #else
    return UIDevice.current.name
    #endif
}

/**
 Return the user-set name of the device as a string (ex. Crystal if the device is named Crystal.
 
 Pulls from the UsrDeviceName setting, the user can change it in Settings in the app.
 
 If this value doesn't exist for whatever reason, this function will fall back to returning what is reported by the system API subject to the same limitations as `getSystemReportedDeviceUserDisplayName()`
 */
func getDeviceUserDisplayName() -> String {
    var deviceName = getSystemReportedDeviceUserDisplayName()
    if let usrDeviceName = defaults.string(forKey: "UsrDeviceName") {
        if (usrDeviceName.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
            deviceName = usrDeviceName
        }
    }
    
    return deviceName
}

/**
 Returns the current OS version as a string (ex. `16.0.1`)
 
 See `getOSVersionAsDbl()` if you want a number returned instead.
 
 */
func getOSVersion() -> String {
    #if os(macOS)
    return ProcessInfo.processInfo.operatingSystemVersionString
    #elseif os(watchOS)
    return WKInterfaceDevice.current().systemVersion
    #else
    return UIDevice.current.systemVersion
    #endif
}

/// Returns the current OS version as a double.
func getOSVersionAsDbl() -> Double {
    let OSVerString = getOSVersion()
    let myDouble = Double(OSVerString) ?? 0.00
    
    return myDouble
}

/**
 Returns `true` if the device is running any version of iOS prior to what is specified when called (eg. `17.0.2`)
 */
func isPreiOSVersion(majorVersion: Int, minorVersion: Int, patchVersion: Int) -> Bool {
    
    #if os(iOS)
    if (ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: majorVersion, minorVersion: minorVersion, patchVersion: patchVersion))) {
        return false
    } else {
        return true
    }
    
    #else
    return false
    
    #endif
}

/// Returns the device name as a string (ex. `iPad Pro (12.9-inch) (2nd generation)`)
func getDeviceModel() -> String {
    return DeviceInfo.modelName
}

/**
 Returns the current battery level as an integer from `0` to `100`
 
 - Warning: Returns `-1` if running on tvOS or desktop macOS (those shits have no battery)
 */
func getBatteryLevel() -> Int {
    //terrible place to put this
    #if os(tvOS)
    return -1
    
    #elseif os(macOS)
    // from https://stackoverflow.com/a/34571839
    guard let snapshot = IOPSCopyPowerSourcesInfo()?.takeRetainedValue() else { return 0 }
    guard let sources: NSArray = IOPSCopyPowerSourcesList(snapshot)?.takeRetainedValue() else { return 0 }
    for ps in sources {
        guard let info: NSDictionary = IOPSGetPowerSourceDescription(snapshot, ps as CFTypeRef)?.takeUnretainedValue() else { return 0 }

        if let capacity = info[kIOPSCurrentCapacityKey] as? Int {
            return capacity
        }
    }
    // Stop using this on desktops!
    return -1
    #elseif os(watchOS)
    WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
    defer { WKInterfaceDevice.current().isBatteryMonitoringEnabled = false }
    return Int(WKInterfaceDevice.current().batteryLevel * 100)
    #else
    UIDevice.current.isBatteryMonitoringEnabled = true
    defer { UIDevice.current.isBatteryMonitoringEnabled = false }
    return Int(UIDevice.current.batteryLevel * 100)
    //returns a value from 0 to 100
    #endif
}

/**
 Returns whether the battery level is critical. (0 - 20%)
 */
func isCritical() -> Bool {
    return (0...20).contains(getBatteryLevel())
}

/**
 Indicates whether the device has a battery. This is a computed property, as we only need to check once.
 */
let hasBattery = {
    return getBatteryLevel() != -1
}()

/**
 Returns the current battery level as a string (ex. `100%`). Mainly to reduce duplicating the -1 handling

 # Usage
 ```
 if (standalone) {
     return hasBattery ? "\(batteryLevel)%" : connectedString.capitalized
 } else if (prefix) {
     return hasBattery ? "has \(batteryLevel)% battery" : "is \(connectedString.lowercased())"
 } else {
     return hasBattery ? "\(batteryLevel)% battery" : connectedString
 }
 ```
 */
func getBatteryPercentage(standalone: Bool = false, prefix: Bool = false) -> String {
    /* Return values:
       About page (true, false): 0%/Connected To Power
       Webhook with custom name (false, true): has 0% battery/is connected to power
       Webhook without custom name (false, false): 0% battery/Connected to power
     */

    let connectedString = "Connected to power"

    assert(!(standalone && prefix), "getBatteryPercentage() cannot be standalone and have a prefix at the same time")

    let batteryLevel = getBatteryLevel()
    if (standalone) {
        return hasBattery ? "\(batteryLevel)%" : connectedString.capitalized
    } else if (prefix) {
        return hasBattery ? "has \(batteryLevel)% battery" : "is \(connectedString.lowercased())"
    } else {
        return hasBattery ? "\(batteryLevel)% battery" : connectedString
    }
}
