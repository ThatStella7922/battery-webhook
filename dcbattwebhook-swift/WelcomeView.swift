//
//  WelcomeView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/4/23.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Image("icon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 110)
            .padding()
        Text("Welcome to \(prodName)!").font(.title).padding(.bottom).multilineTextAlignment(.center).minimumScaleFactor(0.2)
        Text("Battery Webhook is an app that lets you send your battery info to popular services using webhooks.").padding(.bottom).multilineTextAlignment(.center)
        Text("To use it, you'll need to configure Battery Webhook with a webhook to push to, as well as filling out some basic info on how you would like to appear to the webhook (such as a display name)").multilineTextAlignment(.center)
    }
}

struct WelcomeViewNoIcon: View {
    var body: some View {
        Text("Welcome to \(prodName)!").font(.title).padding(.bottom).multilineTextAlignment(.center).minimumScaleFactor(0.2)
        Text("Battery Webhook is an app that lets you send your battery info to popular services using webhooks.").padding(.bottom).multilineTextAlignment(.center)
        Text("To use it, you'll need to configure Battery Webhook with a webhook to push to, as well as filling out some basic info on how you would like to appear to the webhook (such as a display name)").multilineTextAlignment(.center)
    }
}
