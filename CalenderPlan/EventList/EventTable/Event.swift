//
//  Event.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/22/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

class Event {
    var dueDate: TimeInterval
    var fromDate: TimeInterval
    var name: String
    var discription: String = ""
    var compeletingRate: Double = 0.0
    init(dueDate: TimeInterval, fromDate: TimeInterval, name: String) {
        self.dueDate = dueDate
        self.fromDate = fromDate
        self.name = name
    }
    convenience init(dict: Dictionary<String, String>) {
        guard let dueDateString = dict["dueDate"] else {
            fatalError("dueDate is not a time interval")
        }
        guard let fromDateString = dict["fromDate"] else {
            fatalError("fromDate is not a time interval")
        }
        guard let name = dict["name"] else {
            fatalError("name is not a String")
        }
        guard let discription = dict["discription"] else {
            fatalError("discription is not a String")
        }
        guard let compeletingRateString = dict["compeletingRate"] else {
            fatalError("compeletingRate is not a double")
        }
        let dueDate: TimeInterval = NSString.init(string: dueDateString).doubleValue as TimeInterval
        let fromDate: TimeInterval = NSString.init(string: fromDateString).doubleValue as TimeInterval
        self.init(dueDate: dueDate, fromDate: fromDate, name: name)
        self.discription = discription
        self.compeletingRate = NSString.init(string: compeletingRateString).doubleValue
    }
    func toDict() -> Dictionary<String, String> {
        var dict: Dictionary<String, String> = ["dueDate": "\(dueDate)"]
        dict["name"] = "\(name)"
        dict["fromDate"] = "\(fromDate)"
        dict["discription"] = discription
        dict["compeletingRate"] = "\(compeletingRate)"
        return dict
    }
}
