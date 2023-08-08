//
//  AutomationSettingsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/26/22.
//

import SwiftUI

struct AutomationSettingsView: View {
    @State private var sendOnPluggedIn = false
    @State private var sendOnUnplugged = false
    @State private var sendOnHitFullCharge = false
    
    // grab some user defaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            VStack {
                
                Form {
                    Section(header: Text("Events"), footer: Text("You can choose to automatically send battery info when one or more of these things happen.\nYou can change settings like Display name, pronoun, etc. in the regular Settings.")) {
                        Text("Send battery info automatically when...")
                        Toggle(isOn: $sendOnPluggedIn) {
                            Text("Device is plugged in")
                        }
                        Toggle(isOn: $sendOnUnplugged) {
                            Text("Device is unplugged")
                        }
                        Toggle(isOn: $sendOnHitFullCharge) {
                            Text("Device finishes charging")
                        }
                    }
                    
                    Section(header: Text("Automations Notice")) {
                        Text("These automations depend on the app running in the background, so try to avoid force closing it.")
                    }
                }
            }
        }.onAppear() {
            if defaults.object(forKey: "SendOnPluggedIn") != nil {
                sendOnPluggedIn = defaults.bool(forKey: "SendOnPluggedIn")
            }
            
            if defaults.object(forKey: "SendOnUnplugged") != nil {
                sendOnUnplugged = defaults.bool(forKey: "SendOnUnplugged")
            }
            
            if defaults.object(forKey: "SendOnHitFullCharge") != nil {
                sendOnHitFullCharge = defaults.bool(forKey: "SendOnHitFullCharge")
            }
            // these if statements read the settings from defaults
        }
        
        .onDisappear {
            defaults.set(sendOnPluggedIn, forKey: "SendOnPluggedIn")
            defaults.set(sendOnUnplugged, forKey: "SendOnUnplugged")
            defaults.set(sendOnHitFullCharge, forKey: "SendOnHitFullCharge")
        }
        
        .navigationTitle("Automation Settings")
    }
}

struct AutomationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AutomationSettingsView()
    }
}
