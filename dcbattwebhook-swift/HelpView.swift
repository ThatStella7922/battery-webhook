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
            List() {
                NavigationLink(destination: WhatIsAWebhookHelpView(), label: {
                    Text("What is a webhook?")
                })
            }
        }.navigationTitle("Help")
    }
}
