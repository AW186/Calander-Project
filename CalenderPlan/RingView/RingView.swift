//
//  RingView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/26/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class RingView: NSView {
    var isClockWise: Bool = false {
        didSet {
            guard superview != nil else { return }
            self.setNeedsDisplay(self.bounds)
        }
    }
    var radius: CGFloat = 100 {
        didSet {
            guard superview != nil else { return }
            self.setNeedsDisplay(self.bounds)
        }
    }
    var width: CGFloat = 10 {
        didSet {
            guard superview != nil else { return }
            self.setNeedsDisplay(self.bounds)
        }
    }
    var color: NSColor = NSColor.black {
        didSet {
            guard superview != nil else { return }
            self.setNeedsDisplay(self.bounds)
        }
    }
    var startAngle: CGFloat = 90 {
        didSet {
            guard superview != nil else { return }
            self.setNeedsDisplay(self.bounds)
        }
    }
    var angle: CGFloat = 260 {
        didSet {
            guard superview != nil else { return }
            self.setNeedsDisplay(self.bounds)
        }
    }
    override func layout() {
        self.setNeedsDisplay(self.bounds)
        super.layout()
    }
    override func draw(_ dirtyRect: NSRect) {
        let path = NSBezierPath.init()
        
        path.appendArc(withCenter: self.bounds.size.getCenter(),
                       radius: radius,
                       startAngle: startAngle,
                       endAngle: startAngle+angle,
                       clockwise: isClockWise)
        path.lineWidth = width
        color.setStroke()
        path.stroke()
    }
}
//MARK: - convinient setting
extension RingView {
    func set(isClockWise: Bool? = nil,
             radius: CGFloat? = nil,
             width: CGFloat? = nil,
             color: NSColor? = nil,
             startAngle: CGFloat? = nil,
             angle: CGFloat? = nil) {
        isClockWise.transportData(to: &self.isClockWise)
        radius.transportData(to: &self.radius)
        width.transportData(to: &self.width)
        color.transportData(to: &self.color)
        startAngle.transportData(to: &self.startAngle)
        angle.transportData(to: &self.angle)
    }
    func set(isClockWise: Bool? = nil,
             radius: CGFloat? = nil,
             width: CGFloat? = nil,
             color: NSColor? = nil,
             startAngle: CGFloat? = nil,
             endAngle: CGFloat? = nil) {
        startAngle.transportData(to: &self.startAngle)
        isClockWise.transportData(to: &self.isClockWise)
        if let unwrappedeEndAngle = endAngle?.toUnitDegree() {
            self.startAngle = self.startAngle.toUnitDegree()
            var angle = unwrappedeEndAngle - self.startAngle
            angle = self.isClockWise ?
                (angle < 0 ? angle : angle-360) :
                (angle > 0 ? angle : angle+360)
            self.set(radius: radius, width: width, color: color, angle: angle)
            return
        }
        self.set(radius: radius, width: width, color: color, angle: nil)
    }
    func setEndAngle(endAngle: CGFloat) {
        let unwrappedeEndAngle = endAngle.toUnitDegree()
        self.startAngle = self.startAngle.toUnitDegree()
        guard unwrappedeEndAngle != self.startAngle else {
            angle = 0
            return
        }
        self.angle = unwrappedeEndAngle - self.startAngle
        self.angle = self.isClockWise ?
            (angle < 0 ? angle : angle-360) :
            (angle > 0 ? angle : angle+360)
    }
}

