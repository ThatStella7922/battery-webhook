//
//  MessageBuilder.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/25/22.
//

import Foundation

// three paramters: did the device just get plugged in, did the device just get unplugged, did the device just hit 100% charge. all in that order
func ConstructDiscordEmbed(isCurrentlyCharging: Bool, didGetPluggedIn: Bool, didGetUnplugged: Bool, didHitFullCharge: Bool) -> MessageObj {
    // empty variables to store user variables into
    var userwebhookurl = ""
    var userpfpurl = ""
    var usrname = ""
    var usrpronoun = ""
    var sendDeviceName = true
    var sendDeviceModel = true
    var showpfp = true
    var showpronoun = true
    // pronoun stuff not used yet (it will be when plugin/unplug detection is added)
    
    // empty variables to work with when constructing
    var workingVar = ""
    var footerBlock = MsgFooter()
    var authorBlock = MsgAuthor()
    var embedBlock = MsgEmbed()
    var batteryField = MsgField(name: "Unknown Device", value: "Unknown battery state", inline: true)
    var timeField = MsgField(name: "Time since last info:", value: "Unknown", inline: true)
    var advertField = MsgField(name: "Sent via:", value: "[Battery Webhook](https://github.com/ThatStella7922/dcbattwebhook-swift) " + version, inline: false)
    var fullmessageBlock = MessageObj()
    var embedColor = 0
    
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
    
    // set our author block right here because this also doesn't change
    authorBlock = MsgAuthor(name: usrname, icon_url: userpfpurl)
    
    /*
    Footer removed in favor of a third field in the embed doing the advert, and it supports linking back to the GitHub!
    See advertField on line 30!
    */
    
    // also set our timeField right here because I think this will just be reusable over and over
    timeField = MsgField(name: "Time since last update:", value: GetTimeSinceSavedDateAsFmtedStr(), inline: true)
    
    
    // ok here we get some logic
    if ((isCurrentlyCharging == false) && (didGetPluggedIn == false) && (didGetUnplugged == false) && (didHitFullCharge == false)) {
        // if we are NOT charging, did NOT get plugged in, did NOT get unplugged, did NOT hit full charge
        if ((sendDeviceName == true) && (sendDeviceModel == true)) {
            // if sending device name and model is ENABLED
            batteryField = MsgField(name: getDeviceModel(), value: (getDeviceUserDisplayName() + " has " + String(describing: getBatteryLevel()) + "% battery"), inline: true)
        }
        if ((sendDeviceName == false) && (sendDeviceModel == false)) {
            // if sending device name and model is DISABLED
            batteryField = MsgField(name: "Device", value: (String(describing: getBatteryLevel()) + "% battery"), inline: true)
        }
        if ((sendDeviceName == true) && (sendDeviceModel == false)) {
            // if sending device name is ENABLED but sending model is DISABLED
            batteryField = MsgField(name: getDeviceUserDisplayName(), value: (String(describing: getBatteryLevel()) + "% battery"), inline: true)
        }
        if ((sendDeviceName == false) && (sendDeviceModel == true)) {
            // if sending device name is DISABLED but sending model is ENABLED
            batteryField = MsgField(name: getDeviceModel(), value: (String(describing: getBatteryLevel()) + "% battery"), inline: true)
        }
    }
    
    // build our embed here, the fields are set above
    embedBlock = MsgEmbed(author: authorBlock, title: "🔋 Device Battery", color: embedColor, fields: [batteryField, timeField, advertField])
    
    // final full message block to be returned
    fullmessageBlock = MessageObj(embeds: [embedBlock])
    return fullmessageBlock
}
