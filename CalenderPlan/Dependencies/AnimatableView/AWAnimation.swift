//
//  AWAnimation.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/12/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWAnimation {
    private var timer: Timer = Timer()
    private let interval: TimeInterval = 0.025
    private var currentTime: TimeInterval = 0
    private let duration: TimeInterval
    private var completeBlk: ((Bool) -> Void)?
    private var startTime: NSDate = NSDate()
    init(duration: TimeInterval, actionBlk: @escaping (CGFloat) -> Void) {
        self.duration = duration
        self.startTime = NSDate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [unowned self] (_) -> () in
            let currentTime = NSDate()
            let rate = (currentTime.timeIntervalSince1970-self.startTime.timeIntervalSince1970)/duration
            actionBlk(CGFloat(rate < 1 ? rate : 1))
            if self.currentTime >= self.duration {
                self.timer.invalidate()
            }
            self.currentTime += self.interval
        })
    }
    init(duration: TimeInterval, actionBlk: @escaping (CGFloat) -> Void, completeBlk: @escaping (Bool) -> Void) {
        self.duration = duration
        self.completeBlk = completeBlk
        self.startTime = NSDate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [unowned self] (_) -> () in
            let currentTime = NSDate()
            let rate = (currentTime.timeIntervalSince1970-self.startTime.timeIntervalSince1970)/duration
            actionBlk(CGFloat(rate < 1 ? rate : 1))
            if self.currentTime >= self.duration {
                self.timer.invalidate()
                completeBlk(true)
            }
            self.currentTime += self.interval
        })
    }
    func stopAnimate() {
        if let blk = completeBlk {
            blk(false)
        }
        timer.invalidate()
    }
}
