//
//  BackBar.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/11/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class BackBar: NSView {
    var reactionBlk: () -> () = {}
    override func draw(_ dirtyRect: NSRect) {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.lightGray.cgColor
        let path = NSBezierPath()
        var beginPoint = self.boundCenter
        let unit = self.bounds.width/4
        beginPoint.x -= unit
        beginPoint.y += unit
        path.move(to: beginPoint)
        path.line(to: beginPoint.plus(point: CGPoint.init(x: unit, y: -unit)))
        path.line(to: beginPoint.plus(point: CGPoint.init(x: 0, y: -2*unit)))
        NSColor.white.setStroke()
        path.stroke()
        
        super.draw(dirtyRect)
    }
    override func layout() {
        setNeedsDisplay(self.bounds)
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        let gesture = NSClickGestureRecognizer.init(target: self, action: #selector(clickFunc))
        self.addGestureRecognizer(gesture)
    }
    @objc private func clickFunc() {
        reactionBlk()
    }
}
