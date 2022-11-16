//
//  ContentView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/10/22.
//

import SwiftUI

struct ContentView: View {
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
            if UserDefaults.standard.object(forKey: "SavedDate") == nil {
                print("no date saved, saving!")
                SaveCurrentDate()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
