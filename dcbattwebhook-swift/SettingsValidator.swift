//
//  SettingsValidator.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/11/22.
//

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
    
    if let webhookUrl = defaults.string(forKey: "WebhookURL") {
        webhookurl = webhookUrl
    }
    
    if let userpfpURL = defaults.string(forKey: "UserpfpUrl") {
        userpfpurl = userpfpURL
    }
    
    if let usrName = defaults.string(forKey: "UsrName") {
        usrname = usrName
    }
    
    if let usrPronoun = defaults.string(forKey: "UsrPronoun") {
        usrpronoun = usrPronoun
    }
    
    showpfp = defaults.bool(forKey: "ShowPfp")
    
    showpronoun = defaults.bool(forKey: "ShowPronoun")
    // the above loads user preferences into vars for use
    
    
    if ((showpfp == false) && (showpronoun == false)) {
        // if showpfp and showpronoun are disabled
        if ((webhookurl.isEmpty) && (usrname.isEmpty)) {
            // if the webhook url and username are empty
            returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nPlease fix this in Settings."
            returnErr = true
        }
        else if ((webhookurl.isEmpty) && (!usrname.isEmpty)) {
            // if the webhook url is empty but username isn't
            returnErrMsg = "You haven't specified a Discord webhook URL. \nPlease fix this in Settings."
            returnErr = true
        }
        else if ((!webhookurl.isEmpty) && (!usrname.isEmpty)) {
            // if the webhook url is empty but username isn't
            returnErrMsg = "You haven't specified a display name. \nPlease fix this in Settings."
            returnErr = true
        }
    }
    
    else if ((showpfp == true) && (showpronoun == true)) {
        // if showpfp and showpronoun are enabled
        if ((usrpronoun.isEmpty) && (userpfpurl.isEmpty)) {
            // if pronoun and pfp url are empty
            if ((webhookurl.isEmpty) && (usrname.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((!webhookurl.isEmpty) && (usrname.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl.isEmpty) && (!usrname.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((!webhookurl.isEmpty) && (!usrname.isEmpty)) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun and pfp url empty
        
        else if ((usrpronoun == "") && (userpfpurl != "")) {
            // if pronoun is empty
            if ((webhookurl == "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun empty and prp url being filled
        
        else if ((!usrpronoun.isEmpty) && (userpfpurl.isEmpty)) {
            // if pfp url is empty
            if ((webhookurl.isEmpty) && (usrname.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url empty and pronoun filled
        
        else if ((usrpronoun != "") && (userpfpurl != "")) {
            // if neither are empty
            if ((webhookurl == "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url empty and pronoun filled
        
    }//end of showpfp+showpronoun enabled statements
    
    
    else if ((showpfp == true) && (showpronoun == false)) {
        // if showpfp true and showpronoun false
        if (userpfpurl == "") {
            // if pfp url is empty
            if ((webhookurl == "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nAdditionally, you enabled showing an avatar image but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a display name.\nAdditionally, you enabled showing an avatar image but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nAdditionally, you enabled showing an avatar image but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image but didn't specify an avatar image URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url empty
        
        else if (userpfpurl != "") {
            // if pfp url is filled
            if ((webhookurl == "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url being filled
    }
    
    else if ((showpfp == false) && (showpronoun == true)) {
        // if showpfp false and showpronoun true
        if (usrpronoun == "") {
            // if pronoun is empty
            if ((webhookurl == "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun empty
        
        else if (usrpronoun != "") {
            // if pronoun is filled
            if ((webhookurl == "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun being filled
    }
    
    return(returnErr, returnErrMsg)
}
