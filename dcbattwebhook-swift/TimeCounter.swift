//
//  TimeCounter.swift
//  dcbattwebhook-swift
//
//  Created by Stella Ortiz on 11/16/22.
//

import Foundation

private let defaults = UserDefaults.standard

func SaveCurrentDate() -> Void {
    // sets currentDate to the date right now ('right now' being the exact time the function was called)
    let currentDate = Date()
    
    // save to key
    defaults.set(currentDate, forKey: "SavedDate")
}

func GetTimeSinceSavedDate() -> Double {
    let currentDate = Date()
    var savedDate = Date(timeIntervalSinceReferenceDate: 0)
    if UserDefaults.standard.object(forKey: "SavedDate") != nil {
        savedDate = defaults.object(forKey: "SavedDate") as! Date
    }
    
    let dateDifference = currentDate.timeIntervalSince(savedDate)
    
    return dateDifference
}

func GetTimeSinceSavedDate(simplify: Bool) -> (Time: Int, TimeUnit: String) {
    
    let userCalendar = Calendar.current
    let currentDate = Date()
    var savedDate = Date(timeIntervalSinceReferenceDate: 0)
    if UserDefaults.standard.object(forKey: "SavedDate") != nil {
        savedDate = defaults.object(forKey: "SavedDate") as! Date
    }
    
    let monthsBetweenDates = userCalendar.dateComponents([.month], from: savedDate, to: currentDate)
    let weeksBetweenDates = userCalendar.dateComponents([.weekOfMonth], from: savedDate, to: currentDate)
    let daysBetweenDates = userCalendar.dateComponents([.day], from: savedDate, to: currentDate)
    let hoursBetweenDates = userCalendar.dateComponents([.hour], from: savedDate, to: currentDate)
    let minutesBetweenDates = userCalendar.dateComponents([.minute], from: savedDate, to: currentDate)
    let secondsBetweenDates = userCalendar.dateComponents([.second], from: savedDate, to: currentDate)
    
    if (simplify == true) {
        // if simplification is enabled
        if (secondsBetweenDates.second! > 60) {
            // if more than 60 seconds have passed
            if (minutesBetweenDates.minute! > 60) {
                // if more than 60 minutes have passed
                if (hoursBetweenDates.hour! > 24) {
                    // if more than 24hr have passed
                    if (daysBetweenDates.day! > 7) {
                        // if more than 7 days have passed:
                        if (weeksBetweenDates.weekOfMonth! > 4) {
                            // if more than 4 weeks have passed:
                            if (monthsBetweenDates.month == 1) {
                                return (monthsBetweenDates.month ?? 0, "month")
                            } else {
                                return (monthsBetweenDates.month ?? 0, "months")
                            }
                        }
                        if (weeksBetweenDates.weekOfMonth == 1) {
                            return (weeksBetweenDates.weekOfMonth ?? 0, "week")
                        } else {
                            return (weeksBetweenDates.weekOfMonth ?? 0, "weeks")
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
    }

    return (0, "error")
}

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

func GetTimeSinceSavedDateAsFmtedStr() -> String {
    return String(describing: GetTimeSinceSavedDate(simplify: true).Time) + " " + GetTimeSinceSavedDate(simplify: true).TimeUnit
    // returns something along the lines of "2 minutes" or "4 hours" or "1 day"
}

func isPepperoniDay() -> Bool {
    
    /*
     prof mode or something idk
     ok real talk, this function will return TRUE if it is the first day of april (april 1) on any year.
     
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
