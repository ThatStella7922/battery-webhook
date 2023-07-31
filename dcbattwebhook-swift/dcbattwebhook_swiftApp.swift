//
//  dcbattwebhook_swiftApp.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI

public let prodName = "Battery Webhook"

#if os(tvOS)
public let version = "1.0b35 on tvOS"
#else
public let version = "1.0b35"
#endif

@main
struct dcbattwebhook_swiftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            .onAppear {
            }
        }
    }
}
