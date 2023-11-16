//
//  AboutView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI

struct AboutView: View {
    @State private var powerField: String = ""
    @State private var devModelField: String = ""
    @State private var devNameField: String = ""
    @State private var osVerField: String = ""
    @State private var savedDateField: String = ""
    @State private var timeSinceSavedDateField: String = ""
    
    var body: some View {
        VStack {
            VStack {

                Form {
                    #if os(watchOS)
                    Section(header: Text("Info"), footer: Text("Battery Webhook - send your battery info to popular services using webhooks!")) {
                        VStack {
                            HStack{
                                Image("icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 40)
                                    .padding(.bottom, 5)
                                Text(prodName).font(.title3)
                                    .padding()
                                    .lineLimit(2)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .minimumScaleFactor(0.7)
                            }
                            Text("Version " + version + " - by ThatStella7922").padding(.bottom, 5)
                        }.multilineTextAlignment(.center)
                    }
                    #else
                    Section(header: Text("Info"), footer: Text("Battery Webhook - send your battery info to popular services using webhooks!")) {
                        VStack{
                            Image("icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 80)
                                .padding(.bottom, 5)
                            Text(prodName).font(.title).frame(maxWidth: .infinity, alignment: .center)
                            Text("Version " + version + " - by ThatStella7922").frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    #endif
                    
                    #if os(tvOS) || os(watchOS)
                    EmptyView()
                    #else
                    Section(header: Text("ThatStella7922's Links")) {
                        Link("Website", destination: URL(string: "https://thatstel.la")!)
                        Link("Twitter", destination: URL(string: "https://twitter.com/ThatStella7922")!)
                        Link("GitHub", destination: URL(string: "https://github.com/ThatStella7922")!)
                    }
                    #endif
                    
                    #if os(tvOS) || os(watchOS)
                    Section(header: Text("Battery Webhook on GitHub"), footer: Text("Visit the About page of Battery Webhook from an iOS, iPadOS or macOS device to view the link.")) {
                        Text("Source code, contributions, bug reports, feature requests and more. All on the project's GitHub repository.")
                    }
                    #else
                    Section(header: Text("Battery Webhook on GitHub"), footer: Text("Source code, contributions, bug reports, feature requests and more. All on the project's GitHub repository.")) {
                        Link("View Source on GitHub", destination: URL(string: "https://github.com/ThatStella7922/dcbattwebhook-swift")!)
                    }
                    #endif
                    
                    Section(header: Text("Fruity"), footer: Text("Eva's initial reaction to this amazing and definitely not poorly written + unnecessary app :s2badass:")) {
                        Image("sirishortcut")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 400)
                        
                        #if os(tvOS) || os(watchOS)
                        EmptyView()
                        #else
                        Link("my wife Eva's website", destination: URL(string: "https://crystall1ne.dev")!)
                        #endif
                    }
                    
                    //DEBUG SECTION
                    //Comment it out for non debug builds
                    Section(header: Text("Debug Information"), footer: Text("Shows info about the current environment to see if underlying functions work before pushing any info to a webhook. This section uses the same functions as the webhook data constructors.")) {
                        Text(powerField)
                        Text("Device Model: " + devModelField)
                        Text("Device Name: " + devNameField)
                        Text("OS Version: " + osVerField)
                        Text("Saved Date: " + savedDateField)
                        Text("Time Since Saved Date: " + timeSinceSavedDateField)
                        
                        // save current date button
                        Button {
                            SaveCurrentDate()
                            savedDateField = GetSavedDateFormatted()
                            timeSinceSavedDateField = GetTimeSinceSavedDateAsFmtedStr()
                        } label: {
                            Label("Save Current Date", systemImage: "square.and.arrow.down")
                        }
                        
                        // delete all settings button
                        Button {
                            ResetAllSettings()
                            SaveCurrentDate()
                            savedDateField = GetSavedDateFormatted()
                            timeSinceSavedDateField = GetTimeSinceSavedDateAsFmtedStr()
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
        .onAppear() {
            powerField = (hasBattery() ? "Battery Level: " : "Power Info: ") + getBatteryPercentage(standalone: true)
            devModelField = getDeviceModel()
            devNameField = (getDeviceUserDisplayName() != getSystemReportedDeviceUserDisplayName() ? "\(getDeviceUserDisplayName()) (system reported: \"\(getSystemReportedDeviceUserDisplayName())\")" : getDeviceUserDisplayName())
            osVerField = getOSVersion()
            savedDateField = GetSavedDateFormatted()
            timeSinceSavedDateField = GetTimeSinceSavedDateAsFmtedStr()
        }
        
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
