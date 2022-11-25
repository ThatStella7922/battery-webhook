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
    
    if UserDefaults.standard.object(forKey: "ShowPfp") != nil {
        showpfp = defaults.bool(forKey: "ShowPfp")
    }
    
    if UserDefaults.standard.object(forKey: "ShowPronoun") != nil {
        showpronoun = defaults.bool(forKey: "ShowPronoun")
    }
    // the above loads user preferences into vars for use
    
    
    if ((showpfp == false) && (showpronoun == false)) {
        // if showpfp and showpronoun are disabled
        if ((webhookurl == "") && (usrname == "")) {
            // if the webhook url and username are empty
            returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nPlease fix this in Settings."
            returnErr = true
        }
        else if ((webhookurl == "") && (usrname != "")) {
            // if the webhook url is empty but username isn't
            returnErrMsg = "You haven't specified a Discord webhook URL. \nPlease fix this in Settings."
            returnErr = true
        }
        else if ((webhookurl != "") && (usrname != "")) {
            // if the webhook url is empty but username isn't
            returnErrMsg = "You haven't specified a display name. \nPlease fix this in Settings."
            returnErr = true
        }
    }
    
    else if ((showpfp == true) && (showpronoun == true)) {
        // if showpfp and showpronoun are enabled
        if ((usrpronoun == "") && (userpfpurl == "")) {
            // if pronoun and pfp url are empty
            if ((webhookurl == "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname == "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a display name. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl == "") && (usrname != "")) {
                // if webhook url and username are empty
                returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you enabled showing an avatar image and pronoun, but didn't specify an avatar image URL or a pronoun. \nPlease fix this in Settings."
                returnErr = true
            }
            else if ((webhookurl != "") && (usrname != "")) {
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
        
        else if ((usrpronoun != "") && (userpfpurl == "")) {
            // if pfp url is empty
            if ((webhookurl == "") && (usrname == "")) {
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


func ValidateSettingsOld() -> (err: Bool, errMsg: String) {
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
    
    if UserDefaults.standard.object(forKey: "ShowPfp") != nil {
        showpfp = defaults.bool(forKey: "ShowPfp")
    }
    
    if UserDefaults.standard.object(forKey: "ShowPronoun") != nil {
        showpronoun = defaults.bool(forKey: "ShowPronoun")
    }
    
    if ((webhookurl == "") && (usrname == "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        // if webhook url, username and userpfp are empty even though showpfp is enabled
        returnErrMsg = "You haven't specified a Discord webhook URL or a display name. \nAdditionally, you haven't specified an avatar image URL even though you chose to use an avatar image. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname == "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        // if username and userpfp are empty even though showpfp is enabled
        returnErrMsg = "You haven't specified a display name. \nAdditionally, you haven't specified an avatar image URL even though you chose to use an avatar image. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname == "") && (showpfp == true && userpfpurl != "") && (showpfp == true)) {
        // if username is empty and showpfp is enabled (but pfpurl is present)
        returnErrMsg = "You haven't specified a display name. Please specify one in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname != "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        // if webhook url and userpfp are empty even though showpfp is enabled (but username is present)
        returnErrMsg = "You haven't specified a Discord webhook URL. \nAdditionally, you haven't specified an avatar image URL even though you chose to use an avatar image. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname != "") && (showpfp == true && userpfpurl != "") && (showpfp == true)) {
        // if webhook url is missing (but username and userpfp are present and showpfp is enabled)
        returnErrMsg = "You haven't specified a Discord webhook URL. Please specify one in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname == "") && (showpfp == true && userpfpurl != "") && (showpfp == true)) {
        // if webhook and displayname are empty, but userpfpurl is filled and showpfp enabled
        returnErrMsg = "You haven't specified a Discord webhook URL or a display name. Please fix these issues in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname != "") && (showpfp == true && userpfpurl == "") && (showpfp == true)) {
        // if userpfpurl is empty but showpfp is enabled (webhook url and username are present)
        returnErrMsg = "You haven't specified an avatar image URL though you chose to use an avatar image. Please specify one or choose not to use an avatar in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname == "") && (showpfp == false)) {
        // if webhook url and username are empty, and showpfp is disabled
        returnErrMsg = "You haven't specified a Discord webhook URL or a display name. Please specify them in the settings."
        returnErr = true
    }
    else if ((webhookurl == "") && (usrname != "") && (showpfp == false)) {
        // if webhook url is empty, and usrname is present and showpfp is disabled
        returnErrMsg = "You haven't specified a Discord webhook URL. Please specify one in the settings."
        returnErr = true
    }
    else if ((webhookurl != "") && (usrname == "") && (showpfp == false)) {
        // if username is empty but webhook url is present and showpfp is disabled
        returnErrMsg = "You haven't specified a display name. Please specify one in the settings."
        returnErr = true
    }
    
    return(returnErr, returnErrMsg)
}
