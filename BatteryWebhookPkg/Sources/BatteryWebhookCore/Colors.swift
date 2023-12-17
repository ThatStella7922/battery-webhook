//
//  Colors.swift
//  BatteryWebhookCore
//
//  Created by Stella Luna on 12/13/23.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public class BatteryWebhookColors {
    #if os(iOS)
    public static func hexToIntColor(inColor: UIColor) -> Int {
        var colors = inColor.cgColor.components // array will contain [r, g, b, a], from 0 to 1 as float
        //Optional([0.9098039215686274, 0.4470588235294118, 0.8862745098039215, 1.0])
        colors!.enumerated().forEach { index, value in
            colors![index] = value * 255
        } // multiplies all values in the array so items are from 0 to 255

        return Int(colors![0] * 65536 + colors![1] * 256 + colors![2]) // multiplies
    }
    #elseif os(macOS)
    public static func hexToIntColor(inColor: NSColor) -> Int {
        var colors = inColor.cgColor.components // array will contain [r, g, b, a], from 0 to 1 as float
        //Optional([0.9098039215686274, 0.4470588235294118, 0.8862745098039215, 1.0])
        colors!.enumerated().forEach { index, value in
            colors![index] = value * 255
        } // multiplies all values in the array so items are from 0 to 255

        return Int(colors![0] * 65536 + colors![1] * 256 + colors![2]) // multiplies
    }
    #endif
}

#if os(iOS)
public extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
#elseif os(macOS)
public extension NSColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 1)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
#endif
