//
//  RingSlider.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/13/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//
import Cocoa
import Foundation

class RingSlider: NSView {
    private var enableReaction = false
    private var radius: CGFloat {
        return (bounds.width <? bounds.height)/2-ringWidth/2
    }
    var reactionBlk: (CGFloat) -> () = {_ in }
    var ringWidth: CGFloat = 25 {
        didSet {
            backgroundRingView.width = ringWidth
            tintRingView.width = ringWidth
        }
    }
    var backgroundRingColor: NSColor = NSColor.lightGray {
        didSet {
            backgroundRingView.color = backgroundRingColor
        }
    }
    var tintRingColor: NSColor = NSColor(cgColor: ColorBoard.tintTextColor)! {
        didSet {
            tintRingView.color = tintRingColor
        }
    }
    var fromAngle: CGFloat = 210 {
        didSet {
            tintRingView.startAngle = fromAngle
            backgroundRingView.startAngle = fromAngle
        }
    }
    var toAngle: CGFloat = 330 {
        didSet {
            backgroundRingView.set(endAngle: toAngle)
        }
    }
    var isClockWise: Bool = true {
        didSet {
            tintRingView.set(isClockWise: isClockWise, endAngle: nil)
            backgroundRingView.set(isClockWise: isClockWise, endAngle: nil)
        }
    }
    var enableEidit: Bool = false {
        didSet {
            guard superview != nil else {
                return
            }
            enableEidit ? setUpControl() : control.removeFromSuperview()
        }
    }
    var percentage: CGFloat {
        return AWAngle(currentAngle).minus(angle: AWAngle(fromAngle), clockwise: isClockWise).cgFloat /
            AWAngle(toAngle).minus(angle: AWAngle(fromAngle), clockwise: isClockWise).cgFloat
    }
    private var angleDifference: CGFloat {
        return currentAngle-fromAngle
    }
    private var currentAngle: CGFloat = 120 {
        didSet {
            tintRingView.setEndAngle(endAngle: currentAngle)
            layoutControl()
            reactionBlk(percentage)
        }
    }
    private var backgroundRingView: RingView = RingView()
    private var tintRingView: RingView = RingView()
    private var control: Circle = Circle()
}
//MARK: - setup and layout
extension RingSlider {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUpBackgroundRingView()
        setUpTintRingView()
        enableEidit ? setUpControl() : control.removeFromSuperview()
    }
    override func layout() {
        super.layout()
        layoutControl()
        layoutTintRingView()
        layoutBackgroundRingView()
    }
    private func setUpBackgroundRingView() {
        backgroundRingView.frame = self.bounds
        backgroundRingView.set(isClockWise: self.isClockWise,
                               radius: self.radius,
                               width: self.ringWidth,
                               color: self.backgroundRingColor,
                               startAngle: self.fromAngle,
                               endAngle: self.toAngle)
        self.addSubview(backgroundRingView)
    }
    private func setUpTintRingView() {
        tintRingView.frame = self.bounds
        tintRingView.set(isClockWise: self.isClockWise,
                         radius: self.radius,
                         width: self.ringWidth,
                         color: self.tintRingColor,
                         startAngle: self.fromAngle,
                         endAngle: self.currentAngle)
        self.addSubview(tintRingView)
    }
    private func setUpControl() {
        control = Circle()
        control.frame.size = CGSize.init(length: ringWidth)
        control.option = .backgroundColor(NSColor.darkGray.cgColor)
        control.wantsLayer = true
        control.layer?.backgroundColor = ColorBoard.borderColor1
        control.roundTwoSides()
        control.center = self.boundCenter.plus(point: CGPoint.init(radius: self.radius, angle: currentAngle*CGFloat.pi/180))
        self.addSubview(control)
    }
    private func layoutBackgroundRingView() {
        backgroundRingView.frame = self.bounds
    }
    private func layoutTintRingView() {
        tintRingView.frame = self.bounds
    }
    private func layoutControl() {
        control.frame.size = CGSize.init(length: ringWidth)
        control.center = self.boundCenter.plus(point:
            CGPoint.init(radius: radius, angle: currentAngle.degreeToArc()))
    }
}
//MARK: - User interaction
extension RingSlider {
    override func mouseDown(with event: NSEvent) {
        guard enableEidit else {
            return
        }
        let location = windowLocationTransform(point: event.locationInWindow)
        enableReaction = control.frame.contains(location)
        super.mouseDown(with: event)
    }
    override func mouseDragged(with event: NSEvent) {
        guard enableReaction else {
            super.mouseDragged(with: event)
            return
        }
        let location = windowLocationTransform(point: event.locationInWindow)
        changeCurrentAngle(by: location)
        super.mouseDragged(with: event)
    }
    func changeCurrentAngle(by location: CGPoint) {
        var unitArc = location.minus(point: self.boundCenter).toArc().arcToDegree()
        unitArc -= currentAngle
        unitArc = unitArc.remainder(dividingBy: (2*180))
        unitArc = (unitArc < 0 ? unitArc+180*2 : unitArc)
        unitArc = unitArc > 180 ? unitArc-180*2 : unitArc //unitArc in range of -180 to 180
        if isClockWise {
            if unitArc < 0 {
                var avaliableSpace = toAngle - currentAngle
                avaliableSpace -= avaliableSpace > 0 ? 360 : 0 //avaliable space can only be negative
                currentAngle += unitArc > avaliableSpace ? unitArc : avaliableSpace
            } else {
                var avaliableSpace = fromAngle - currentAngle
                avaliableSpace += avaliableSpace < 0 ? 360 : 0 //avaliable space can only be positive
                currentAngle += unitArc < avaliableSpace ? unitArc : avaliableSpace
            }
        } else {
            if unitArc < 0 {
                var avaliableSpace = fromAngle - currentAngle
                avaliableSpace -= avaliableSpace > 0 ? 360 : 0 //avaliable space can only be negative
                currentAngle += unitArc > avaliableSpace ? unitArc : avaliableSpace
            } else {
                var avaliableSpace = toAngle - currentAngle
                avaliableSpace += avaliableSpace < 0 ? 360 : 0 //avaliable space can only be positive
                currentAngle += unitArc < avaliableSpace ? unitArc : avaliableSpace
            }
        }
    }
    override func mouseUp(with event: NSEvent) {
        enableReaction = false
        super.mouseUp(with: event)
    }
    private func windowLocationTransform(point: CGPoint) -> CGPoint {
        return point.minus(point: self.referenceOrigin)
    }
}





