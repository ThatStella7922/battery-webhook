//
//  SettingsValidator.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/11/22.
//

/*
 TODO:
 - add handling for user pronoun and show pronoun settings
   - the settings view already supports saving and loading them
 */

import Foundation

private var webhookurl: String = ""
private var userpfpurl: String = ""
private var usrname: String = ""
private var usrpronoun: String = ""
private var sendDeviceName = true
private var sendDeviceModel = true
private var showpfp = true
private var showpronoun = true

private let defaults = UserDefaults.standard

func ValidateSettings() -> (err: Bool, errMsg: String) {
    // for returning
    var returnErr = false
    var returnErrMsg = ""
    
    if UserDefaults.standard.object(forKey: "WebhookURL") != nil {
        webhookurl = defaults.string(forKey: "WebhookURL")!
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
    
    if UserDefaults.standard.object(forKey: "ShowPronoun") != nil {
        showpronoun = defaults.bool(forKey: "ShowPronoun")
    }
    
    if ((webhookurl == "") && (usrname == "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you haven't specified an avatar image URL even though you chose to use an avatar image. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname == "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        returnErrMsg = "You haven't specified a display name. \nAdditionally, you haven't specified an avatar image URL even though you chose to use an avatar image. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname == "") && (showpfp == true && userpfpurl != "") && (showpfp == true)) {
        returnErrMsg = "You haven't specified a display name. Please specify one in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname != "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you haven't specified an avatar image URL even though you chose to use an avatar image. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname != "") && (showpfp == true && userpfpurl != "") && (showpfp == true)) {
        returnErrMsg = "You haven't specified a Discord webhook URL. Please specify one in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname == "") && (showpfp == true && userpfpurl != "") && (showpfp == true)) {
        // if webhook and displayname are empty, but userpfpurl is filled and showpfp enabled
        returnErrMsg = "You haven't specified a Discord webhook URL or a display name. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname != "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        returnErrMsg = "You haven't specified an avatar image URL though you chose to use an avatar image. Please specify one or choose not to use an avatar in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname == "") && (showpfp == false)) {
        returnErrMsg = "You haven't specified a Discord webhook URL or a display name. Please specify them in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname != "") && (showpfp == false)) {
        returnErrMsg = "You haven't specified a Discord webhook URL. Please specify one in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname == "") && (showpfp == false)) {
        returnErrMsg = "You haven't specified a display name. Please specify one in the settings."
        returnErr = true
    }
    
    return(returnErr, returnErrMsg)
}
