//
//  ContentView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("shouldDisableMenuItem") private var shouldDisableMenuItem = true
    
    @State private var isShowingHome = false
    @State private var isShowingSettings = false
    @State private var isShowingHelp = false
    @State private var isShowingWelcomeSheet = false
    
    // grab some user defaults
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            #if os(tvOS)
            TabView {
                HomeUIView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
                AutomationsView()
                    .tabItem {
                        Label("Automations", systemImage: "gearshape.2")
                    }
                HelpView()
                    .tabItem {
                        Label("Help", systemImage: "questionmark.circle")
                    }
                AboutView()
                    .tabItem {
                        Label("About", systemImage: "person.circle")
                    }
            }
            #else
            NavigationView {
                List() {
                    NavigationLink(destination: HomeUIView(), isActive: $isShowingHome, label: {
                        Label("Home", systemImage: "house")
                    })
                    NavigationLink(destination: SettingsView(), isActive: $isShowingSettings, label: {
                        Label("Settings", systemImage: "gearshape")
                    })
                    NavigationLink{AutomationsView()} label: {
                        Label("Automations", systemImage: "gearshape.2")
                    }
                    NavigationLink(destination: HelpView(), isActive: $isShowingHelp, label: {
                        Label("Help", systemImage: "questionmark.circle")
                    })
                    NavigationLink{AboutView()} label: {
                        Label("About", systemImage: "person.circle")
                    }
                }
                .navigationTitle(prodName)
                
                #if os(macOS)
                EmptyView()
                #endif
            }
            #endif
        }.onAppear() {
            if defaults.bool(forKey: "IsFirstLaunch") == false {
                DoAppFirstTimeLaunch()
                self.isShowingSettings = true
                self.isShowingWelcomeSheet = true
            }
            
            // Automatically show Home view and enable menu item if settings are valid
            // If invalid, automatically show Settings view and disable menu item
            if (!ValidateSettings().err) {
                self.isShowingHome = true
                shouldDisableMenuItem = false
            } else {
                self.isShowingSettings = true
                shouldDisableMenuItem = true
            }
            
        }.sheet(isPresented: $isShowingWelcomeSheet, content: {
            VStack{
                #if !os(watchOS)
                WelcomeView()
                Text("You can do so in the Settings page, where you can configure that info and various other options to customize your experience. ").padding(.top)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                Button {
                    self.isShowingWelcomeSheet = false
                } label: {
                    Text("Get Started").font(.title3)
                }.padding(.top)
                #else
                WelcomeViewWatch()
                #endif
            }.padding()
                #if os(macOS)
                .frame(minWidth: 650, maxWidth: 850, minHeight: 450, maxHeight: 450)
                #endif
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
