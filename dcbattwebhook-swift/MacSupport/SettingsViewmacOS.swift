//
//  SettingsViewmacOS.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/15/23.
//

#if os(macOS)
import SwiftUI

struct SettingsViewmacOS: View {
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    @AppStorage("hideMainWindow") private var hideMainWindow = false
    @State private var cannotControlMenuBarExtraVisibility = false
    
    var body: some View {
        
        Section(header: Text("Mac Settings"), footer: Text("These settings affect macOS-specific features of Battery Webhook")) {
            Toggle(isOn: $showMenuBarExtra) {
                HStack{
                    Text("Show Menu Bar Extra:")
                    Image("MenuBarExtra").renderingMode(.template)
                }
            }.disabled(cannotControlMenuBarExtraVisibility)
            
            Toggle(isOn: $hideMainWindow) {
                Text("Hide main window and hide dock icon")
            }.onReceive([self.hideMainWindow].publisher.first()) { (value) in

                if (hideMainWindow) {
                    let _ = NSApplication.shared.setActivationPolicy(.prohibited)
                    showMenuBarExtra = true
                    cannotControlMenuBarExtraVisibility = true
                }
                else {
                    let _ = NSApplication.shared.setActivationPolicy(.regular)
                    cannotControlMenuBarExtraVisibility = false
                    NSApplication.shared.activate(ignoringOtherApps: true)
                }
            }
        }
        
    }
}
#endif
