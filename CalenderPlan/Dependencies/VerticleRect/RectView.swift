//
//  RectView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/17/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class RectView: NSView {
    private let option: Options
    init(frame frameRect: NSRect, option: Options) {
        self.option = option
        super.init(frame: frameRect)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    private func stroke(lineWidth: CGFloat, lineColor: NSColor) {
        let path = NSBezierPath.init(rect: self.bounds.growBig(byRadius: -lineWidth/2))
        path.lineWidth = lineWidth
        lineColor.setStroke()
        path.stroke()
    }
    private func fill(bgc: NSColor) {
        let path = NSBezierPath.init(rect: self.bounds)
        bgc.setFill()
        path.fill()
    }
    enum Options {
        case border(CGFloat, CGColor)
        case backgroundColor(CGColor)
        case borderAndColor(CGFloat, CGColor, CGColor)
    }
}
