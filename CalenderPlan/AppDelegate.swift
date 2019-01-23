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

    static var model: [[Event]] = []
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        saveModel()
    }
    private func saveModel() {
        let filePath: String = NSHomeDirectory() + "/Documents/webs.plist"
        let newArr = AppDelegate.model.map { (arr) -> [Dictionary<String, String>] in
            return arr.map({ (arg) -> Dictionary<String, String> in
                return arg.toDict()
            })
        }
        (newArr as NSArray).write(toFile: filePath, atomically: true)
    }

}

