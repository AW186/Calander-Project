//
//  EventCell.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/20/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class EventCell: VerticleTableViewCell {
    private var label: NSTextField = NSTextField()
    private var ring: RingView = RingView()
    private var backgroundRing: RingView = RingView()
    private var timeLeftLabel: NSTextField = NSTextField()
    private var completeRateLabel: NSTextField = NSTextField()
    let model: Event
    init(model: Event) {
        self.model = model
        super.init(frame: NSRect.zero)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layout() {
        super.layout()
        layoutLabel()
        layoutProgressBar()
        layoutCompleteRateLabel()
        layoutTimeLeftLabel()
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUpProgressBar()
        setUpLabel()
        setShadow()
        setupCompleteRateLabel()
        setupTimeLeftLabel()
    }
    override func refreshData() {
        setUpProgressBar()
        setUpLabel()
        setupTimeLeftLabel()
        setupCompleteRateLabel()
        layoutLabel()
        layoutProgressBar()
        super.refreshData()
    }
}

extension EventCell {
    private func setupTimeLeftLabel() {
        timeLeftLabel.removeFromSuperview()
        timeLeftLabel.stringValue = { [unowned self] in
            let currentDate = NSDate().timeIntervalSince1970
            let timeInterval = self.model.dueDate + 24*60*60 - currentDate
            if timeInterval < 0 {
                return "已过期"
            } else if timeInterval < 24*60*60 {
                return "今天"
            } else {
                return "还剩\(Int(timeInterval/(24*60*60)))天"
            }
        }()
        timeLeftLabel.textColor = NSColor(cgColor: ColorBoard.textColor2)
        timeLeftLabel.isEditable = false
        timeLeftLabel.isBordered = false
        layoutTimeLeftLabel()
        self.addSubview(timeLeftLabel)
    }
    private func layoutTimeLeftLabel() {
        timeLeftLabel.font = NSFont.systemFont(ofSize: 15)
        timeLeftLabel.sizeToFit()
        timeLeftLabel.frame.rightBottomCorner = ring.frame.origin.horizantalShift(-10).verticalShift(10)
    }
    private func setupCompleteRateLabel() {
        completeRateLabel.removeFromSuperview()
        completeRateLabel.stringValue = { [unowned self] in
            if self.model.compeletingRate == 1 {
                return "已完成"
            } else {
                return "完成\(Int(model.compeletingRate*100))%"
            }
        }()
        completeRateLabel.textColor = NSColor(cgColor: ColorBoard.textColor2)
        completeRateLabel.isEditable = false
        completeRateLabel.isBordered = false
        layoutCompleteRateLabel()
        self.addSubview(completeRateLabel)
    }
    private func layoutCompleteRateLabel() {
        completeRateLabel.font = NSFont.systemFont(ofSize: 15)
        completeRateLabel.sizeToFit()
        completeRateLabel.frame.rightTopCorner = ring.frame.leftTopCorner.horizantalShift(-10).verticalShift(-10)
    }
    private func setShadow() {
        self.wantsLayer = true
        self.shadow = NSShadow()
        self.layer?.backgroundColor = ColorBoard.yuebai
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowOpacity = 0.2
        self.layer?.shadowOffset = CGSize(width: 0, height: 0)
        self.layer?.shadowRadius = 5
    }
    private func setUpProgressBar() {
        backgroundRing.removeFromSuperview()
        ring.removeFromSuperview()
        guard havingProgressBar else { return }
        ring.color = NSColor(cgColor: ColorBoard.yuhong)!
        ring.wantsLayer = true
        ring.layer?.backgroundColor = CGColor.init(gray: 1, alpha: 0)
        backgroundRing.color = NSColor(cgColor: ColorBoard.yuanshanzi)!
        layoutProgressBar()
        self.addSubview(backgroundRing)
        self.addSubview(ring)
    }
    private func layoutProgressBar() {
        guard havingProgressBar else {
            ring.width = 0
            ring.radius = 0
            return
        }
        ring.radius = self.bounds.height*0.8/2
        ring.width = self.bounds.height/20
//        if(model.dueDate <= model.fromDate) {
//            ring.angle = 360
//        } else {
//            ring.angle = CGFloat((NSDate().timeIntervalSince1970-model.fromDate)/(model.dueDate-model.fromDate))*360
//        }
        ring.angle = CGFloat(model.compeletingRate*360)
        ring.frame.size = CGSize.init(length: self.bounds.height)
        ring.frame.rightTopCorner = self.bounds.rightTopCorner
        ring.frame.rightTopCorner.x -= self.bounds.width/10
        
        backgroundRing.radius = self.bounds.height*0.8/2
        backgroundRing.width = self.bounds.height/20
        backgroundRing.angle = 359.9
        backgroundRing.frame.size = CGSize.init(length: self.bounds.height)
        backgroundRing.frame.rightTopCorner = self.bounds.rightTopCorner
        backgroundRing.frame.rightTopCorner.x -= self.bounds.width/10
    }
    private var havingProgressBar: Bool {
        get {
            return self.frame.height <= self.frame.width/3.5
        }
    }
    private func setUpLabel() {
        label.removeFromSuperview()
        label.stringValue = model.name
        label.textColor = NSColor(cgColor: ColorBoard.textColor2)
        label.isEditable = false
        label.isBordered = false
        layoutLabel()
        self.addSubview(label)
    }
    private func layoutLabel() {
        label.font = NSFont.systemFont(ofSize: 30)
        label.sizeToFit()
        label.frame.size.width = label.frame.size.width <= self.bounds.width/2 ?
            label.frame.size.width : self.bounds.width/2
        label.center = self.bounds.size.getCenter()
        label.frame.origin.x = self.bounds.width/10
    }
}





