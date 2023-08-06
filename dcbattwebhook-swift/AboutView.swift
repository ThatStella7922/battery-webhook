//
//  AboutView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            VStack {

                Form {
                    Section(header: Text("Info"), footer: Text("Battery Webhook - send your battery info to popular services using webhooks!")) {
                        Text(prodName).font(.title)
                        Text("Version " + version + " - by ThatStella7922")
                    }
                    
                    
                    Section(header: Text("ThatStella7922's Links")) {
                        Link("Website", destination: URL(string: "https://thatstel.la")!)
                        Link("Twitter", destination: URL(string: "https://twitter.com/ThatStella7922")!)
                        Link("GitHub", destination: URL(string: "https://github.com/ThatStella7922")!)
                    }
                    
                    Section(header: Text("Battery Webhook Source Code"), footer: Text("Contributions, issue creation, finding reasons to yell at me, etc. All on the project's GitHub repository.")) {
                        Link("View Source on GitHub", destination: URL(string: "https://github.com/ThatStella7922/dcbattwebhook-swift")!)
                    }
                    
                    Section(header: Text("Fruity"), footer: Text("Eva's initial reaction to this amazing and definitely not poorly written + unnecessary app :s2badass:")) {
                        Image("sirishortcut")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 400)
                        Link("my wife Eva's website", destination: URL(string: "https://crystall1ne.dev")!)
                    }
                    
                    //DEBUG SECTION
                    //Comment it out for non debug builds
                    Section(header: Text("Debug Information"), footer: Text("Shows info about the current environment to see if underlying functions work before pushing any info to a webhook. This section uses the same functions as the webhook data constructors.")) {
                        Text("Battery Level: " + String(getBatteryLevel()) + "%")
                        Text("Device Model: " + getDeviceModel())
                        Text("Device Name: " + (getDeviceUserDisplayName() != getSystemReportedDeviceUserDisplayName() ? "\(getDeviceUserDisplayName()) (system reported \(getSystemReportedDeviceUserDisplayName()))" : getDeviceUserDisplayName()))
                        Text("OS Version: " + getOSVersion())
                        Text("Saved Date: " + GetCurrentDateFormatted())
                        Text("Time Since Saved Date: " + GetTimeSinceSavedDateAsFmtedStr())
                        
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
                            Label("Reset All Settings", systemImage: "trash")
                        }
                        
                    }
                }
                #if os(macOS)
                .formStyle(.grouped)
                #endif
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
