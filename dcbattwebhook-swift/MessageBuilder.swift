//
//  MessageBuilder.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/25/22.
//

import Foundation

// three paramters: did the device just get plugged in, did the device just get unplugged, did the device just hit 100% charge. all in that order
func ConstructDiscordEmbed(isCurrentlyCharging: Bool, didGetPluggedIn: Bool, didGetUnplugged: Bool, didHitFullCharge: Bool) -> DiscordMessageObj {
    var isAutomated = false
    var automationVerb = ""
    if (isCurrentlyCharging || didGetPluggedIn || didGetUnplugged || didHitFullCharge ) {
        isAutomated = true
    }
    
    // empty variables to store user variables into
    var selectedServiceType = "Discord"
    
    var userWebhookUrl = ""
    var userPfpUrl = ""
    var usrName = ""
    var usrPronoun = "their"
    var sendDeviceName = true
    var sendDeviceModel = true
    var showPfp = true
    var showPronoun = true
    // pronoun stuff not used yet (it will be when plugin/unplug detection is added)
    
    // empty variables to work with when constructing
    var footerBlock = DiscordFooter()
    var authorBlock = DiscordAuthor()
    var embedBlock = DiscordEmbed()
    var batteryField = DiscordEmbedField(name: "Unknown Device", value: "Unknown battery state", inline: true)
    var timeField = DiscordEmbedField(name: "Time since last update:", value: "Unknown", inline: true)
    var automationTimeField = DiscordEmbedField(name: "Time since last update:", value: "Unknown", inline: true)
    let advertField = DiscordEmbedField(name: "Sent via:", value: "[Battery Webhook](https://github.com/ThatStella7922/dcbattwebhook-swift) " + versionBase, inline: false)
    var fullmessageBlock = DiscordMessageObj()
    var embedColor = 0
    
    // get our info from settings
    let defaults = UserDefaults.standard
    
    // This handles the 'Discord 2' and 'Discord' services
    if defaults.object(forKey: "SelectedServiceType") != nil {
        selectedServiceType = defaults.string(forKey: "SelectedServiceType")!
    }
    if let userwebhookurl = defaults.string(forKey: selectedServiceType + "WebhookUrl") {
        userWebhookUrl = userwebhookurl
    }
    if let userpfpurl = defaults.string(forKey: selectedServiceType + "UserPfpUrl") {
        userPfpUrl = userpfpurl
    }
    
    if let usrname = defaults.string(forKey: "UsrName") {
        usrName = usrname
    }
    if let usrpronoun = defaults.string(forKey: "UsrPronoun") {
        usrPronoun = usrpronoun
    }
    sendDeviceName = defaults.bool(forKey: "SendDeviceName")
    sendDeviceModel = defaults.bool(forKey: "SendDeviceModel")
    showPfp = defaults.bool(forKey: "ShowPfp")
    showPronoun = defaults.bool(forKey: "ShowPronoun")
    
    // end of getting info from settings
    
    
    // set our color variable to red or e872e2 depending on if we are <=20% battery
    // maybe the e872e2 will be changeable by the user later but its such a based color so idk lmao
    if (isCritical()) {
        embedColor = 16711680
    }
    else {
        embedColor = 15233762
    }
    
    // if the user has disabled sending a pfp, manually set it to the generic gray Discord profile picture image
    // 0.png is blurple, 1.png is gray, 2.png is green, 3.png is orange, 4.png is red, 5.png is hot pink
    if (showPfp == false) {
        userPfpUrl = "https://cdn.discordapp.com/embed/avatars/" + String(describing: Int.random(in: 0..<5)) + ".png"
    }
    
    // set our author block right here because this also doesn't change
    authorBlock = DiscordAuthor(name: usrName, icon_url: userPfpUrl)
    
    /*
    Footer removed in favor of a third field in the embed doing the advert, and it supports linking back to the GitHub!
    See advertField on line 30!
    */
    
    // also set our timeField right here because I think this will just be reusable over and over
    timeField = DiscordEmbedField(name: "Time since last update:", value: GetTimeSinceSavedDateAsFmtedStr(), inline: true)
    
    automationTimeField = DiscordEmbedField(name: "Time since last update:", value: GetTimeSinceAutomationSavedDateAsFmtedStr(), inline: true)
    
    
    /*
     isCurrentlyCharging isn't used - yet!
     
     The following logic decides what battery field gets created
     */
    if (isAutomated) {
        if (didGetPluggedIn) {
            // we GOT PLUGGED in
            automationVerb = "plugged in"
            batteryField = DiscordEmbedField(name: "Current battery level:", value: (getBatteryPercentage()), inline: true)
        } else if (didGetUnplugged) {
            // we GOT UNPLUGGED
            automationVerb = "unplugged"
            batteryField = DiscordEmbedField(name: "Current battery level:", value: (getBatteryPercentage()), inline: true)
            
        } else if (didHitFullCharge) {
            automationVerb = "fully charged"
            // device GOT full charge
            batteryField = DiscordEmbedField(name: "Fully charged:", value: (getBatteryPercentage()), inline: true)
            
        } else {
            batteryField = DiscordEmbedField(name: "Current battery level:", value: (getBatteryPercentage()), inline: true)
        }
    } else {
        // if we are NOT charging, did NOT get plugged in, did NOT get unplugged, did NOT hit full charge
        if ((sendDeviceName == true) && (sendDeviceModel == true)) {
            // if sending device name and model is ENABLED
            batteryField = DiscordEmbedField(name: getDeviceModel(), value: (getDeviceUserDisplayName() + " " + getBatteryPercentage(prefix: true)), inline: true)
        }
        if ((sendDeviceName == false) && (sendDeviceModel == false)) {
            // if sending device name and model is DISABLED
            batteryField = DiscordEmbedField(name: "Device", value: getBatteryPercentage(), inline: true)
        }
        if ((sendDeviceName == true) && (sendDeviceModel == false)) {
            // if sending device name is ENABLED but sending model is DISABLED
            batteryField = DiscordEmbedField(name: getDeviceUserDisplayName(), value: getBatteryPercentage(), inline: true)
        }
        if ((sendDeviceName == false) && (sendDeviceModel == true)) {
            // if sending device name is DISABLED but sending model is ENABLED
            batteryField = DiscordEmbedField(name: getDeviceModel(), value: getBatteryPercentage(), inline: true)
        }
    }
    
    var embedTitle = "🔌 Power Info"
    if (hasBattery()) {
        embedTitle = (isCritical() ? "🪫" : "🔋") + " Device Battery"
        
        if (isAutomated) {
            if (["unplugged"].contains(automationVerb)) {
                embedTitle = "🔋 \(usrName) \(automationVerb) \(usrPronoun) \(getDeviceUserDisplayName())"
            } else {
                embedTitle = "⚡️ \(usrName) \(automationVerb) \(usrPronoun) \(getDeviceUserDisplayName())"
            }
        }
    }

    // build our embed here, the fields are set above
    if (isAutomated) {
        embedBlock = DiscordEmbed(title: embedTitle, color: embedColor, fields: [batteryField, automationTimeField, advertField])
    } else {
        embedBlock = DiscordEmbed(author: authorBlock, title: embedTitle, color: embedColor, fields: [batteryField, timeField, advertField])
    }
    
    // final full message block to be returned
    fullmessageBlock = DiscordMessageObj(embeds: [embedBlock])
    return fullmessageBlock
}
