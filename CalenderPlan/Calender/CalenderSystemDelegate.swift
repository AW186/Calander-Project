//
//  Calender.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 2/16/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

enum Week: Int {
    case monday = 0
    case tuesday = 1
    case wednesday = 2
    case thursday = 3
    case friday = 4
    case saturday = 5
    case sunday = 6
}

protocol CalenderSystemDelegate: class {
    func year(for date: NSDate) -> Int
    func month(for date: NSDate) -> Int
    func day(for date: NSDate) -> Int
    func yearDescription(for date: NSDate) -> String
    func monthDescription(for date: NSDate) -> String
    func dayDescription(for date: NSDate) -> String
    func weekDay(for date: NSDate) -> Week
    func numberOfMonth(in year: Int) -> Int
    func numberOfDay(in year: Int, month: Int) -> Int
    func date(for year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> NSDate
    func firstDayInMonth(for date: NSDate) -> NSDate
    func firstMonthInYear(for date: NSDate) -> NSDate
}
