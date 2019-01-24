//
//  BookPageControlDelegate.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/18/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

protocol BookPageControlDelegate: class {
    func accessToPage(page: Int) -> Int
    func setTint(label: NSTextField)
    func setDefuat(label: NSTextField)
}
