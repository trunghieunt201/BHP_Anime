//
//  TimeUltis.swift
//  BHP-Anime
//
//  Created by Nguyen Trung Hieu on 3/4/20.
//  Copyright © 2020 Nguyen Trung Hieu. All rights reserved.
//

import Foundation

class TimeUltis {
    class func convertTimestampToString(unixtimeInterval: Double, format: String) -> String {
        let date = Date(timeIntervalSince1970: unixtimeInterval)
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        //dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = format //Specify your format that you want
        return dateFormatter.string(from: date)
    }
    
    class func convertDateToString(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    class func convertStringToTimestamp(strdate: String, format: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: strdate)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        return Int(dateStamp)
    }
    
    class func convertStringToStringDate(strdate: String, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let datestr = dateFormatter.date(from: strdate)
//        print(strdate)
        let interval = Calendar.current.dateComponents([.minute, .hour, .day,.month], from: datestr!, to: Date())
        if let month = interval.month, month > 0{
            return "\(month) " + "month ago"
        }else if let day = interval.day, day > 0{
            return "\(day) " + "day ago"
        }else if let hour = interval.hour, hour > 0{
            return "\(hour) " + "hour ago"
        }else if let minute = interval.minute{
            return "\(minute) " + "minute ago"
        }else {
            return "a moment ago"
            
        }
    }
    
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
        //  return Int(self.timeIntervalSince1970 * 1000.0)
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
