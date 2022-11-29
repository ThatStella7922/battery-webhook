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
    }

    return (0, "error")
}

func GetCurrentDateFormatted() -> String {
    
    var currentDate = Date(timeIntervalSinceReferenceDate: 0)
    var currentDateFormatted = ""
    if UserDefaults.standard.object(forKey: "SavedDate") != nil {
        currentDate = defaults.object(forKey: "SavedDate") as! Date
    }
    
    var formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .long
    
    var formatteddate = formatter.string(from: currentDate as Date)
    
    
    currentDateFormatted = formatteddate
    
    return currentDateFormatted
}

func GetTimeSinceSavedDateAsFmtedStr() -> String {
    return String(describing: GetTimeSinceSavedDate(simplify: true).Time) + " " + GetTimeSinceSavedDate(simplify: true).TimeUnit
    // returns something along the lines of "2 minutes" or "4 hours" or "1 day"
}
