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
                WelcomeView().padding(.bottom)
                Text("To learn more, you can view the help available below.").multilineTextAlignment(.center)
            }
            NavigationLink(destination: WhatIsAWebhookHelpView(), label: {
                Text("What is a webhook?")
            })
            NavigationLink(destination: WhatIsAWebhookHelpView(), label: {
                Text("What's the use-case for something like this?")
            })
            NavigationLink(destination: WhatIsAWebhookHelpView(), label: {
                Text("How do I create a webhook in Discord?")
            })
            NavigationLink(destination: WhatIsAWebhookHelpView(), label: {
                Text("How do I configure Battery Webhook?")
            })
        }
        #if os(macOS)
        .formStyle(.grouped)
        #endif
        .navigationTitle("Help")
        
    }
}
