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
            //save the current date if one is not already saved
            if defaults.object(forKey: "SavedDate") == nil {
                SaveCurrentDate()
            }
            
            //automations will be shortcuts based :fr:
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
