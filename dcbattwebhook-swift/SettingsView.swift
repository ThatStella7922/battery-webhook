//
//  SettingsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/10/22.
//

import SwiftUI
import Foundation

struct SettingsView: View {
    
    @State private var webhookurl: String = ""
    @State private var userpfpurl: String = ""
    @State private var usrname: String = ""
    @State private var sendDeviceName = true
    @State private var sendDeviceModel = true
    @State private var showpfp = true
    
    // grab some user defaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            VStack {
                Form {
                    
                    if (isiOSPre16() == true) {
                        Section(header: Text("iOS/iPadOS 15 Notice")) {
                            Text("There is a bug in SwiftUI on iOS/iPadOS 15 that causes the text fields below to not show the saved settings. If you tap on a text field, it shows the saved setting just fine. Anything you input into the fields is still saved and this SwiftUI bug is fixed on iOS/iPadOS 16 and newer.")
                        }
                    }
                    
                    Section(header: Text("URLs"), footer: Text("Paste the URL for your Discord webhook in the first text field, then paste the URL for your Discord avatar image in the second text field.")) {
                        TextField(text: $webhookurl) {
                            Text("Discord Webhook URL")
                                
                                
                        }.keyboardType(.URL)
                            .disableAutocorrection(true)
                        
                        TextField(text: $userpfpurl) {
                            Text("Avatar Image URL (optional)")
                        }.keyboardType(.URL)
                            .disableAutocorrection(true)
                    }
                    
                    
                    Section(header: Text("Identity"), footer: Text("Enter a display name to be shown and choose if you want to show the specified avatar image next to your display name (Requires specifying an 'Avatar Image URL' above)")) {
                        TextField(text: $usrname) {
                            Text("Display Name")
                        }.disableAutocorrection(true)
                        
                        Toggle(isOn: $showpfp) {
                            Text("Show specified avatar image")
                        }
                        
                    }
                    
                    Section(header: Text("Privacy"), footer: Text("You can disable sending your device's name (\"" + getDeviceUserDisplayName() + "\") and/or model (" + getDeviceModel() + "), if you want to.")) {
                        Toggle(isOn: $sendDeviceName) {
                            Text("Send Device Name")
                        }
                        
                        Toggle(isOn: $sendDeviceModel) {
                            Text("Send Device Model")
                        }
                    }
                }
            }
        }
        .onAppear() {
            if UserDefaults.standard.object(forKey: "WebhookURL") != nil {
                webhookurl = defaults.string(forKey: "WebhookURL")!
            }
            
            if UserDefaults.standard.object(forKey: "UserpfpUrl") != nil {
                userpfpurl = defaults.string(forKey: "UserpfpUrl")!
            }
            
            if UserDefaults.standard.object(forKey: "UsrName") != nil {
                usrname = defaults.string(forKey: "UsrName")!
            }
            
            if UserDefaults.standard.object(forKey: "ShowPfp") != nil {
                showpfp = defaults.bool(forKey: "ShowPfp")
            }
            
            if UserDefaults.standard.object(forKey: "SendDeviceName") != nil {
                sendDeviceName = defaults.bool(forKey: "SendDeviceName")
            }
            
            if UserDefaults.standard.object(forKey: "SendDeviceModel") != nil {
                sendDeviceModel = defaults.bool(forKey: "SendDeviceModel")
            }
            // these if statements read the settings from defaults
        }
        
        .onDisappear {
            defaults.set(webhookurl, forKey: "WebhookURL")
            defaults.set(userpfpurl, forKey: "UserpfpUrl")
            defaults.set(usrname, forKey: "UsrName")
            defaults.set(showpfp, forKey: "ShowPfp")
            defaults.set(sendDeviceName, forKey: "SendDeviceName")
            defaults.set(sendDeviceModel, forKey: "SendDeviceModel")
        }
        
        .navigationTitle("Settings")
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
