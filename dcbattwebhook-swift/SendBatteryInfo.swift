//
//  SendBatteryInfo.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/10/22.
//

import Foundation

//return bool for failure or pass, then error message as string
func sendInfo(isCurrentlyCharging: Bool, didGetPluggedIn: Bool, didGetUnplugged: Bool, didHitFullCharge: Bool) -> (err: Bool, errMsg: String) {
    
    var userWebhookUrl = ""
    var selectedServiceType = "Discord"
    var fullmessageBlock: Codable
    
    // for returning
    var returnErr = false
    var returnErrMsg = ""
    
    if defaults.object(forKey: "SelectedServiceType") != nil {
        selectedServiceType = defaults.string(forKey: "SelectedServiceType")!
    }
    if defaults.object(forKey: selectedServiceType + "WebhookUrl") != nil {
        userWebhookUrl = defaults.string(forKey: selectedServiceType + "WebhookUrl")!
    }
    
    // Decide how to construct the webhook data based on the selected service
    switch(selectedServiceType) {
    case "Discord":
        fullmessageBlock = ConstructDiscordEmbed(isCurrentlyCharging: isCurrentlyCharging, didGetPluggedIn: didGetPluggedIn, didGetUnplugged: didGetUnplugged, didHitFullCharge: didHitFullCharge)
        
    case "Discord 2":
        fullmessageBlock = ConstructDiscordEmbed(isCurrentlyCharging: isCurrentlyCharging, didGetPluggedIn: didGetPluggedIn, didGetUnplugged: didGetUnplugged, didHitFullCharge: didHitFullCharge)
        
    default:
        // if we can't resolve, return an error to the user.
        returnErr = true
        returnErrMsg = "A fatal error occurred while sending your battery info.\n\"" + selectedServiceType + "\" service type is selected but is not yet supported. Please navigate to Settings -> Webhook Settings to choose a service type from the list."
        return (returnErr, returnErrMsg)
    }
    // this is how we grab the json to throw into the json encoder below, just by calling constructembed
    
    // prep json data
    let jsonEncoder = JSONEncoder()
    let jsonData = try! jsonEncoder.encode(fullmessageBlock)
    
    // if i need to print the encoded json to the console for inspecting later
    //let jsonString = String(data: jsonData, encoding: .utf8)
    
    
    // Scuffed multi-webhook functionality until I properly implement this in Battery Webhook's rewrite
    let webhookUrls = userWebhookUrl.split(separator: "@")
    if (webhookUrls.count == 1) {
        NSLog("Sending to one webhook, because that's normal")
        // our actual post, just once
        let webhookURL = URL(string: webhookUrls[0].trimmingCharacters(in: .whitespacesAndNewlines))! // grab the url
        var request = URLRequest(url: webhookURL) // create a urlrequest object with the grabbed url as the url
        request.httpMethod = "POST" // make it a POST
        request.addValue("application/json", forHTTPHeaderField: "content-type") // make sure its json
        request.httpBody = jsonData // add the prepped json data as the body

        let sem = DispatchSemaphore.init(value: 0)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            defer { sem.signal() }
            guard let data = data, error == nil else {
                returnErr = true
                returnErrMsg = error?.localizedDescription ?? "No data"
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
        
        task.resume()
        sem.wait()
    } else {
        // loop through each url, somehow retaining error handling
        NSLog("Sending to multiple webhooks by looping")
        let sem = DispatchSemaphore.init(value: 0)
        for url in webhookUrls {
            NSLog("Sending to \(url)")
            let webhookURL = URL(string: url.trimmingCharacters(in: .whitespacesAndNewlines))! // grab the url
            var request = URLRequest(url: webhookURL) // create a urlrequest object with the grabbed url as the url
            request.httpMethod = "POST" // make it a POST
            request.addValue("application/json", forHTTPHeaderField: "content-type") // make sure its json
            request.httpBody = jsonData // add the prepped json data as the body
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                defer { sem.signal() }
                guard let data = data, error == nil else {
                    returnErr = true
                    returnErrMsg = returnErrMsg + (error?.localizedDescription ?? "No data")
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    //print(responseJSON)
                    let jsonErrString = String(data: data, encoding: .utf8)
                    returnErr = true
                    returnErrMsg = returnErrMsg + (jsonErrString ?? "there was an error while getting the error text")
                }
            }
            task.resume()
            sem.wait()
        }
    }

    return (returnErr, returnErrMsg)
}
