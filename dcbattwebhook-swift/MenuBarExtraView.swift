//
//  MenuBarExtraView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/4/23.
//

import SwiftUI

#if os(macOS)
struct MenuBarExtraView: View {
    var body: some View {
        Button(action: {
            sendInfo(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: false, didHitFullCharge: false)
            SaveCurrentDate()
        }, label: {
            Text("Send Battery Info Now")
            Image(systemName: "paperplane")
        }).keyboardShortcut("s", modifiers: [.command, .shift])
        
        Divider()

        Button(action: {
            NSApplication.shared.terminate(nil)
        }, label: {
            Text("Quit \(prodName)")
            Image(systemName: "power")
        })
    }
}
#endif
