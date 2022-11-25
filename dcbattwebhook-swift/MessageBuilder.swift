//
//  MessageBuilder.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/25/22.
//

import Foundation

func ConstructEmbed() -> MessageObj {
    // empty variables to store user variables into
    var userwebhookurl = ""
    var userpfpurl = ""
    var usrname = ""
    var usrpronoun = ""
    var sendDeviceName = true
    var sendDeviceModel = true
    var showpfp = true
    var showpronoun = true
    
    // empty variables to work with when constructing
    var workingVar = ""
    var footerBlock: MsgFooter
    var authorBlock: MsgAuthor
    var embedBlock: MsgEmbed
    var msgField1: MsgField
    var timeField: MsgField
    var fullmessageBlock: MessageObj
    var embedColor = 0
    
    authorBlock = MsgAuthor()
    footerBlock = MsgFooter()
    embedBlock = MsgEmbed()
    fullmessageBlock = MessageObj()
    
    // get our info from settings
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
    
    if UserDefaults.standard.object(forKey: "UsrPronoun") != nil {
        usrpronoun = defaults.string(forKey: "UsrPronoun")!
    }
    
    if UserDefaults.standard.object(forKey: "SendDeviceName") != nil {
        sendDeviceName = defaults.bool(forKey: "SendDeviceName")
    }
    
    if UserDefaults.standard.object(forKey: "SendDeviceModel") != nil {
        sendDeviceModel = defaults.bool(forKey: "SendDeviceModel")
    }
    
    if UserDefaults.standard.object(forKey: "ShowPfp") != nil {
        showpfp = defaults.bool(forKey: "ShowPfp")
    }
    
    if UserDefaults.standard.object(forKey: "ShowPronoun") != nil {
        showpronoun = defaults.bool(forKey: "ShowPronoun")
    }
    // end of getting info from settings
    
    
    // set our color variable to red or e872e2 depending on if we are <=20% battery
    // maybe the e872e2 will be changeable by the user later but its such a based color so idk lmao
    if (getBatteryLevel() <= 20) {
        embedColor = 16711680
    }
    else {
        embedColor = 15233762
    }
    
    // if the user has disabled sending a pfp, manually set it to the generic gray Discord profile picture image
    // 0.png is blurple, 1.png is gray, 2.png is green, 3.png is orange, 4.png is red, 5.png is hot pink
    if (showpfp == false) {
        userpfpurl = "https://cdn.discordapp.com/embed/avatars/1.png"
    }
    
    // set our footer right here as I don't expect to be needing to change it
    footerBlock = MsgFooter(text: "Sent via Battery Webhook (in heavy development)")
    
    // also set our timeField right here because I think this will just be reusable over and over
    timeField = MsgField(name: "Time since last info:", value: GetTimeSinceSavedDateAsFmtedStr(), inline: true)
    
    msgField1 = MsgField(name: getDeviceModel(), value: (String(describing: getBatteryLevel()) + "% battery"), inline: true)
   
    authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
    embedBlock = MsgEmbed(author: authorBlock, footer: footerBlock, title: "🔋 Device Battery", color: embedColor, fields: [msgField1, timeField])
    fullmessageBlock = MessageObj(embeds: [embedBlock])
    
    return fullmessageBlock
}


/*
 // shit ass logic to send a certain embed depending on user settings
 // see comments inside ifs
 if ((sendDeviceModel == true) && (sendDeviceName == true) && (showpfp == true)) {
     // if deviceModel, deviceName, and pfp are to be sent
     workingVar = (getDeviceUserDisplayName() + " (" + getDeviceModel() + ") has " + String(describing: getBatteryLevel()) + "% battery remaining")
     var msgFooterText = ("Sent from " + prodName + " v" + String(describing: version))
     
     footerBlock = OldMsgFooter(text: msgFooterText)
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, footer: footerBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 else if ((sendDeviceModel == false) && (sendDeviceName == true) && (showpfp == true)) {
     // if device name and pfp are to be sent - do NOT send model
     workingVar = (getDeviceUserDisplayName() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
     
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 else if ((sendDeviceModel == true) && (sendDeviceName == false) && (showpfp == true)) {
     // if device model and pfp are to be sent - do NOT send device name
     workingVar = (getDeviceModel() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
     
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 else if ((sendDeviceModel == false) && (sendDeviceName == false) && (showpfp == true)) {
     // if only pfp is to be sent - do NOT send device model or device name
     workingVar = ("Device has " + String(describing: getBatteryLevel()) + "% battery remaining")
     
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 else if ((sendDeviceModel == true) && (sendDeviceName == true) && (showpfp == false)) {
     // if deviceModel and deviceName are to be sent - do NOT send pfp
     workingVar = (getDeviceUserDisplayName() + " (" + getDeviceModel() + ") has " + String(describing: getBatteryLevel()) + "% battery remaining")
     userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
     
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 else if ((sendDeviceModel == false) && (sendDeviceName == true) && (showpfp == false)) {
     // if device name is to be sent - do NOT send model or pfp
     workingVar = (getDeviceUserDisplayName() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
     userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
     
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 else if ((sendDeviceModel == true) && (sendDeviceName == false) && (showpfp == false)) {
     // if device model is to be sent - do NOT send device name or pfp
     workingVar = (getDeviceModel() + " has " + String(describing: getBatteryLevel()) + "% battery remaining")
     userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
     
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 else if ((sendDeviceModel == false) && (sendDeviceName == false) && (showpfp == false)) {
     // if no info is to be sent - do NOT send device model device name or pfp
     workingVar = ("Device has " + String(describing: getBatteryLevel()) + "% battery remaining")
     userpfpurl = "https://cdn.discordapp.com/embed/avatars/0.png"
     
     authorBlock = OldMsgAuthor(name: usrname, icon_url: userpfpurl)
     embedBlock = OldMsgEmbed(author: authorBlock, title: "Device Battery", description: workingVar, color: embedColor)
     fullmessageBlock = OldMessageObj(embeds: [embedBlock], contents: "")
 }
 */
