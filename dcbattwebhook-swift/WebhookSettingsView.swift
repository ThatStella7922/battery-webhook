//
//  WebhookSettingsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/29/22.
//

import SwiftUI
#if os(iOS) || os(watchOS)
import WatchConnectivity
#endif


struct WebhookSettingsView: View {
    var serviceTypes = ["Discord"]
    @State private var selectedServiceType = "Discord"
    
    @State private var webhookUrl: String = ""
    @State private var userPfpUrl: String = ""
    
    // grab some user defaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            VStack {
                Form {
                    
                    Picker("Webhook Service Type", selection: $selectedServiceType) {
                        ForEach(serviceTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    switch(selectedServiceType) {
                    case "Discord":
                        Section(header: Text("Discord URLs"), footer: Text("Paste the URL for your Discord webhook in the first text field, then paste the URL for your Discord avatar image in the second text field.\nYou can also paste any other URL that leads to a 1024x1024 or smaller PNG/GIF for your avatar image.")) {
                            
                            TextField(text: $webhookUrl) {
                                Text("Discord Webhook URL")
                            }
                            #if !os(macOS) && !os(watchOS)
                            .keyboardType(.URL)
                            #endif
                                .disableAutocorrection(true)
                            
                            TextField(text: $userPfpUrl) {
                                Text("Avatar Image URL (optional)")
                            }
                            #if !os(macOS) && !os(watchOS)
                            .keyboardType(.URL)
                            #endif
                                .disableAutocorrection(true)
                            
                        }
                        
                    default:
                        Section(){
                            HStack{
                                Image(systemName: "x.circle")
                                Text("An error ocurred while figuring out what service is selected.")
                            }
                        }
                    }
                }
            }
        }.onAppear() {
            if defaults.object(forKey: "SelectedServiceType") != nil {
                selectedServiceType = defaults.string(forKey: "SelectedServiceType")!
            }
            
            if defaults.object(forKey: selectedServiceType + "WebhookUrl") != nil {
                webhookUrl = defaults.string(forKey: selectedServiceType + "WebhookUrl")!
            }
            
            if defaults.object(forKey: selectedServiceType + "UserPfpUrl") != nil {
                userPfpUrl = defaults.string(forKey: selectedServiceType + "UserPfpUrl")!
            }
        }.onDisappear {
            defaults.set(selectedServiceType, forKey: "SelectedServiceType")
            defaults.set(webhookUrl, forKey: selectedServiceType + "WebhookUrl")
            defaults.set(userPfpUrl, forKey: selectedServiceType + "UserPfpUrl")
            
            #if os(iOS)
            if (WCSession.isSupported()) {
                let session = WCSession.default
                if (session.activationState != .activated) {
                    session.activate()
                }
                do {
                    try session.updateApplicationContext([
                        "WebhookUrl": webhookUrl,
                        "UserPfpUrl": userPfpUrl,
                        "SelectedServiceType": selectedServiceType
                    ])
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
            #endif
        }.navigationTitle("Webhook Settings")
            .onChange(of: selectedServiceType) { _ in
                print("GRUNKLER TYPE:" + selectedServiceType)
            }
    }
}

struct WebhookSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WebhookSettingsView()
    }
}
