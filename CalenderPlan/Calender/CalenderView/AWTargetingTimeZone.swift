//
//  AWTargetingTimeZone.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 2/18/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

enum AWTargtingTimeZone {
    case year(NSDate)
    case month(NSDate)
    case day(NSDate)
    case hour(NSDate)
    case minute(NSDate)
    case second(NSDate)
    var value: NSDate {
        switch self {
        case .year(let val):
            return val
        case .month(let val):
            return val
        case .day(let val):
            return val
        case .hour(let val):
            return val
        case .minute(let val):
            return val
        case .second(let val):
            return val
        }
    }
}
