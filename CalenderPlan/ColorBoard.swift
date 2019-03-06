//
//  ColorBoard.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/16/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

extension CGColor {
    static func initiateBy255(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> CGColor {
        return CGColor.init(red: red/256, green: green/256, blue: blue/256, alpha: 1)
    }
}

class ColorBoard {
    static let borderColor1: CGColor = NSColor.brown.cgColor
    static let borderColor2: CGColor = NSColor.darkGray.cgColor
    static let textColor1: CGColor = NSColor.black.cgColor
    static let textColor2: CGColor = CGColor.init(red: 0.3, green: 0.28, blue: 0.2, alpha: 1)
    static let tintTextColor: CGColor = NSColor.red.cgColor
    
    static let yuhong: CGColor = CGColor.initiateBy255(227, 189, 141)//CGColor.initiateBy255(192, 72, 81)
    static let gaolianghong = CGColor.initiateBy255(192, 44, 56)
    
    static let gutongliu = CGColor.initiateBy255(92, 55, 25)
    static let jiaoqing = CGColor.initiateBy255(135, 114, 62)
    static let lujiaozong = CGColor.initiateBy255(227, 189, 141)
    
    static let longkuizi = CGColor.initiateBy255(50, 47, 59)
    static let jinzi = CGColor.initiateBy255(128, 109, 158)
    static let waguanhui = CGColor.initiateBy255(71, 72, 76)
    static let shenhuilan = CGColor.initiateBy255(19, 44, 51)
    static let yunshanlv = CGColor.initiateBy255(21, 35, 27)
    static let yuanshanzi = CGColor.initiateBy255(204, 204, 214)
    static let yuebai = CGColor.initiateBy255(255, 255, 255) //白
    
    static let danlanhui = CGColor.initiateBy255(94, 121, 135)
    static let yanlan = CGColor.initiateBy255(20, 74, 116)
    
    static let yadinglv = CGColor.initiateBy255(66, 134, 117)
    static let heyelv = CGColor.initiateBy255(26, 104, 64)
    static let cuilv = CGColor.initiateBy255(32, 161, 98)
    static let kongquelv = CGColor.initiateBy255(34, 148, 83)
    static let yalv = CGColor.initiateBy255(150, 194, 78)
    
    static let ganlanhuanglv = CGColor.initiateBy255(190, 201, 54)
    static let caohuang = CGColor.initiateBy255(210, 180, 44)
    static let qianlaohuang = CGColor.initiateBy255(249, 189, 16)
    static let jinyehuang = CGColor.initiateBy255(255, 166, 15)
    static let wanshoujuhuang = CGColor.initiateBy255(251, 136, 5)
    
    static let danrouse = CGColor.initiateBy255(248, 224, 176)
    
}
