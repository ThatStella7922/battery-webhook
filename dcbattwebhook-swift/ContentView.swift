//
//  ContentView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    
    // grab some user defaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    NavigationLink{HomeUIView()} label: {
                        Label("Home", systemImage: "house")
                    }
                    NavigationLink{SettingsView()} label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                    /*NavigationLink{AutomationSettingsView()} label: {
                        Label("Automation Settings", systemImage: "gearshape.2")
                    }*/
                    NavigationLink{AboutView()} label: {
                        Label("About", systemImage: "person.circle")
                    }
                }
                .navigationTitle(prodName)
                
                VStack {
                    Image(systemName: "globe")
                        .padding(.top)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text(prodName)
                }
            }
        }.onAppear() {
            /*var sendOnPluggedIn = false
            var sendOnUnplugged = false
            var sendOnHitFullCharge = false*/
            
            if UserDefaults.standard.object(forKey: "SavedDate") == nil {
                //print("no date saved, saving!")
                SaveCurrentDate()
            }
            //save the current date if one is not already saved
            
            /*if UserDefaults.standard.object(forKey: "SendOnPluggedIn") != nil {
                sendOnPluggedIn = defaults.bool(forKey: "SendOnPluggedIn")
            }
            if UserDefaults.standard.object(forKey: "SendOnUnplugged") != nil {
                sendOnUnplugged = defaults.bool(forKey: "SendOnUnplugged")
            }
            if UserDefaults.standard.object(forKey: "SendOnHitFullCharge") != nil {
                sendOnHitFullCharge = defaults.bool(forKey: "SendOnHitFullCharge")
            }
            // these if statements read the settings from defaults
            
            if ((sendOnPluggedIn == true) || (sendOnUnplugged == true) || (sendOnHitFullCharge == true)) {
                // if any of the automations are enabled
                UIDevice.current.isBatteryMonitoringEnabled = true
                
                //finish adding shit here, use notificationcenter to catch events or some shit idk
            }*/
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
