//
//  AppDelegate.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/15/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    static var model: [EventList] = []
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        AppDelegate.saveModel()
    }
    public static func saveModel() {
        let filePath: String = NSHomeDirectory() + "/Documents/data.plist"
        print(model[0].data)
        let newArr = AppDelegate.model.map { (arr) -> [Dictionary<String, String>] in
            return arr.data.map({ (arg) -> Dictionary<String, String> in
                return arg.toDict()
            })
        }
        (newArr as NSArray).write(toFile: filePath, atomically: true)
    }

}

