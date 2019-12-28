//
//  Circle.swift
//  CalenderPlan
//
//10/16/18.
//
//

import Foundation
import Cocoa

class Circle: NSView {
    var option: Options {
        didSet {
            setNeedsDisplay(self.bounds)
        }
    }
    init(frame: CGRect, option: Options) {
        self.option = option
        super.init(frame: frame)
    }
    init() {
        self.option = .border(1, NSColor.black.cgColor)
        super.init(frame: CGRect.zero)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    enum Options {
        case border(CGFloat, CGColor)
        case backgroundColor(CGColor)
        case borderAndColor(CGFloat, CGColor, CGColor)
        func generateCircle() -> (CGRect) -> Circle {
            return {frame in
                return Circle.init(frame: frame, option: self)
            }
        }
    }
    override func layout() {
        setNeedsDisplay(self.bounds)
        super.layout()
    }
    override func draw(_ dirtyRect: NSRect) {
        switch option {
        case .border(let lineWidth, let lineColor):
            stroke(lineWidth: lineWidth, lineColor: NSColor(cgColor: lineColor)!)
        case .backgroundColor(let bgc):
            fill(bgc: NSColor(cgColor: bgc)!)
        case .borderAndColor(let lineWidth, let lineColor, let bgc):
            fill(bgc: NSColor(cgColor: bgc)!)
            stroke(lineWidth: lineWidth, lineColor: NSColor(cgColor: lineColor)!)
        }
    }
    static func generateCirclePath(rect: CGRect) -> NSBezierPath {
        return NSBezierPath.init(ovalIn: rect.smallSquare)
    }
    private func stroke(lineWidth: CGFloat, lineColor: NSColor) {
        let rect = self.bounds.growBig(byRadius: -lineWidth/2)
        let path = Circle.generateCirclePath(rect: rect)
        path.lineWidth = lineWidth
        lineColor.setStroke()
        path.stroke()
    }
    private func fill(bgc: NSColor) {
        let path = Circle.generateCirclePath(rect: self.bounds)
        bgc.setFill()
        path.fill()
    }
}
