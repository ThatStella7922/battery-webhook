//
//  HomeUI.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import SwiftUI
import Foundation

struct ErrorAlertStruct: Identifiable {
    var id: String { msg }
    let msg: String
    let title: String
}

struct HomeUIView: View {
    @State private var errAlert: ErrorAlertStruct?
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Webhook")){
                    Button {
                        let isSettingsValid = ValidateSettings()
                        
                        if (isSettingsValid.err == true) {
                            errAlert = ErrorAlertStruct(msg: isSettingsValid.errMsg, title: "Error")
                        }
                        else {
                            let ResultsVar = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: false, didHitFullCharge: false)
                            SaveCurrentDate()
                            if (ResultsVar.err) {
                                // See L#58 in SendBatteryInfo.swift, this will never trigger unless that is improved
                                errAlert = ErrorAlertStruct(msg: ResultsVar.errMsg, title: "HTTP Error")
                            }
                            else {
                                errAlert = ErrorAlertStruct(msg: "The battery info was sent.", title: "Success")
                            }

                        }
                    } label: {
                        Label("Send Battery Info Now", systemImage: "paperplane")
                    }
                }
                .alert(item: $errAlert) { error in
                    Alert(title: Text(error.title), message: Text(error.msg), dismissButton: .default(Text("OK"))
                    )
                }
                //preview section
                Section(header: Text("Preview")){
                    Text("not right now")
                }
            }
        }
        .navigationTitle("Home")
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView()
    }
}
