//
//  HomeUI.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/10/22.
//

import SwiftUI
import Foundation

struct ErrorAlertStruct: Identifiable {
    var id: String { msg }
    let msg: String
}

struct HomeUIView: View {
    @State private var errAlert: ErrorAlertStruct?
    @State var showingSettings = false
    
    var body: some View {
        VStack {
            Form{
                /*HStack {
                    Image(systemName: "house.fill")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Home")
                }
                Yea idk if i actually want this here
                */
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
                    Text("preview coming later when i am not lazy!")
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
