//
//  WebhookSettingsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/29/22.
//

import SwiftUI

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
                            }.keyboardType(.URL)
                                .disableAutocorrection(true)
                            
                            TextField(text: $userpfpurl) {
                                Text("Avatar Image URL (optional)")
                            }.keyboardType(.URL)
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
            if UserDefaults.standard.object(forKey: "WebhookURL") != nil {
                webhookurl = defaults.string(forKey: "WebhookURL")!
            }
            
            if UserDefaults.standard.object(forKey: "UserpfpUrl") != nil {
                userpfpurl = defaults.string(forKey: "UserpfpUrl")!
            }
            
            if UserDefaults.standard.object(forKey: "SelectedServiceType") != nil {
                selectedServiceType = defaults.string(forKey: "SelectedServiceType")!
            }
            
        }.onDisappear {
            defaults.set(webhookurl, forKey: "WebhookURL")
            defaults.set(userpfpurl, forKey: "UserpfpUrl")
            defaults.set(selectedServiceType, forKey: "SelectedServiceType")
            
        }.navigationTitle("Webhook Settings")
    }
}

struct WebhookSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        WebhookSettingsView()
    }
}
