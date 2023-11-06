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
            let isSettingsValid = ValidateSettings()
            
            if (isSettingsValid.err == true) {
                
                // config error
            }
            else {
                let ResultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: false, didHitFullCharge: false)
                SaveCurrentDate()
                if (ResultsVar.err) {
                    // network error
                }
                else {
                    // success
                }

            }
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
