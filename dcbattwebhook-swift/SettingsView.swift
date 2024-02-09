//
//  SettingsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI
import Foundation
#if os(iOS) || os(watchOS)
import WatchConnectivity
#endif

struct SettingsView: View {
    var serviceTypes = ["Discord", "Discord 2"]
    @State private var selectedServiceType = "Discord"
    
    @AppStorage("shouldDisableMenuItem") private var shouldDisableMenuItem = true
    
    @State private var webhookUrl: String = ""
    @State private var userPfpUrl: String = ""
    @State private var replaceWebhookAvatarAndName = false
    @State private var showDisplayNameAndAvatarInEmbedWhenAutomated = false
    
    @State private var usrName: String = ""
    @State private var usrPronoun: String = ""
    @State private var usrDeviceName: String = getSystemReportedDeviceUserDisplayName()
    @State private var sendDeviceName = true
    @State private var sendDeviceModel = true
    @State private var showPfp = true
    @State private var showPronoun = true
    
    var body: some View {
        VStack {
            VStack {
                Form {
                    if (isPreiOSVersion(majorVersion: 16, minorVersion: 0, patchVersion: 0) == true) {
                        Section(header: Text("iOS/iPadOS 15 Notice")) {
                            Text("There is a bug in SwiftUI on iOS/iPadOS 15 that causes the text fields below to not show the saved settings. If you tap on a text field, it shows the saved setting just fine. Anything you input into the fields is still saved and this SwiftUI bug is fixed on iOS/iPadOS 16 and newer.")
                        }
                    }
                    
                    Section(header: Text("Webhook"), footer: Text("Specify the webhook URL and type of service to push to.")) {
                        
                        Picker("Webhook Service Type", systemImage: "link", selection: $selectedServiceType) {
                            ForEach(serviceTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    switch(selectedServiceType) {
                    case "Discord":
                        Section(header: Text("Discord URLs"), footer: Text("A Discord webhook. Paste the URL for your Discord webhook in the first text field, then paste the URL for your Discord avatar image in the second text field.")) {
                            
                            TextField("Discord Webhook URL", text: $webhookUrl)
                            #if !os(macOS) && !os(watchOS)
                            .keyboardType(.URL)
                            #endif
                                .disableAutocorrection(true)
                            
                            TextField("Avatar Image URL (optional)", text: $userPfpUrl)
                            #if !os(macOS) && !os(watchOS)
                            .keyboardType(.URL)
                            #endif
                                .disableAutocorrection(true)
                            
                            Toggle(isOn: $showDisplayNameAndAvatarInEmbedWhenAutomated) {
                                Text("Show display name & avatar in the battery info when automated")
                            }
                            
                            Toggle(isOn: $replaceWebhookAvatarAndName) {
                                Text("Override the webhook's preset avatar & name with my own")
                            }
                            
                        }
                    
                    case "Discord 2":
                        Section(header: Text("Discord 2 URLs"), footer: Text("A second instance of a Discord webhook. Paste the URL for your Discord webhook in the first text field, then paste the URL for your Discord avatar image in the second text field.")) {
                            
                            TextField("Discord Webhook URL", text: $webhookUrl)
                            #if !os(macOS) && !os(watchOS)
                            .keyboardType(.URL)
                            #endif
                                .disableAutocorrection(true)
                            
                            TextField("Avatar Image URL (optional)", text: $userPfpUrl)
                            #if !os(macOS) && !os(watchOS)
                            .keyboardType(.URL)
                            #endif
                                .disableAutocorrection(true)
                            
                            Toggle(isOn: $showDisplayNameAndAvatarInEmbedWhenAutomated) {
                                Text("Show display name & avatar in the battery info when automated")
                            }
                            
                            Toggle(isOn: $replaceWebhookAvatarAndName) {
                                Text("Override the webhook's preset avatar & name with my own")
                            }
                        }
                        
                    default:
                        Section(){
                            HStack{
                                Image(systemName: "x.circle")
                                Text("The \"" + selectedServiceType + "\" service isn't supported yet.")
                            }
                        }
                    }
                    
                    Section(header: Text("Identity"), footer: Text("Enter a display name, then choose if you want to show the specified avatar image next to your display name.\nYou can also change the shown device name. \nYour pronoun will be used primarily in automated sending of battery info, and if disabled we will default to using 'their'.")) {
                        
                        #if os(iOS) || os(visionOS)
                        HStack {
                            Text("Display Name:")
                            TextField("Display Name", text: $usrName).disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                        }
                        #else
                        TextField("Display Name", text: $usrName).disableAutocorrection(true)
                        #endif
                        
                        
                        #if os(iOS) || os(visionOS)
                        HStack {
                            Text("Pronoun:")
                            TextField("Pronoun (her/his/xir/etc)", text: $usrPronoun).disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                                #if !os(macOS) && !os(watchOS)
                                .autocapitalization(.none)
                                #endif
                        }
                        #else
                        TextField("Pronoun (her/his/xir/etc)", text: $usrPronoun).disableAutocorrection(true)
                            #if !os(macOS) && !os(watchOS)
                            .autocapitalization(.none)
                            #endif
                        #endif
                        
                        #if os(iOS) || os(visionOS)
                        HStack {
                            Text("Device Name:")
                            TextField("Device Name", text: $usrDeviceName).disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                        }
                        #else
                        TextField(text: $usrDeviceName, prompt: {
                            #if os(macOS)
                            Text(getSystemReportedDeviceUserDisplayName())
                            #else
                            nil
                            #endif
                        }()) {
                            Text("Device Name")
                        }.disableAutocorrection(true)
                        #endif
                        
                        Toggle(isOn: $showPfp) {
                            Text("Show specified avatar image")
                        }
                        
                        Toggle(isOn: $showPronoun) {
                            Text("Show specified pronoun")
                        }
                        
                    }
                    
                    Section(header: Text("Privacy"), footer: Text("Choose whether to include your device's name (\"\(getDeviceUserDisplayName())\") and/or model (\(getDeviceModel())) in the sent battery info.")) {
                        Toggle(isOn: $sendDeviceName) {
                            Text("Send Device Name")
                        }
                        
                        Toggle(isOn: $sendDeviceModel) {
                            Text("Send Device Model")
                        }
                    }
                    
                    #if os(iOS)
                    if (isPreiOSVersion(majorVersion: 16, minorVersion: 0, patchVersion: 0) == false) {
                        iOSPre16NoticeView()
                    }
                    #endif
                    
                    #if os(macOS)
                    SettingsViewmacOS()
                    #endif
                    
                    SettingsUtilsView()
                    
                }
                #if os(macOS)
                .formStyle(.grouped)
                #endif
            }
        }
        .onAppear() {
            if let usrname = defaults.string(forKey: "UsrName") {
                usrName = usrname
            }
            if let usrpronoun = defaults.string(forKey: "UsrPronoun") {
                usrPronoun = usrpronoun
            }
            
            
            if defaults.object(forKey: "SendDeviceName") == nil {
                sendDeviceName = true
            } else { sendDeviceName = defaults.bool(forKey: "SendDeviceName") }
            if defaults.object(forKey: "SendDeviceModel") == nil {
                sendDeviceModel = true
            } else { sendDeviceModel = defaults.bool(forKey: "SendDeviceModel") }
            
            showPfp = defaults.bool(forKey: "ShowPfp")
            showPronoun = defaults.bool(forKey: "ShowPronoun")
            
            // clear the UsrDeviceName default if its empty
            if defaults.string(forKey: "UsrDeviceName") == "" {
                defaults.removeObject(forKey: "UsrDeviceName")
            }
            
            if let usrdevicename = defaults.string(forKey: "UsrDeviceName") {
                usrDeviceName = usrdevicename
            }
            
            if let selectedservicetype = defaults.string(forKey: "SelectedServiceType") {
                selectedServiceType = selectedservicetype
            }
            
            if let webhookurl = defaults.string(forKey: selectedServiceType + "WebhookUrl") {
                webhookUrl = webhookurl
            }
        
            if let userpfpurl = defaults.string(forKey: selectedServiceType + "UserPfpUrl") {
                userPfpUrl = userpfpurl
            }
            
            replaceWebhookAvatarAndName = defaults.bool(forKey: selectedServiceType + "ReplaceWebhookAvatarAndName")
            showDisplayNameAndAvatarInEmbedWhenAutomated = defaults.bool(forKey: selectedServiceType + "ShowDisplayNameAndAvatarInEmbedWhenAutomated")
            
            // these if statements read the settings from defaults
        }
        
        .onDisappear {
            defaults.set(selectedServiceType, forKey: "SelectedServiceType")
            defaults.set(webhookUrl, forKey: selectedServiceType + "WebhookUrl")
            defaults.set(userPfpUrl, forKey: selectedServiceType + "UserPfpUrl")
            defaults.set(replaceWebhookAvatarAndName, forKey: selectedServiceType + "ReplaceWebhookAvatarAndName")
            defaults.set(showDisplayNameAndAvatarInEmbedWhenAutomated, forKey: selectedServiceType + "ShowDisplayNameAndAvatarInEmbedWhenAutomated")
            
            defaults.set(usrName, forKey: "UsrName")
            defaults.set(usrPronoun, forKey: "UsrPronoun")
            defaults.set(usrDeviceName, forKey: "UsrDeviceName")
            defaults.set(sendDeviceName, forKey: "SendDeviceName")
            defaults.set(sendDeviceModel, forKey: "SendDeviceModel")
            defaults.set(showPfp, forKey: "ShowPfp")
            defaults.set(showPronoun, forKey: "ShowPronoun")
            
            if ValidateSettings().err {
                shouldDisableMenuItem = true
            } else {
                shouldDisableMenuItem = false
            }

            #if os(iOS)
            if (WCSession.isSupported()) {
                let session = WCSession.default
                if (session.activationState != .activated) {
                    session.activate()
                }
                do {
                    try session.updateApplicationContext([
                        selectedServiceType + "WebhookUrl": webhookUrl,
                        selectedServiceType + "UserPfpUrl": userPfpUrl,
                        "SelectedServiceType": selectedServiceType
                    ])
                } catch {
                    print("Unexpected error: \(error).")
                }
            }
            #endif
        }.navigationTitle("Settings")
            .onChange(of: selectedServiceType) {_ in
                // get the old service type and save those old values
                if let selectedservicetype = defaults.string(forKey: "SelectedServiceType") {
                    defaults.set(webhookUrl, forKey: selectedservicetype + "WebhookUrl")
                    defaults.set(userPfpUrl, forKey: selectedservicetype + "UserPfpUrl")
                    defaults.set(replaceWebhookAvatarAndName, forKey: selectedservicetype + "ReplaceWebhookAvatarAndName")
                    defaults.set(showDisplayNameAndAvatarInEmbedWhenAutomated, forKey: selectedservicetype + "ShowDisplayNameAndAvatarInEmbedWhenAutomated")
                }
                
                // once done save the new selected service type
                defaults.set(selectedServiceType, forKey: "SelectedServiceType")
                
                // pull the new values for the new and show them
                if let webhookurl = defaults.string(forKey: selectedServiceType + "WebhookUrl") {
                    webhookUrl = webhookurl
                }
                if let userpfpurl = defaults.string(forKey: selectedServiceType + "UserPfpUrl") {
                    userPfpUrl = userpfpurl
                }
                
                replaceWebhookAvatarAndName = defaults.bool(forKey: selectedServiceType + "ReplaceWebhookAvatarAndName")
                showDisplayNameAndAvatarInEmbedWhenAutomated = defaults.bool(forKey: selectedServiceType + "ShowDisplayNameAndAvatarInEmbedWhenAutomated")
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
