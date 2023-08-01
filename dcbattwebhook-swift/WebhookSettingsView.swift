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
    
    @State private var webhookurl: String = ""
    @State private var userpfpurl: String = ""
    @State private var notifyMeAbout: String = ""
    
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
                            
                            TextField(text: $webhookurl) {
                                Text("Discord Webhook URL")
                            }
                            #if !os(macOS) && !os(watchOS)
                            .keyboardType(.URL)
                            #endif
                                .disableAutocorrection(true)
                            
                            TextField(text: $userpfpurl) {
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
            if defaults.object(forKey: "WebhookURL") != nil {
                webhookurl = defaults.string(forKey: "WebhookURL")!
            }

            #if os(watchOS)
            if webhookurl.isEmpty && defaults.object(forKey: "WebhookURLFromPhone") != nil {
                webhookurl = defaults.string(forKey: "WebhookURLFromPhone")!
            }
            #endif
            
            if defaults.object(forKey: "UserpfpUrl") != nil {
                userpfpurl = defaults.string(forKey: "UserpfpUrl")!
            }
            
            if defaults.object(forKey: "SelectedServiceType") != nil {
                selectedServiceType = defaults.string(forKey: "SelectedServiceType")!
            }
            
        }.onDisappear {
            defaults.set(webhookurl, forKey: "WebhookURL")
            defaults.set(userpfpurl, forKey: "UserpfpUrl")
            defaults.set(selectedServiceType, forKey: "SelectedServiceType")
            
            #if os(iOS)
            if (WCSession.isSupported()) {
                let session = WCSession.default
                if (session.activationState != .activated) {
                    session.activate()
                }
                do {
                    try session.updateApplicationContext([
                        "WebhookURL": webhookurl
                    ])
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
            #endif
            
        }.navigationTitle("Webhook Settings")
    }
}

struct WebhookSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WebhookSettingsView()
    }
}
