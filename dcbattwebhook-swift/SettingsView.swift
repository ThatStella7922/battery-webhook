//
//  SettingsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI
import Foundation

struct SettingsView: View {

    @State private var usrName: String = ""
    @State private var usrPronoun: String = ""
    @State private var usrDeviceName: String = getSystemReportedDeviceUserDisplayName()
    @State private var sendDeviceName = true
    @State private var sendDeviceModel = true
    @State private var showPfp = true
    @State private var showPronoun = true
    
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
                    
                    Section(header: Text("Webhook"), footer: Text("Specify the webhook URL and type of service to push to.")) {
                        NavigationLink{WebhookSettingsView()} label: {
                            Label("Webhook Settings", systemImage: "link")
                        }
                    }
                    
                    Section(header: Text("Identity"), footer: Text("Enter a display name, then choose if you want to show your avatar image next to your display name (this requires specifying an 'Avatar Image URL' above).\nYou can also change the device name to be shown. \nYour pronoun will be used primarily in automated sending of battery info (see Automation Settings)")) {
                        TextField(text: $usrName) {
                            Text("Display Name")
                        }.disableAutocorrection(true)
                        
                        TextField(text: $usrPronoun) {
                            Text("Pronoun (his/her/their/etc)")
                        }.disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        TextField(text: $usrDeviceName) {
                            Text("Device Name")
                        }.disableAutocorrection(true)
                        
                        Toggle(isOn: $showPfp) {
                            Text("Show specified avatar image")
                        }
                        
                        Toggle(isOn: $showPronoun) {
                            Text("Show specified pronoun")
                        }
                        
                    }
                    
                    Section(header: Text("Privacy"), footer: Text("You can choose if you want to specify your device's name (\"" + getDeviceUserDisplayName() + "\") and/or model (" + getDeviceModel() + ")")) {
                        Toggle(isOn: $sendDeviceName) {
                            Text("Send Device Name")
                        }
                        
                        Toggle(isOn: $sendDeviceModel) {
                            Text("Send Device Model")
                        }
                    }
                    
                    if (isiOSPre16() == false) {
                        Section(header: Text("iOS/iPadOS 16 Notice")) {
                            Text("On iOS/iPadOS 16 and later, Apple no longer lets developers get the device's name (set in Settings > General > About > Name), which is why your device's name isn't being read. Sorry :(")
                        }
                    }
                }
            }
        }
        .onAppear() {
            if let usrname = defaults.string(forKey: "UsrName") {
                usrName = usrname
            }
            
            if let usrpronoun = defaults.string(forKey: "UsrPronoun") {
                usrPronoun = usrpronoun
            }
            
            sendDeviceName = defaults.bool(forKey: "SendDeviceName")
            
            sendDeviceModel = defaults.bool(forKey: "SendDeviceModel")
            
            showPfp = defaults.bool(forKey: "ShowPfp")
            
            showPronoun = defaults.bool(forKey: "ShowPronoun")
            
            // clear the UsrDeviceName default if its empty
            if defaults.string(forKey: "UsrDeviceName") == "" {
                defaults.removeObject(forKey: "UsrDeviceName")
            }
            
            if let usrdevicename = defaults.string(forKey: "UsrDeviceName") {
                usrDeviceName = usrdevicename
            }
            
            // these if statements read the settings from defaults
        }
        
        .onDisappear {
            defaults.set(usrName, forKey: "UsrName")
            defaults.set(usrPronoun, forKey: "UsrPronoun")
            defaults.set(usrDeviceName, forKey: "UsrDeviceName")
            defaults.set(sendDeviceName, forKey: "SendDeviceName")
            defaults.set(sendDeviceModel, forKey: "SendDeviceModel")
            defaults.set(showPfp, forKey: "ShowPfp")
            defaults.set(showPronoun, forKey: "ShowPronoun")
        }
        
        .navigationTitle("Settings")
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
