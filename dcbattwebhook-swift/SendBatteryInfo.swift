//
//  SendBatteryInfo.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import Foundation

//return bool for failure or pass, then error message as string
func sendInfo(isCurrentlyCharging: Bool, didGetPluggedIn: Bool, didGetUnplugged: Bool, didHitFullCharge: Bool) -> (err: Bool, errMsg: String) {
    
    var userwebhookurl = ""
    var selectedServiceType = ""
    var fullmessageBlock = MessageObj()
    
    // for returning
    var returnErr = false
    var returnErrMsg = ""
    
    // get our info
    let defaults = UserDefaults.standard
    if UserDefaults.standard.object(forKey: "WebhookURL") != nil {
        userwebhookurl = defaults.string(forKey: "WebhookURL")!
    }
    
    if UserDefaults.standard.object(forKey: "SelectedServiceType") != nil {
        selectedServiceType = defaults.string(forKey: "SelectedServiceType")!
    }
    
    switch(selectedServiceType) {
    case "Discord":
        fullmessageBlock = ConstructDiscordEmbed(isCurrentlyCharging: false, didGetPluggedIn: false, didGetUnplugged: false, didHitFullCharge: false)
        
    default:
        fullmessageBlock = MessageObj(contents: "brokey")
        //todo: better validate this
    }
    // this is how we grab the json to throw into the json encoder below, just by calling constructembed
    
    // prep json data
    let jsonEncoder = JSONEncoder()
    let jsonData = try! jsonEncoder.encode(fullmessageBlock)
    
    // if i need to print the encoded json to the console for inspecting later
    let jsonString = String(data: jsonData, encoding: .utf8)
    print("broken ahh json: " + jsonString!)
    
    // our actual post
    let webhookURL = URL(string: userwebhookurl)! // grab the url from user settings
    var request = URLRequest(url: webhookURL) // create a urlrequest object with the grabbed url as the url
    request.httpMethod = "POST" // make it a POST
    request.addValue("application/json", forHTTPHeaderField: "content-type") // make sure its json
    request.httpBody = jsonData // add the prepped json data as the body
    
    // no idea what this shit does but it works rofl
    // update 07/30/2023 I might know what this does but i need time to mess with it
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            //print(responseJSON)
            let jsonErrString = String(data: data, encoding: .utf8)
            returnErr = true
            returnErrMsg = jsonErrString ?? "there was an error while getting the error text"
        }
    }
    
    print("posted (or attempted to). if error occurred then it will be below:")
    task.resume()
    
    // i need to figure out how to get the updated returnErr bool and returnErrMsg out of the `task` because right now
    // the values i set from in there dont actually get returned below.
    return (returnErr, returnErrMsg)
}
