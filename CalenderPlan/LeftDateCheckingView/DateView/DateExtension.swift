//
//  DateInfoConvertor.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/17/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

extension NSDate {
    func toChineseSeason() -> String {
        return "节气"
    }
    func getHoliday() -> Holiday {
        return .someDay("某节")
    }
    func toStringByFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self as Date)
    }
    func getChineseCalender() -> String {
        let gregorian = Calendar(identifier: .gregorian)
        let date = Date()
        var components = DateComponents()
        let solarDate = gregorian.date(byAdding: components, to: date)
        let chinese = Calendar(identifier: .chinese)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.calendar = chinese
        formatter.dateStyle = .full
        var lunar = formatter.string(from: solarDate!)
        lunar.removeFirst(4)
        lunar.insert(contentsOf: "   ", at: lunar.index(lunar.startIndex, offsetBy: lunar.count-3))
        return lunar
    }
    func getYear() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return format.string(from: self as Date)
    }
    func getMonth() -> String {
        let format = DateFormatter()
        format.dateFormat = "MM"
        return format.string(from: self as Date)
    }
    func getDay() -> String {
        let format = DateFormatter()
        format.dateFormat = "dd"
        return format.string(from: self as Date)
    }
    func yearVal() -> Int {
        return Int(getYear())!
    }
    func monthVal() -> Int {
        return Int(getMonth())!
    }
    func dayVal() -> Int {
        return Int(getDay())!
    }
    func getWeekDay() -> Int {
        guard var y = Int(getYear()) else {
            return -1
        }
        let c = y/100
        guard var m = Int(getMonth()) else {
            return -1
        }
        y = y%100
        (y, m) = m < 3 ? (y-1, m+12) : (y, m)
        guard let d = Int(getDay()) else {
            return -1
        }
        return y+(y/4)+(c/4)-2*c+(26*(m+1)/10)+d-1-1
    }
}
