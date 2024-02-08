//
//  HelpView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/5/23.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        Form{
            VStack{
                WelcomeViewNoIcon().padding(.bottom)
                Text("To learn more about how Battery Webhook works, how to configure it, automate it and much more, visit the online documentation.").multilineTextAlignment(.center)
            }
            Link("Open Documentation", destination: URL(string: "https://docs.thatstel.la/battery-webhook")!)
        }
        #if os(macOS)
        .formStyle(.grouped)
        #endif
        .navigationTitle("Documentation")
        
    }
}
