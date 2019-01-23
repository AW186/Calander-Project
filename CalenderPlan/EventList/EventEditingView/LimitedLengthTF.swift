//
//  LimitedLengthTF.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/10/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class LimitedLengthTF: NSTextField {
    var maximumNumberOfChar: Int?
    var textDidChangeBlk: (Notification) -> Void = { _ in }
    override func textDidChange(_ notification: Notification) {
        textDidChangeBlk(notification)
        guard let max = maximumNumberOfChar else {
            super.textDidChange(notification)
            return
        }
        if self.stringValue.count > max {
            let endIndex = String.Index.init(encodedOffset: max)
            self.stringValue = String(self.stringValue[self.stringValue.startIndex..<endIndex])
        } else {
            super.textDidChange(notification)
        }
    }
}
