//
//  ContentView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingHome = false
    @State private var isShowingSettings = false
    @State private var isShowingHelp = false
    @State private var isShowingWelcomeSheet = false
    
    // grab some user defaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            NavigationView {
                List() {
                    NavigationLink(destination: HomeUIView(), isActive: $isShowingHome, label: {
                        Label("Home", systemImage: "house")
                    })
                    NavigationLink(destination: SettingsView(), isActive: $isShowingSettings, label: {
                        Label("Settings", systemImage: "gearshape")
                    })
                    NavigationLink(destination: HelpView(), isActive: $isShowingHelp, label: {
                        Label("Help", systemImage: "questionmark.circle")
                    })
                    NavigationLink{AboutView()} label: {
                        Label("About", systemImage: "person.circle")
                    }
                }
                .navigationTitle(prodName)
                
                VStack {
                    WelcomeView()
                    Button {
                        self.isShowingSettings = true
                    } label: {
                        Text("Configure Battery Webhook")
                    }.padding(.top)
                }.frame(maxWidth: 600)
                #if os(macOS)
                    .padding()
                #endif
            }
        }.onAppear() {
            if defaults.bool(forKey: "IsFirstLaunch") == false {
                DoAppFirstTimeLaunch()
                #if os(macOS) || os(watchOS)
                //nothing
                #else
                switch UIDevice.current.userInterfaceIdiom {
                    case .phone: self.isShowingWelcomeSheet = true
                    case .pad: self.isShowingWelcomeSheet = false
                    default: self.isShowingWelcomeSheet = false
                }
                #endif
            }
            
            //save the current date if one is not already saved
            if defaults.object(forKey: "SavedDate") == nil {
                SaveCurrentDate()
            }
            
            // Automatically show Home view if settings are valid
            if (!ValidateSettings().err) {
                self.isShowingHome = true
            }
            
            //automations will be shortcuts based :fr:
        }.sheet(isPresented: $isShowingWelcomeSheet, content: {
            VStack{
                WelcomeView().padding(.bottom)
                Text("You can do so in the Settings page, where you can configure that info and various other options to customize your experience. ").padding(.bottom)
                    .multilineTextAlignment(.center)
                Button {
                    self.isShowingWelcomeSheet = false
                } label: {
                    Text("Get Started").font(.title3)
                }
            }.padding()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
