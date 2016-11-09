//
//  String+Helpers.swift
//  JNews
//
//  Created by ChenKaijie on 16/7/11.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import UIKit
import Foundation

extension String {
    func getHeight(text: String, margin: CGFloat, fontSize: CGFloat) -> CGFloat {
        let contextRect: CGRect = text.boundingRectWithSize(CGSizeMake(WIDTH - margin, CGFloat.max), options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: [NSFontAttributeName: UIFont.systemFontOfSize(fontSize)], context: nil);
        return contextRect.size.height;
    }
    //MARK: - Date
    static func getFiveDatesArray(date: NSDate) -> [Dictionary<String, String>] {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calendar?.components([.Day, .Month, .Year, .Weekday], fromDate: date)
        let dateFormate = NSDateFormatter()
        dateFormate.dateFormat = "MM/dd"
        
        let fifthDate = calendar?.dateFromComponents(components!)
        let fifthDateString = dateFormate.stringFromDate(fifthDate!)
        var fifthWeek = ""
        
        components?.day = (components!.day - 1)
        let fourthDate = calendar?.dateFromComponents(components!)
        let fourthDateString = dateFormate.stringFromDate(fourthDate!)
        var fourthWeek = ""
        
        components?.day = (components!.day - 1)
        let thirdDate = calendar?.dateFromComponents(components!)
        let thirdDateString = dateFormate.stringFromDate(thirdDate!)
        var thirdWeek = ""

        components?.day = (components!.day - 1)
        let secondDate = calendar?.dateFromComponents(components!)
        let secondDateString = dateFormate.stringFromDate(secondDate!)
        var secondWeek = ""

        components?.day = (components!.day - 1)
        let firstDate = calendar?.dateFromComponents(components!)
        let firstDateString = dateFormate.stringFromDate(firstDate!)
        var firstWeek = ""

        // Weeks
        let days = Int(NSDate().timeIntervalSince1970/86400)
        let weeks = (days - 3)%7 // 0-6表示周日到周六
        switch weeks {
        case 0:
            fifthWeek = "周日"
            fourthWeek = "周六"
            thirdWeek = "周五"
            secondWeek = "周四"
            firstWeek = "周三"
        case 1:
            fifthWeek = "周一"
            fourthWeek = "周日"
            thirdWeek = "周六"
            secondWeek = "周五"
            firstWeek = "周四"
        case 2:
            fifthWeek = "周二"
            fourthWeek = "周一"
            thirdWeek = "周日"
            secondWeek = "周六"
            firstWeek = "周五"
        case 3:
            fifthWeek = "周三"
            fourthWeek = "周二"
            thirdWeek = "周一"
            secondWeek = "周日"
            firstWeek = "周六"
        case 4:
            fifthWeek = "周四"
            fourthWeek = "周三"
            thirdWeek = "周二"
            secondWeek = "周一"
            firstWeek = "周日"
        case 5:
            fifthWeek = "周五"
            fourthWeek = "周四"
            thirdWeek = "周三"
            secondWeek = "周二"
            firstWeek = "周一"
        case 6:
            fifthWeek = "周六"
            fourthWeek = "周五"
            thirdWeek = "周四"
            secondWeek = "周三"
            firstWeek = "周二"
        default:
            print("Error")
        }
        
        var resultArray: [Dictionary<String, String>] = [Dictionary<String, String>]()
        resultArray.append(["date":firstDateString, "week":firstWeek])
        resultArray.append(["date":secondDateString, "week":secondWeek])
        resultArray.append(["date":thirdDateString, "week":thirdWeek])
        resultArray.append(["date":fourthDateString, "week":fourthWeek])
        resultArray.append(["date":fifthDateString, "week":fifthWeek])

        return resultArray
    }
    
    //MARK: - Time
    static func getInterval(start: String, end: String) -> NSTimeInterval {
        let dateFormatter: NSDateFormatter = NSDateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        let startDate = dateFormatter.dateFromString(start)
        let endDate = dateFormatter.dateFromString(end)
        let interval = endDate!.timeIntervalSince1970 - startDate!.timeIntervalSince1970
        return interval
    }
    
    static func getSubmitTimeString() -> String {
        let date = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.stringFromDate(date)
    }
    
    static func getStartTimeString() -> String {
        let date = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.stringFromDate(date) + " 06:00:00"
    }
    
    static func getEndTimeString() -> String {
        let date = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.stringFromDate(date) + " 18:00:00"
    }
    
    static func getCurrentTimeString() -> String {
        let currentDate = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter.init()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        return dateFormatter.stringFromDate(currentDate)
    }
    
    static func getTomorrowStartTimeString(date: NSDate) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calendar?.components([.Day, .Month, .Year, .Weekday], fromDate: date)
        components?.day = (components!.day + 1)
        
        let resultDate = calendar?.dateFromComponents(components!)
        let dateFormate = NSDateFormatter()
        dateFormate.dateFormat = "yyyy.MM.dd"
        return dateFormate.stringFromDate(resultDate!) + " 06:00:00"
    }
    
    static func getYesterdayEndTimeString(date: NSDate) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calendar?.components([.Day, .Month, .Year, .Weekday], fromDate: date)
        components?.day = (components!.day - 1)
        
        let resultDate = calendar?.dateFromComponents(components!)
        let dateFormate = NSDateFormatter()
        dateFormate.dateFormat = "yyyy.MM.dd"
        return dateFormate.stringFromDate(resultDate!) + " 18:00:00"
    }
    
    static func getXDaysAgoTimeString(days: NSInteger) -> String {
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calendar?.components([.Day, .Month, .Year, .Weekday], fromDate: NSDate())
        let dateFormate = NSDateFormatter()
        dateFormate.dateFormat = "yyyy.MM.dd"
        components?.day = components!.day - days
        return dateFormate.stringFromDate(calendar!.dateFromComponents(components!)!)
    }
}
