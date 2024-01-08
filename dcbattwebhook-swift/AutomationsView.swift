//
//  AutomationsView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/22/23.
//

import SwiftUI

struct AutomationsView: View {
    @State private var macSendOnPluggedIn = false
    @State private var macSendOnUnplugged = false
    @State private var macSendOnHitFullCharge = false
    @State private var macSendOnAppOpened = false
    
    private var macSendSettings: [Bool] {[
        macSendOnPluggedIn,
        macSendOnUnplugged,
        macSendOnHitFullCharge,
        macSendOnAppOpened
    ]}
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack {
            #if os(macOS)
            Form {
                Section(header: Text("Events"), footer: Text("You can choose to automatically send battery info when one or more of these things happen.\nConfigure Display name, pronoun, etc. in Settings.")) {
                    Text("Send battery info automatically when...")
                    Toggle(isOn: $macSendOnPluggedIn) {
                        Text("This Mac is plugged in")
                        Text("Triggered when this Mac is plugged into external power")
                    }
                    Toggle(isOn: $macSendOnUnplugged) {
                        Text("This Mac is unplugged")
                        Text("Triggered when this Mac is unplugged from external power")
                    }
                    Toggle(isOn: $macSendOnHitFullCharge) {
                        Text("This Mac finishes charging")
                        Text("Triggered when this Mac's battery reaches 100% charge")
                    }
                    Toggle(isOn: $macSendOnAppOpened) {
                        Text("\(prodName) is opened on this Mac")
                        Text("Triggered when the app finishes launching, either manually or when \(prodName) is a login item")
                    }
                }
            }.formStyle(.grouped)
                .onAppear() {
                    if defaults.object(forKey: "MacSendOnPluggedIn") == nil {
                        macSendOnPluggedIn = false
                    } else { macSendOnPluggedIn = defaults.bool(forKey: "MacSendOnPluggedIn") }
                    if defaults.object(forKey: "MacSendOnUnplugged") == nil {
                        macSendOnUnplugged = false
                    } else { macSendOnUnplugged = defaults.bool(forKey: "MacSendOnUnplugged") }
                    if defaults.object(forKey: "MacSendOnHitFullCharge") == nil {
                        macSendOnHitFullCharge = false
                    } else { macSendOnHitFullCharge = defaults.bool(forKey: "MacSendOnHitFullCharge") }
                    
                    macSendOnAppOpened = defaults.bool(forKey: "MacSendOnAppOpened")
                }
                .onDisappear() {
                    defaults.set(macSendOnPluggedIn, forKey: "MacSendOnPluggedIn")
                    defaults.set(macSendOnUnplugged, forKey: "MacSendOnUnplugged")
                    defaults.set(macSendOnHitFullCharge, forKey: "MacSendOnHitFullCharge")
                    defaults.set(macSendOnAppOpened, forKey: "MacSendOnAppOpened")
                }.onChange(of: macSendSettings) {_ in
                    defaults.set(macSendOnPluggedIn, forKey: "MacSendOnPluggedIn")
                    defaults.set(macSendOnUnplugged, forKey: "MacSendOnUnplugged")
                    defaults.set(macSendOnHitFullCharge, forKey: "MacSendOnHitFullCharge")
                    defaults.set(macSendOnAppOpened, forKey: "MacSendOnAppOpened")
                }
            #elseif os(watchOS)
            AutomationsViewNotEligibleView()
            #elseif os(visionOS)
            AutomationsViewNotEligibleView()
            #elseif os(tvOS)
            AutomationsViewNotEligibleView()
            #elseif os(iOS)
            AutomationsViewRequiresShortcutsView()
            #endif
        }.navigationTitle("Automations")
    }
}

struct AutomationsViewNotEligibleView: View {
    
    var body: some View {
        VStack {
            Form {
                VStack{
                    Image(systemName: "exclamationmark.triangle").foregroundStyle(.red).font(.system(size: 30)).padding()
                    Text("This device does not support automations.").frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .onAppear() {
        }
        
    }
}

struct AutomationsViewRequiresShortcutsView: View {
    
    var body: some View {
        VStack {
            Form {
                VStack{
                    Image(systemName: "info.circle").foregroundStyle(.yellow).font(.system(size: 30)).padding()
                    Text("This device does not support in-app automations, but it can use Shortcuts Automations.\n\nPlease see the Help for more details about Shortcuts Automations.").frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .onAppear() {
        }
        
    }
}

struct AutomationsView_Previews: PreviewProvider {
    static var previews: some View {
        AutomationsView()
    }
}
