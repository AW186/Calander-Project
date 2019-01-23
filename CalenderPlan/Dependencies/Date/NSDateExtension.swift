//
//  NSDateExtension.swift
//  CalenderPlan
//
//10/29/18.
//
//

import Foundation
import Cocoa

extension NSDate {
    static func dateFrom(year: Int, month: Int, day: Int) -> NSDate? {
        guard year >= 1000 else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let monthStr = (month < 10 ? "0" : "") + "\(month)"
        let dayStr = (day < 10 ? "0" : "") + "\(month)"
        return formatter.date(from: "\(year)-"+monthStr+"-"+dayStr) as NSDate?
    }
}
