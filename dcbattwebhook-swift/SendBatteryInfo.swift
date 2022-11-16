//
//  SendBatteryInfo.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/10/22.
//

/*
 TODO:
 - add handling for user pronoun and show pronoun
   - make sure to add support in SettingsValidator
 */

import Foundation

//return bool for failure or pass, then error message as string
func http() -> (err: Bool, errMsg: String) {
    
    //Struct for the json contents
    struct MsgAuthor: Codable {
        var name: String?
        var icon_url: String?
    }

    struct MsgEmbed: Codable {
        var author: MsgAuthor?
        var footer: MsgFooter?
        var title: String?
        var description: String?
        var color: Int?
    }
    
    struct MsgFooter: Codable {
        var text: String?
        var icon_url: String?
    }

    struct MessageObj: Codable {
        var embeds: [MsgEmbed]?
        var contents: String?
    }
    
    //print("button fired")
    var userwebhookurl = ""
    var userpfpurl = ""
    var usrname = ""
    var showpfp = true
    var sendDeviceName = true
    var sendDeviceModel = true
    var workingVar = ""
    var footerBlock: MsgFooter
    var authorBlock: MsgAuthor
    var embedBlock: MsgEmbed
    var fullmessageBlock: MessageObj
    var embedColor = 0
    
    // for returning
    var returnErr = false
    var returnErrMsg = ""
    
    // color red or e872e2 depending on if we are <=20% battery
    if (getBatteryLevel() <= 20) {
        embedColor = 16711680
    }
    else {
        embedColor = 15233762
    }
    
    // get our info
    let defaults = UserDefaults.standard
    if UserDefaults.standard.object(forKey: "WebhookURL") != nil {
        userwebhookurl = defaults.string(forKey: "WebhookURL")!
    }
    
    if UserDefaults.standard.object(forKey: "UserpfpUrl") != nil {
        userpfpurl = defaults.string(forKey: "UserpfpUrl")!
    }
    
    if UserDefaults.standard.object(forKey: "UsrName") != nil {
        usrname = defaults.string(forKey: "UsrName")!
    }
    
    if UserDefaults.standard.object(forKey: "ShowPfp") != nil {
        showpfp = defaults.bool(forKey: "ShowPfp")
    }
    
    if UserDefaults.standard.object(forKey: "SendDeviceName") != nil {
        sendDeviceName = defaults.bool(forKey: "SendDeviceName")
    }
    
    if UserDefaults.standard.object(forKey: "SendDeviceModel") != nil {
        sendDeviceModel = defaults.bool(forKey: "SendDeviceModel")
    }

    // set these so we can work on them
    authorBlock = MsgAuthor()
    footerBlock = MsgFooter()
    embedBlock = MsgEmbed()
    fullmessageBlock = MessageObj()
    
    // shit ass logic to send a certain embed depending on user settings
    // see comments inside ifs
    if ((sendDeviceModel == true) && (sendDeviceName == true) && (showpfp == true)) {
        // if deviceModel, deviceName, and pfp are to be sent
        workingVar = (getDeviceUserDisplayName() + " (" + getDeviceModel() + ") has " + String(describing: getBatteryLevel()) + "% battery remaining")
        var msgFooterText = ("Sent from " + prodName + " v" + String(describing: version))
        
        footerBlock = MsgFooter(text: msgFooterText)
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, footer: footerBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    else if ((sendDeviceModel == false) && (sendDeviceName == true) && (showpfp == true)) {
        // if device name and pfp are to be sent - do NOT send model
        workingVar = (getDeviceUserDisplayName() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
        
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    else if ((sendDeviceModel == true) && (sendDeviceName == false) && (showpfp == true)) {
        // if device model and pfp are to be sent - do NOT send device name
        workingVar = (getDeviceModel() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
        
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    else if ((sendDeviceModel == false) && (sendDeviceName == false) && (showpfp == true)) {
        // if only pfp is to be sent - do NOT send device model or device name
        workingVar = ("Device has " + String(describing: getBatteryLevel()) + "% battery remaining")
        
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    else if ((sendDeviceModel == true) && (sendDeviceName == true) && (showpfp == false)) {
        // if deviceModel and deviceName are to be sent - do NOT send pfp
        workingVar = (getDeviceUserDisplayName() + " (" + getDeviceModel() + ") has " + String(describing: getBatteryLevel()) + "% battery remaining")
        userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
        
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    else if ((sendDeviceModel == false) && (sendDeviceName == true) && (showpfp == false)) {
        // if device name is to be sent - do NOT send model or pfp
        workingVar = (getDeviceUserDisplayName() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
        userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
        
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    else if ((sendDeviceModel == true) && (sendDeviceName == false) && (showpfp == false)) {
        // if device model is to be sent - do NOT send device name or pfp
        workingVar = (getDeviceModel() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
        userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
        
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    else if ((sendDeviceModel == false) && (sendDeviceName == false) && (showpfp == false)) {
        // if no info is to be sent - do NOT send device model device name or pfp
        workingVar = ("Device has " + String(describing: getBatteryLevel()) + "% battery remaining")
        userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
        
        authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
        embedBlock = MsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
        fullmessageBlock = MessageObj(embeds: [embedBlock], contents: "")
    }
    
    // prep json data
    let jsonEncoder = JSONEncoder()
    let jsonData = try! jsonEncoder.encode(fullmessageBlock)
    
    // if i need to print the encoded json to the console for inspecting later
    //let jsonString = String(data: jsonData, encoding: .utf8)
    //print("broken ahh json: " + jsonString!)
    
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
    
    //print("posted (or attempted to). if error occurred then it will be below:")
    task.resume()
    
    // i need to figure out how to get the updated returnErr bool and returnErrMsg out of the `task` because right now
    // the values i set from in there dont actually get returned below.
    return (returnErr, returnErrMsg)
}
