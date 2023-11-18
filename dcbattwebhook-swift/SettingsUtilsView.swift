//
//  SettingsUtilsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/17/23.
//

import SwiftUI

struct SettingsUtilsView: View {
    var body: some View {
        Section(header: Text("Settings Utilities"), footer: Text("If you suspect you have an invalid configuration or simply want to start fresh.")) {
            Button {
                ResetAllSettings()
                SaveCurrentDate()
            } label: {
                Label("Reset All Settings", systemImage: "trash")
            }
            
            /*if #available(iOS 16, watchOS 9, *) {
                ShareLink(item: Nothing) {
                        Label("Export Settings As File", systemImage: "square.and.arrow.up")
                }
            }*/

        }
    }
}
