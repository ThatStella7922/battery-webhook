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
                            errAlert = ErrorAlertStruct(msg: isSettingsValid.errMsg)
                        }
                        else {
                            _ = sendInfo(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: false, didHitFullCharge: false)
                            SaveCurrentDate()
                            //print(ResultsVar.self)
                            //error = ErrorInfo(id: 1, title: "HTTP Error:", description: "error: " + ResultsVar.errMsg)
                            //print("button fired with no errors")
                        }
                    } label: {
                        Label("Send Battery Info", systemImage: "paperplane")
                    }
                }
                .alert(item: $errAlert) { error in
                    Alert(title: Text("Error"), message: Text(error.msg), dismissButton: .default(Text("OK"))
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
