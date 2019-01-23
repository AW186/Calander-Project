//
//  EditIconBtn.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/15/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class EditIconBtn: ButtonView {
    var isTint: Bool = false {
        didSet {
            setNeedsDisplay(self.bounds)
        }
    }
    var tintColor: NSColor = NSColor.cyan {
        didSet {
            setNeedsDisplay(self.bounds)
        }
    }
    var defuatColor: NSColor = NSColor.lightGray {
        didSet {
            setNeedsDisplay(self.bounds)
        }
    }
    private var unitWidth: CGFloat {
        return self.bounds.width/100
    }
    private var unitHeight: CGFloat {
        return self.bounds.height/100
    }
    private var penPath: NSBezierPath {
        let path = NSBezierPath()
        path.move(to: CGPoint(x: 20*unitWidth, y: 20*unitHeight))
        path.line(to: CGPoint(x: 30*unitWidth, y: 20*unitHeight))
        path.line(to: CGPoint(x: 90*unitWidth, y: 80*unitHeight))
        path.line(to: CGPoint(x: 80*unitWidth, y: 90*unitHeight))
        path.line(to: CGPoint(x: 80*unitWidth, y: 90*unitHeight))
        path.line(to: CGPoint(x: 20*unitWidth, y: 30*unitHeight))
        path.close()
        path.lineWidth = 5*unitWidth
        return path
    }
    private var blanketPath: NSBezierPath {
        let path = NSBezierPath()
        path.move(to: CGPoint(x: 5*unitWidth, y: 60*unitHeight))
        path.line(to: CGPoint(x: 5*unitWidth, y: 5*unitHeight))
        path.line(to: CGPoint(x: 95*unitWidth, y: 5*unitHeight))
        path.line(to: CGPoint(x: 95*unitWidth, y: 60*unitHeight))
        path.lineWidth = 7*unitWidth
        return path
    }
    override func draw(_ dirtyRect: NSRect) {
        let color = isTint ? tintColor : defuatColor
        color.setFill()
        color.setStroke()
        penPath.fill()
        blanketPath.stroke()
        super.draw(dirtyRect)
    }
    
    override func layout() {
        super.layout()
        self.setNeedsDisplay(self.bounds)
    }
}
