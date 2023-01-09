//
//  TimeCounter.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/16/22.
//

import Foundation

private let defaults = UserDefaults.standard

/**
 This function sets currentDate (in UserDefaults) to the date and time right now ('right now' being the exact time the function was called)
 
 Will replace any previously saved value in UserDefaults.
 
 */
func SaveCurrentDate() -> Void {
    let currentDate = Date()
    defaults.set(currentDate, forKey: "SavedDate")
}

/**
 Returns the time passed since the saved date as a double.
 
 When using, keep in mind that this compares against the reference date of January 1, 2001 at 00:00:00 UTC.
 
 This function will not return a pretty printed value, like '5 days' or '13 seconds'
 */
func GetRawTimeSinceSavedDate() -> Double {
    let currentDate = Date()
    var savedDate = Date(timeIntervalSinceReferenceDate: 0)
    if UserDefaults.standard.object(forKey: "SavedDate") != nil {
        savedDate = defaults.object(forKey: "SavedDate") as! Date
    }
    
    let dateDifference = currentDate.timeIntervalSince(savedDate)
    
    return dateDifference
}

/**
 Gets the time passed since the saved date, in a simplified, low precision manner.
 
 Note that the documentation for this function isn't fully shown if you use the quick help popover.
 
 Access `.Time` (int) for the amount of time (eg. `3`)
 
 Access `.TimeUnit` (string) for the unit of time associated with `.Time` (eg. `minutes`)
 
 **If you do not need to access these as seperate objects, see GetTimeSinceSavedDateAsFmtedStr()**
 
 # Usage
 ```
 Text("Time Passed Since Saved Date: " + String(describing: GetTimeSinceSavedDate().Time) + " " + GetTimeSinceSavedDate().TimeUnit)
 ```
 
 Assuming that a week has passed since the saved date, that code produces the following:
 
 **Time Passd Since Saved Date: 1 week**
 
 # Note
 The function will report the largest singular unit of time, continuing up to months. See the following as a nonexhaustive example:
 ```
 Real time passed (minutes)  Function result
 30 seconds                  30 seconds
 1 minute 45s                1 minute
 100 minutes 30s             1 hour
 1380 minutes                23 hours
 1440 minutes                1 day
 8640 minutes                6 days
 10080 minutes               1 week
 ```
 */
func GetTimeSinceSavedDate() -> (Time: Int, TimeUnit: String) {
    
    let userCalendar = Calendar.current
    let currentDate = Date()
    var savedDate = Date(timeIntervalSinceReferenceDate: 0)
    if UserDefaults.standard.object(forKey: "SavedDate") != nil {
        savedDate = defaults.object(forKey: "SavedDate") as! Date
    }
    
    let monthsBetweenDates = userCalendar.dateComponents([.month], from: savedDate, to: currentDate)
    let weeksBetweenDates = userCalendar.dateComponents([.weekOfYear], from: savedDate, to: currentDate)
    let daysBetweenDates = userCalendar.dateComponents([.day], from: savedDate, to: currentDate)
    let hoursBetweenDates = userCalendar.dateComponents([.hour], from: savedDate, to: currentDate)
    let minutesBetweenDates = userCalendar.dateComponents([.minute], from: savedDate, to: currentDate)
    let secondsBetweenDates = userCalendar.dateComponents([.second], from: savedDate, to: currentDate)
    
    // if simplification is enabled
    if (secondsBetweenDates.second! > 60) {
        // if more than 60 seconds have passed
        if (minutesBetweenDates.minute! > 60) {
            // if more than 60 minutes have passed
            if (hoursBetweenDates.hour! > 24) {
                // if more than 24hr have passed
                if (daysBetweenDates.day! > 7) {
                    // if more than 7 days have passed:
                    if (weeksBetweenDates.weekOfYear! > 4) {
                        // if more than 4 weeks have passed:
                        if (monthsBetweenDates.month == 1) {
                            return (monthsBetweenDates.month ?? 0, "month")
                        } else {
                            return (monthsBetweenDates.month ?? 0, "months")
                        }
                    }
                    if (weeksBetweenDates.weekOfYear == 1) {
                        return (weeksBetweenDates.weekOfYear ?? 0, "week")
                    } else {
                        return (weeksBetweenDates.weekOfYear ?? 0, "weeks")
                    }
                }
                if (daysBetweenDates.day == 1) {
                    return (daysBetweenDates.day ?? 0, "day")
                } else {
                    return (daysBetweenDates.day ?? 0, "days")
                }
            }
            if (hoursBetweenDates.hour == 1) {
                return (hoursBetweenDates.hour ?? 0, "hour")
            } else {
                return (hoursBetweenDates.hour ?? 0, "hours")
            }
        }
        if (minutesBetweenDates.minute == 1) {
            return (minutesBetweenDates.minute ?? 0, "minute")
        } else {
            return (minutesBetweenDates.minute ?? 0, "minutes")
        }
    }
    if (secondsBetweenDates.second == 1) {
        return (secondsBetweenDates.second ?? 0, "second")
    } else {
        return (secondsBetweenDates.second ?? 0, "seconds")
    }

    return (0, "error")
}

/**
 Returns a formatted, pretty printed date as a string.
 
 - Returns: The specific format of the date will depend on the localization settings of the user's device, however, in my configuration (US region, Gregorian calendar), this a date formatted like the following: 'December 29, 2022 at 11:09:20 PM'.
 */
func GetCurrentDateFormatted() -> String {
    var currentDate = Date(timeIntervalSinceReferenceDate: 0)
    var currentDateFormatted = ""
    if UserDefaults.standard.object(forKey: "SavedDate") != nil {
        currentDate = defaults.object(forKey: "SavedDate") as! Date
    }
    
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .long
    
    let formatteddate = formatter.string(from: currentDate as Date)
    
    
    currentDateFormatted = formatteddate
    
    return currentDateFormatted
}

/**
 This function behaves like GetTimeSinceSavedDate(), but returns just one string (You do not need to access the date and unit elements seperately)
 
 The function will return strings such as the following:
 - `4 minutes`
 - `1 hour`
 */
func GetTimeSinceSavedDateAsFmtedStr() -> String {
    return String(describing: GetTimeSinceSavedDate().Time) + " " + GetTimeSinceSavedDate().TimeUnit
    // returns something along the lines of "2 minutes" or "4 hours" or "1 day"
}

func isPepperoniDay() -> Bool {
    // TODO: add expected behaviour for this functionality
    /*
     prof mode or something idk
     ok real talk, this function will return TRUE if it is the first day of april (april 1) on any year.
     This will tie in with supporting logic to make "100% remaining" turn into "100 pepperonis remaining".
     
     :ccccccccccccccccccccccccccccccccccc::::::::::::::::::::::::::::::::::::::::::::;:::::::::::::::::::::::::::::::::::::::
     :ccccccccccccccccccccccccccccccccccc::::::::::::::::::::::::::::::::::::::::::::;:::::::::::::::::::::::::::::;:::::::;;
     :ccccccccccccccccccccccccccccccccccc:::::::::::;,;::::::::::::::::::::::::::::::;::::::::::::::::::::::::;;::;;;::::;;;;
     :ccccccccccccccccccccccccccccccccccc::::c::::::. ':cc:::::c:::cc:::::::::::::::;;:::::::::::::::;.'::::;;;;;;;;;;;;;;;;;
     :cccccccccccccccccc;;:,',::,',;cc;;:::::;,:c::c. ';'',:c:c:;,''',::c:,;;'',;:::;,''',;::;,''',;;. .',;;;;;;;;;;;;;;;;;;;
     cllllllllllllllllll' ';,...,;'.'l;.'cll,.,lllll' .,;,..:l:..',,,..;l;..,,,..;l:..,,,..;:..,,,;c:. .',:ccccccccccccccc:::
     dxdxxxxxxxxxxxxxxxx,.ckkc.,xkd..ox;.:xl.;xkkkkk;.:kkk;.cx,.ckkkko..dl.,xkkc.,x; .:::,.;o,.,:cdxx: ,ddddddddddddddddddooo
     dxxxxxxxxxxxxxxxxxx,.ckkc.,xkd'.okx,.;.'dkkkkkk;.:kkk;.cx,.lOkkkd..dl.,xkkc.,x: ,ooooodxdl:;.'lx: ,xxddddddddddddddddddd
     dxxxxxxxxxxxxxxxxxx,.ckkc.,xkd'.dkkd' 'dkkkkkkk:.:kkk;.cko'';:::''lkl.,xkkc.,xd;.,::;:od:;c:''lxl..;:oxddddddddddddddddd
     dxxxxxxxxxxxxxxxxkxocdkkdcokkxolxkkx,.okkkkkkkkdcdkkkdldkkxocc::lxkkdcokkkdcokkxoc::coxdl:::cdxxxl::cdxdxddddddddddddddd
     dxxxxxxxxxxxxxkkkkkkkkkkkkkkkkkkkkkc,lkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxkkkxxxxxxxxxxxxxxxxxxxdxxdddddddddddddd
     dxxxxxxxxxxxxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxxxxxxxxxxxxxxxxxxxxddddddddddddddd
     dxxxxxxxxxxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxkkxxxxxxxxxxxxxxxxxxxxxddddddddddddd
     dxxxxxxxxxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxkkkxc:dkkkkkkkkkkkkkkkxxxxxxxxxxxxxxxxxxxxddddddddddddd
     dxxxxxxxxxkkxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOkOkkkkkkOkOkkkOk;;xOkxc:dkkkkkkkkkkkkkkkkkkxxxxxxxxxxxxxxxxxxdddddddddddd
     dxxxxxxxxxkkkkkkkkkkkkkkkkkkl:l:,lxo::::lxkko:;;;cxkkxl:;::lxd:..;cdkl:xkxo:;;;cdkxl:c:;;;oxxxxxxxxxxxxxxxxxdddddddddddd
     dxxxxxxxxxkkkkkkkkkkkkkkkkkk; 'clo:.;ooc.,xklcodc.;kx,.:ooloxxc..loxx'.ok;.;ooc'.ox, ,loc..okxxxxxxxxxxxxxxxxddddddddddd
     dxxxxxxxxkkkkkkkkkkkkkkkkkkk,.ckOd..:ccc;;dkdlcc:..xl.;kkkkkkOd.'xkkx,.do.,xkkkc.,x,.ckxx,.ckxxxxxxxxxxxxxxxxxdddddddddd
     dxxxxxxxkkkkkkkkkkkkkkkkkkkk,.lOkx'.lkkkxxkl.,odl.'xo.'dOOkxxkd.'xOkx'.dd..okkx;.:x,.ckxx,.ckxxxxxxxxxxxxxxxxxxddddddddd
     dxxxxxxkkkkkkkkkkkkkkkkkkkkk:.lOkkd;,;:;;lko,,:cc',xOo,,;:;cdkx;.,:dx;'dOo;,;;;,cxk:.lkkx;.lkxxxxxxxxxxxxxxxxxxddddddddd
     dxxxxxxxkkkkkkkkkkkkkkkkkkkkxdkkkkkkxdodkkOkkdodkxxkkOkxddxkOkOkdodkkxdkkkkxdodkkkkxdxkkkxdxkxkxxxxxxxxxxxxxxxxxdddddddd
     dxxxxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkOkkkkkOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxkkxxxxxxxxxxxxxxxxxdddddddd
     dxxxxxxxkxkkkkkkkkkkkkkkkkkkkkkkkkkkkkOOkkOOOOkkkkOOkkkkkkOkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxkxxxxxxxxxxxxxxxxxxdddddddd
     dxxxxxxxxooodddddddxxxxkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxxxxxxxxxxddxxddddddddddddddd
     dxxxxxxxxl:c::cccccccllloooooddddddddddddddoooodooooodoooddddddddddddddddddddoodoooooooooooollllllllllcllccccccodddddddd
     dxxxxxxkdl::::::::::ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc::::::::::::coddddddd
     dxxxxxxxdc:::::::::::::cc:ccccccccccccccccccccccccccccccccccccccc:::::::::ccccccc::ccc::::::::cc::::::::::::::::lddddddd
     dxxxxxxxdc:::::::::::::::::::::::cccccccccccccc:cccccccccc::c:,''......''',;::c:::::::::::::::::::::::::::::::::codddddd
     dxxxxxxxoc:::::::::::::::::::::::cc::::::::ccc::cccc:c::::;,,'...        ....',;;:::::::::::::::::::::::::;::::;:loddddd
     dxxxxxxxoc::::::::::::::::::::::::::::::::::::::ccc:::;,......                 ..,::::::::::::::::::;::::;:::;;;:loddddd
     dxxxxxxxl::::::::::::::::::::::::::::::::::::::::::::;'..       ...              .,:::::::::::::::;;;;;;;:;;;;;;:coodddd
     dxxxxxxdl:::::::::::::::::::::::::::::::::::::::::::;,.   ...',,;;;,,,'''...     .';:::::::::::::;;;;::;;;;;;;;;:clodddd
     dxxxxxxdc:::::::::::::::::::::::::::::::::::::::::;'.. ..,;cccccccccc::::::;,..   ..,;:::::::::::;;;:::;;;;;;;;;:clodddd
     dxxxxxxoc:::::::::::::::::::::::::::::::::::::::;,.. ..;cccccccccccccc::::::::;,..  .';;::;;::::;;;;::;;;;;;;;;;:clodddd
     dxxxxxxl::::::::::::::::::::::::::::::::::::::;:;.  .':cccccccccccccccc:::::::::;'.  .,;;:;;:;;;;;;:::;;;;;;;;;;:clodddd
     dxxxxxdl:::;::::::::::::::::::::::::::::::::::;;;'  ':cc::;;;;;;:cclccc:;,,,,,;;;;'. .,,;;;;;;;;;;;:::;;;;;;;;;;:clooddd
     dxxxxxdc:;;;;;:::::::::::::::::::::::::::::;;;;;:,..;c:,,;:;;;;,;;cccc:,,,;;,,,',;:' ..';;;;;;;;;;;;::;;;;;;;;;;:clooddd
     dxxxxxoc;::::::::::::::::::::::::::::::::::;;;;,.. .;:;,:olc::;;;:c:;:c::;;,''''',;'   .',;;;;;;;;;;;:;;;;;;;;;;:clooddd
     dxxxxxdc::::::::::::::::::::::::;;::;;;;;;;;;;,.   .;cc;;cc:::c::::::;::c:,''...,;,'.  ..,;;;;:;;;;;;:;;;;;;;;;;:clooddd
     dxxxxxoc::::::;;:::::::::::::::;;;;:;;;;;;;;::,.. .;ccccccclcllc:::::;,;:::::;;;;;;,.  .,;::;;;;,;;;;:;;;;;;;;;;:clooddd
     dxxxxxl:::::::::::::::;;;;::::;;;;;;;;;;;;;;cl:,. ':::cccccccc::;,',,'.',;::::::;;;,'.  ;cc:;;;;;;;;;;;;;;;;;;;;:clooooo
     dxxxdoc::::::::::::::;;;;::;;;::;;;;;;;;;;;;llc;..,:::cccccccc::;''','.',;:cc::::;;;,.  ;c::,,,,;;;;;;;;;;;;;;;;:clloooo
     dxddoc:::::::;;;;:::::::::;;;;:::;;;;;;;;;;;loc;..,;::::cccc:::;,,,,,,''';::cc:::;;,'.  ;ll:'',,;;;;;;;;;;;;;;;;:clloooo
     dxdoc::;;;;;;;;::::::;;;;;;;;;;;;;;;;;;;;;;;cddc...,;:::ccc:;;;;;;;;,,;;,,,,;::;;,,'..  :do;.'',;;;;;;;;;;;;;;;;:ccloooo
     dddl::;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;:oxl....',;:::;;,;;,,,,,',,,,,;;,,;,,''... .:dl,..',;;;;;;;;;;;;;;;;::cloooo
     ddoc:;;;;:;;;;;;;;,;;;;;;;;;;:::;;;;;;;;;;;;;ldo'....',;;;;,,,;;;,'...'',,;,,,,''....  .:c:...',,;;;;;;;,,;;;;;;;:cloooo
     odl::;;;;;;;;;;;;;;;;;,,,,,,;;;;;;;;;;;;;;;;;:ll;....''',,'''',,,,'''..'''''..''..     .......',,;;;;;;,,,,;;,,,;:cllooo
     ooc:;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,;;;;;;;;;;;;;:,....''''.......''',,''............    .   ...',,,,,;;,,,,,,,,,,;:cllooo
     oo:;;;;;;;;;;;;;;;;;;;;;,,;,;;;;;,,,,,;;;;;,,;,'...................'''......  ....       ....'',,,,,,,,,,,,,,,,,;:cllooo
     ol:;;;;;;;;;;;;;;;;;,,,,,,,,',,,,;,,,,,,,,,,,,,''...........  ..........      .....     ......'',,,,,,,,,,,,,,,,;:cclooo
     lc;;;;;;;;;;;;;;,;,,,,,,,,,,,,,'',''',,,,,'',''''.................        .........      .....''''',,,,,,,,,,,,,;:cclloo
     c:;;;;,,,,,,,,,,,,,,,;;;;;;;;,'.'''''''''..............''''''.......................        ......''''''''''',,,;::clllo
     l:,,,,;;;,,,,,'''''',,,,,,,'............            ....'''''''',,,,'''''''........            .....         ....';:clll
     ol;,,,,,,,,,'''''..........                           ...''''''','''''''''.......                                  ...,:
     lc,'''...........                                        ....................
     ;:........                          .   .             ..
     ........                           ..  .,'.  .'.   .  .'.           ...
                                      ...  .;;.  .:;..'...  ..        ....','.    ..  ...    .  ..'..   ..
                                     ...   .::. .;:. .:,    .,.   ..       .''.        '.         ..'.  .
                                            .    .    ..     */
    return false
}
