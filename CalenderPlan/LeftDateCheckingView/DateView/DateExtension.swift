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
}
