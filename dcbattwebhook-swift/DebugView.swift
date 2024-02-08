//
//  DebugView.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 12/11/23.
//

import SwiftUI

struct DebugView: View {
    @State private var powerField: String = ""
    @State private var devModelField: String = ""
    @State private var devNameField: String = ""
    @State private var osVerField: String = ""
    @State private var savedDateField: String = ""
    @State private var automationSavedDateField: String = ""
    @State private var timeSinceSavedDateField: String = ""
    @State private var timeSinceAutomationSavedDateField: String = ""
    @State private var dataContainerPath: String = ""
    @State private var dummyFilePath: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Debug Information"), footer: Text("Shows info about the current environment to see if underlying functions work before pushing any info to a webhook. This section uses the same functions as the webhook data constructors.")) {
                Text(powerField)
                Text("Device Model: " + devModelField)
                Text("Device Name: " + devNameField)
                Text("OS Version: " + osVerField)
                Text("Saved Date: " + savedDateField)
                Text("Saved Date for Automations: " + automationSavedDateField)
                Text("Time Since Saved Date: " + timeSinceSavedDateField)
                Text("Time Since Automation Saved Date: " + timeSinceAutomationSavedDateField)
                ScrollView(.horizontal) {Text("Data container path: " + dataContainerPath).fixedSize(horizontal: true, vertical: false)}
                ScrollView(.horizontal) {Text("Dummy file path: " + dummyFilePath).fixedSize(horizontal: true, vertical: false)}
                
                // save current date button
                Button {
                    SaveCurrentDate()
                    savedDateField = GetSavedDateFormatted()
                    timeSinceSavedDateField = GetTimeSinceSavedDateAsFmtedStr()
                } label: {
                    Label("Save Current Date", systemImage: "square.and.arrow.down")
                }
                
                Button {
                    SaveAutomationCurrentDate()
                    automationSavedDateField = GetAutomationSavedDateFormatted()
                    timeSinceAutomationSavedDateField = GetTimeSinceAutomationSavedDateAsFmtedStr()
                } label: {
                    Label("Save Current Date for Automations", systemImage: "square.and.arrow.down")
                }
                
                Button {
                    ResetSettings()
                } label: {
                    Label("Reset Legacy Container Settings", systemImage: "trash")
                }
                Button {
                    ResetSettingsShared()
                    SaveCurrentDate()
                } label: {
                    Label("Reset Shared Container Settings", systemImage: "trash")
                }
                Button {
                    UndoEnsureSharedSettings()
                } label: {
                    Label("Queue Legacy->Shared Settings Container Migration", systemImage: "arrow.right.doc.on.clipboard")
                }
            }
        }.onAppear() {
            powerField = (hasBattery ? "Battery Level: " : "Power Info: ") + getBatteryPercentage(standalone: true)
            devModelField = getDeviceModel()
            devNameField = (getDeviceUserDisplayName() != getSystemReportedDeviceUserDisplayName() ? "\(getDeviceUserDisplayName()) (system reported: \"\(getSystemReportedDeviceUserDisplayName())\")" : getDeviceUserDisplayName())
            osVerField = getOSVersion()
            savedDateField = GetSavedDateFormatted()
            automationSavedDateField = GetAutomationSavedDateFormatted()
            timeSinceSavedDateField = GetTimeSinceSavedDateAsFmtedStr()
            timeSinceAutomationSavedDateField = GetTimeSinceAutomationSavedDateAsFmtedStr()
            dataContainerPath = String(describing: GetDataContainerPath())
            dummyFilePath = String(describing: BuildFilePathInDataContainer(fileName: "DummyFile", fileExtension: "txt"))
        }
        #if os(macOS)
        .formStyle(.grouped)
        #endif
    }
}
