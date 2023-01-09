//
//  AboutView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/10/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            VStack {

                Form {
                    Section(header: Text("Info"), footer: Text("Battery Webhook, intended for use with Discord webhooks.")) {
                        Text(prodName).font(.title)
                        Text("By ThatStella7922")
                        Text("Version: " + version)
                    }
                    
                    
                    Section(header: Text("ThatStella7922's Links"), footer: Text("hell yes!")) {
                        Link("Website", destination: URL(string: "https://thatsniceguy.com")!)
                        Link("Twitter", destination: URL(string: "https://twitter.com/ThatStella7922")!)
                        Link("Reddit", destination: URL(string: "https://www.reddit.com/user/ThatStella7922")!)
                        Link("GitHub", destination: URL(string: "https://github.com/ThatStella7922")!)
                        Link("my oomfie ellie's twitter", destination: URL(string: "https://twitter.com/crystall1nedev")!)
                        
                        /*HStack {
                            Text("Agree to our")
                            Link("terms of Service", destination: URL(string: "https://www.example.com/TOS.html")!)
                        }*/
                    }
                    
                    Section(header: Text("user reviews"), footer: Text("Ellie's honest reaction to this amazing and definitely not poorly written app :s2badass:")) {
                        Image("sirishortcut")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 400)
                    }
                    
                    //DEBUG SECTION
                    //Comment it out for non debug builds
                    Section(header: Text("Debug"), footer: Text("Some info to tell if underlying functions work before sending. This section will not be present on release versions.")) {
                        Text("Battery Level: " + String(getBatteryLevel()) + "%")
                        Text("Device Model: " + getDeviceModel())
                        Text("Device Name: " + getDeviceUserDisplayName())
                        Text("OS Version: " + getOSVersion())
                        Text("Saved Date: " + GetCurrentDateFormatted())
                        Text("Time Passed Since Saved Date: " + GetTimeSinceSavedDateAsFmtedStr())
                        
                        // save current date button
                        Button {
                            SaveCurrentDate()
                        } label: {
                            Label("Save Current Date", systemImage: "square.and.arrow.down")
                        }
                        
                        // delete all settings button
                        Button {
                            ResetAllSettings()
                        } label: {
                            Label("Reset all settings", systemImage: "trash")
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
