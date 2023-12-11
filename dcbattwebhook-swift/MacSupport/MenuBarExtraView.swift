//
//  MenuBarExtraView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/4/23.
//

import SwiftUI

#if os(macOS)
struct MenuBarExtraView: View {
    @AppStorage("shouldDisableMenuItem") private var shouldDisableMenuItem = true
    @AppStorage("hideMainWindow") private var hideMainWindow = false
    
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
            .disabled(shouldDisableMenuItem)
        
        Divider()
        
        Button(action: {
            hideMainWindow = false
            let _ = NSApplication.shared.setActivationPolicy(.regular)
            NSApplication.shared.activate(ignoringOtherApps: true)
        }, label: {
            Text("Unhide Main Window and Dock Icon")
            Image(systemName: "macwindow")
        }).disabled(!hideMainWindow)
        
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
