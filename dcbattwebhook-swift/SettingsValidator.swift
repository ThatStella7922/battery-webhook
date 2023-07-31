//
//  SettingsValidator.swift
//  dcbattwebhook-swift
//
//  Created by Stella Luna on 11/11/22.
//

import Foundation

private var webhookUrl: String = ""
private var userPfpUrl: String = ""
private var usrName: String = ""
private var usrPronoun: String = ""
private var sendDeviceName = true
private var sendDeviceModel = true
private var showPfp = true
private var showPronoun = true

private let defaults = UserDefaults.standard

/**
 Validates the currently stored settings.
 
 Access `.err` to check if there was an error (bool) and `.errMsg` for what the error was (string).
 */
func ValidateSettings() -> (err: Bool, errMsg: String) {
    // for returning
    var returnErr = false
    var returnErrMsg = ""
    
    if let webhookurl = defaults.string(forKey: "WebhookURL") {
        webhookUrl = webhookurl
    }
    
    if let userpfpurl = defaults.string(forKey: "UserpfpUrl") {
        userPfpUrl = userpfpurl
    }
    
    if let usrname = defaults.string(forKey: "UsrName") {
        usrName = usrname
    }
    
    if let usrpronoun = defaults.string(forKey: "UsrPronoun") {
        usrPronoun = usrpronoun
    }
    
    showPfp = defaults.bool(forKey: "ShowPfp")
    
    showPronoun = defaults.bool(forKey: "ShowPronoun")
    // the above loads user preferences into vars for use
    
    
    if ((showPfp == false) && (showPronoun == false)) {
        // if showpfp and showpronoun are disabled
        if ((webhookUrl.isEmpty) && (usrName.isEmpty)) {
            // if the webhook url and username are empty
            returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nPlease fix this in Settings."
            returnErr = true
        }
        else if ((webhookUrl.isEmpty) && (!usrName.isEmpty)) {
            // if the webhook url is empty but username isn't
            returnErrMsg = "You haven't specified a Discord webhook URL. \nPlease fix this in Settings."
            returnErr = true
        }
        else if ((!webhookUrl.isEmpty) && (usrName.isEmpty)) {
            // if the username is empty but webhook url isn't
            returnErrMsg = "You haven't specified a display name. \nPlease fix this in Settings."
            returnErr = true
        }
    }
    
    else if ((showPfp == true) && (showPronoun == true)) {
        // if showpfp and showpronoun are enabled
        if ((usrPronoun.isEmpty) && (userPfpUrl.isEmpty)) {
            // if pronoun and pfp url are empty
            if ((webhookUrl.isEmpty) && (usrName.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((!webhookUrl.isEmpty) && (usrName.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl.isEmpty) && (!usrName.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((!webhookUrl.isEmpty) && (!usrName.isEmpty)) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun and pfp url empty
        
        else if ((usrPronoun == "") && (userPfpUrl != "")) {
            // if pronoun is empty
            if ((webhookUrl == "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl == "") && (usrName != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image and pronoun, but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun empty and prp url being filled
        
        else if ((!usrPronoun.isEmpty) && (userPfpUrl.isEmpty)) {
            // if pfp url is empty
            if ((webhookUrl.isEmpty) && (usrName.isEmpty)) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl == "") && (usrName != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image and pronoun, but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url empty and pronoun filled
        
        else if ((usrPronoun != "") && (userPfpUrl != "")) {
            // if neither are empty
            if ((webhookUrl == "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl == "") && (usrName != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url empty and pronoun filled
        
    }//end of showpfp+showpronoun enabled statements
    
    
    else if ((showPfp == true) && (showPronoun == false)) {
        // if showpfp true and showpronoun false
        if (userPfpUrl == "") {
            // if pfp url is empty
            if ((webhookUrl == "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nAdditionally, you enabled showing an avatar image but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a display name.\nAdditionally, you enabled showing an avatar image but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl == "") && (usrName != "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nAdditionally, you enabled showing an avatar image but didn't specify an avatar image URL. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing an avatar image but didn't specify an avatar image URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url empty
        
        else if (userPfpUrl != "") {
            // if pfp url is filled
            if ((webhookUrl == "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl == "") && (usrName != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pfp url being filled
    }
    
    else if ((showPfp == false) && (showPronoun == true)) {
        // if showpfp false and showpronoun true
        if (usrPronoun == "") {
            // if pronoun is empty
            if ((webhookUrl == "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl == "") && (usrName != "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName != "")) {
                // if webhook url and username are NOT empty
                returnErrMsg = "You have enabled showing a pronoun but didn't specify a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun empty
        
        else if (usrPronoun != "") {
            // if pronoun is filled
            if ((webhookUrl == "") && (usrName == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl != "") && (usrName == "")) {
                // if webhook url is NOT empty but username is empty
                returnErrMsg = "You haven't specified a display name.\nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookUrl == "") && (usrName != "")) {
                // if webhook url is empty but username is NOT empty
                returnErrMsg = "You haven't specified a Discord webhook URL.\nPlease fix this in Settings."
                returnErr = true
            }
        }//end of checks for pronoun being filled
    }
    
    return(returnErr, returnErrMsg)
}
