//
//  PlusSymbol.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/21/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class PlusSymbolBtn: ButtonView {
    var reactionBlk: () -> () = { }
    var option: Options = .defuat
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        super.addReaction { [unowned self] in
            self.reactionBlk()
        }
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
    }
    override func layout() {
        super.layout()
        setNeedsDisplay(self.bounds)
    }
    enum Options {
        case withFrame(NSColor, NSColor)
        case withoutFrame(NSColor)
        case defuat
    }
}

extension PlusSymbolBtn {
    private func drawWithFrame(backgroundColor: NSColor, symbolColor: NSColor) {
        var rect = CGRect()
        rect.size = CGSize.init(length: self.bounds.width < self.bounds.height ? self.bounds.width : self.bounds.height)
        rect.origin = self.boundCenter.minus(point: rect.size.scaled(by: 0.5).toPoint())
        let circlePath = NSBezierPath.init(ovalIn: rect)
        
        let horizantalPath = NSBezierPath()
        horizantalPath.move(to: CGPoint(x: rect.width/10, y: self.boundCenter.y))
        horizantalPath.line(to: CGPoint(x: rect.width*9/10, y: self.boundCenter.y))
        let verticlePath = NSBezierPath()
        verticlePath.move(to: CGPoint(x: self.boundCenter.x, y: rect.height/10))
        verticlePath.line(to: CGPoint(x: self.boundCenter.x, y: rect.height*9/10))
        horizantalPath.lineWidth = rect.height/10
        verticlePath.lineWidth = rect.height/10
        
        backgroundColor.setFill()
        circlePath.fill()
        symbolColor.setStroke()
        horizantalPath.stroke()
        verticlePath.stroke()
    }
    private func drawWithoutFrame(symbolColor: NSColor) {
        var rect = CGRect()
        rect.size = CGSize.init(length: self.bounds.width < self.bounds.height ? self.bounds.width : self.bounds.height)
        rect.origin = self.boundCenter.minus(point: rect.size.scaled(by: 0.5).toPoint())
        
        let horizantalPath = NSBezierPath()
        horizantalPath.move(to: CGPoint(x: rect.width/10, y: self.boundCenter.y))
        horizantalPath.line(to: CGPoint(x: rect.width*9/10, y: self.boundCenter.y))
        let verticlePath = NSBezierPath()
        verticlePath.move(to: CGPoint(x: self.boundCenter.x, y: rect.height/10))
        verticlePath.line(to: CGPoint(x: self.boundCenter.x, y: rect.height*9/10))
        horizantalPath.lineWidth = rect.height/10
        verticlePath.lineWidth = rect.height/10
        
        symbolColor.setStroke()
        horizantalPath.stroke()
        verticlePath.stroke()
    }
    private func drawWithDefuat() {
        var rect = CGRect()
        rect.size = CGSize.init(length: self.bounds.width < self.bounds.height ? self.bounds.width : self.bounds.height)
        rect.origin = self.boundCenter.minus(point: rect.size.scaled(by: 0.5).toPoint())
        let circlePath = NSBezierPath.init(ovalIn: rect)
        
        let horizantalPath = NSBezierPath()
        horizantalPath.move(to: CGPoint(x: rect.width/10, y: self.boundCenter.y))
        horizantalPath.line(to: CGPoint(x: rect.width*9/10, y: self.boundCenter.y))
        let verticlePath = NSBezierPath()
        verticlePath.move(to: CGPoint(x: self.boundCenter.x, y: rect.height/10))
        verticlePath.line(to: CGPoint(x: self.boundCenter.x, y: rect.height*9/10))
        horizantalPath.lineWidth = rect.height/10
        verticlePath.lineWidth = rect.height/10
        
        NSColor.lightGray.setFill()
        circlePath.fill()
        NSColor.white.setStroke()
        horizantalPath.stroke()
        verticlePath.stroke()
    }
}









