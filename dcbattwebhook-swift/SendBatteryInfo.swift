//
//  SendBatteryInfo.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/10/22.
//

import Foundation

//return bool for failure or pass, then error message as string
func http() -> (err: Bool, errMsg: String) {
    
    var userwebhookurl = ""
    
    // for returning
    var returnErr = false
    var returnErrMsg = ""
    
    // get our info
    let defaults = UserDefaults.standard
    if UserDefaults.standard.object(forKey: "WebhookURL") != nil {
        userwebhookurl = defaults.string(forKey: "WebhookURL")!
    }
    
    let fullmessageBlock = ConstructEmbed()
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
