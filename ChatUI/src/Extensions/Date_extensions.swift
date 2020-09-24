//
//  Date_extensions.swift
//  ChatUI
//
//  Created by Chính Trình Quang on 9/24/20.
//  Copyright © 2020 Chính Trình Quang. All rights reserved.
//


import UIKit

fileprivate let systemDateFormat = "dd/MM/yyyy"
fileprivate let systemTimeFormat = "HH:mm"
fileprivate let dateFormatter = DateFormatter()

extension Date {
    func getDateString(with format : String) -> String{
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
    func getSystemDateString() -> String {
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = systemDateFormat
        return dateFormatter.string(from: self)
    }
    func getShortDateString() -> String {
    
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: self)
    }
    func getShortTimeString() -> String {

        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: self)
    }
   
    
    func getFormDateString() -> String {
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: self)
    }
    func getFormDateTimeString() -> String {
        dateFormatter.dateFormat = "MMM dd,HH:mm:ss a"
        return dateFormatter.string(from: self)
    }
    func toTimeStamp() -> Int{
        return Int(timeIntervalSince1970 * 1000)
    }
    static func isValidDate(day: String?, month: String?, year: String?) -> Bool {
        guard let month = month, let day = day, let year = year else {
            return false
        }
        let dateString = day + "/" + month + "/" + year
        dateFormatter.dateFormat = systemDateFormat
        if dateFormatter.date(from: dateString) != nil {
            return true
        } else {
            return false
        }
    }
    
    static func getDate(fromSystemFormat string: String) -> Date? {
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = systemDateFormat
        return dateFormatter.date(from: string)
    }
    static func getDate(from systemDateString: String, systemTimeString: String) -> Date? {
        let stringToConvert = systemDateString + " " + systemTimeString
        let formatString = systemDateFormat + " " + systemTimeFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = formatString
        return dateFormatter.date(from: stringToConvert)
    }
    
    func before(minutes: Int = 0, hours: Int = 0, days: Int = 0) -> Date {
        let calendar = Calendar.current
        var date = calendar.date(byAdding: .minute, value: -minutes, to: self)
        date = calendar.date(byAdding: .hour, value: -hours, to: date!)
        return calendar.date(byAdding: .day, value: -days, to: date!)!
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }
    
    var nextMonth: Date {
        var component = DateComponents()
        component.month = 1
        return Calendar(identifier: .gregorian).date(byAdding: component, to: self)!
    }
    
    var previousMonth: Date {
        var component = DateComponents()
        component.month = -1
        return Calendar(identifier: .gregorian).date(byAdding: component, to: self)!
    }
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    
    func reduceToMonthDayYear() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }
}
