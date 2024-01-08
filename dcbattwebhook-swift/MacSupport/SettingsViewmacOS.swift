//
//  SettingsViewmacOS.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/15/23.
//

#if os(macOS)
import SwiftUI
import ServiceManagement

struct SettingsViewmacOS: View {
    @AppStorage("showMenuBarExtra") private var showMenuBarExtra = true
    @AppStorage("hideMainWindow") private var hideMainWindow = false
    @AppStorage("launchAtLogin") private var launchAtLogin = false
    @State private var cannotControlMenuBarExtraVisibility = false
    
    @State private var showingLaunchAtLoginErrorAlert = false
    @State private var errAlert: ErrorAlertStruct?
    
    var body: some View {
        
        Section(header: Text("Mac Settings"), footer: Text("These settings affect macOS-specific features of Battery Webhook")) {
            Toggle(isOn: $launchAtLogin) {
                Text("Automatically launch \(prodName) when logging in")
                Text("If you use automations, enabling this is recommended so \(prodName) is always running and ready to send battery info")
            }.alert(item: $errAlert) { error in
                Alert(title: Text(error.title), message: Text(error.msg), dismissButton: .default(Text("OK"))
                )
            }.onChange(of: launchAtLogin) {_ in
                if (launchAtLogin) {
                    do {
                        if SMAppService.mainApp.status == .enabled {
                            errAlert = ErrorAlertStruct(msg: "Launching at login is already enabled for your user account!", title: "Error")
                        } else {
                            try SMAppService.mainApp.register()
                        }
                    } catch {
                        errAlert = ErrorAlertStruct(msg: "Could not register \(prodName) to launch at login: \(error.localizedDescription)", title: "Error")
                    }
                } else {
                    do {
                        try SMAppService.mainApp.unregister()
                    } catch {
                        errAlert = ErrorAlertStruct(msg: "Could not unregister \(prodName) from launching at login: \(error.localizedDescription)\nHas it already been unregistered?", title: "Error")
                    }
                }
            }
            
            Toggle(isOn: $showMenuBarExtra) {
                HStack{
                    Text("Show Menu Bar Extra:")
                    Image("MenuBarExtra").renderingMode(.template)
                }
                Text("Allows controlling \(prodName) from a minimal UI in the menu bar")
            }.disabled(cannotControlMenuBarExtraVisibility)
            
            Toggle(isOn: $hideMainWindow) {
                Text("Hide main window and the dock icon")
                Text("Offers the most minimal \(prodName) experience, showing only the Menu Bar Extra")
                Text("Combining this option with launching on login is highly recommended")
            }.onChange(of: hideMainWindow) {_ in
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
