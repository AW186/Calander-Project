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
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUpProgressBar()
        setUpLabel()
        setShadow()
    }
    override func refreshData() {
        setUpProgressBar()
        setUpLabel()
        layoutLabel()
        layoutProgressBar()
        super.refreshData()
    }
}

extension EventCell {
    private func setShadow() {
        self.wantsLayer = true
        self.shadow = NSShadow()
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowOpacity = 0.2
        self.layer?.shadowOffset = CGSize(width: 0, height: 0)
        self.layer?.shadowRadius = 5
    }
    private func setUpProgressBar() {
        ring.removeFromSuperview()
        guard havingProgressBar else { return }
        layoutProgressBar()
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
        if(model.dueDate <= model.fromDate) {
            ring.angle = 360
        } else {
            ring.angle = CGFloat((NSDate().timeIntervalSince1970-model.fromDate)/(model.dueDate-model.fromDate))*360
        }
        ring.frame.size = CGSize.init(length: self.bounds.height)
        ring.frame.rightTopCorner = self.bounds.rightTopCorner
        ring.frame.rightTopCorner.x -= self.bounds.width/10
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





