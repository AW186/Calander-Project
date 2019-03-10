//
//  DateView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/15/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class DateView: NSView {
    private let roundSquareRatio: CGFloat = 0.8
    private var radius: CGFloat {
        return self.bounds.height < self.bounds.width ?
            self.bounds.height*roundSquareRatio/2 :
            self.bounds.width*roundSquareRatio/2
    }
    private var leftMidPoint: CGPoint {
        return self.boundCenter.plus(point: CGPoint(x: -radius, y: 0))
    }
    private var rightMidPoint: CGPoint {
        return self.boundCenter.plus(point: CGPoint(x: radius, y: 0))
    }
    private var date: NSDate = NSDate()
    private var holidayLabel: NSTextField = NSTextField()
    private var seasonLabel: VerticleRectLabel = VerticleRectLabel()
    private var yearMonthLabel: NSTextField = NSTextField()
    private var dayLabel: NSTextField = NSTextField()
    private var chineseCalenderLabel: NSTextField = NSTextField()
    private var circle: Circle = Circle()
}

extension DateView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUp()
    }
    private func setUp() {
        setUpCircle()
        setUpHolidayLabel()
        setUpSeasonLabel()
        setUpChineseCalenderLabel()
        setUpYearMonthLabel()
        setUpDayLabel()
    }
    private func setUpHolidayLabel() {
        let holiday = date.getHoliday()
    }
    private func setUpSeasonLabel() {
        seasonLabel.removeFromSuperview()
        let season = date.toChineseSeason()
        var rect = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: radius/3, height: radius/1.37))
        rect.origin = self.leftMidPoint
        seasonLabel = VerticleRectLabel.init(frame: rect, text: ChineseSeason.getSeasonVerticleString(), fontSize: radius/4, option: .borderAndColor(3, ColorBoard.borderColor2, ColorBoard.yuebai))
        self.addSubview(seasonLabel)
    }
    private func setUpYearMonthLabel() {
        yearMonthLabel.removeFromSuperview()
        let text = date.toStringByFormat(format: "yyyy年MM月")
        let attributetext = NSMutableAttributedString.init(string: text)
        attributetext.addAttributes([NSAttributedStringKey.font: NSFont.systemFont(ofSize: 30)], range: NSRange.init(location: 0, length: 4))
        attributetext.addAttributes([NSAttributedStringKey.font: NSFont.systemFont(ofSize: 20)], range: NSRange.init(location: 4, length: 1))
        attributetext.addAttributes([NSAttributedStringKey.font: NSFont.systemFont(ofSize: 30)], range: NSRange.init(location: 5, length: 2))
        attributetext.addAttributes([NSAttributedStringKey.font: NSFont.systemFont(ofSize: 20)], range: NSRange.init(location: 7, length: 1))
        let label = NSTextField()
        label.attributedStringValue = attributetext
        label.isEditable = false
        label.isBordered = false
        label.alignment = .center
        label.textColor = NSColor(cgColor: ColorBoard.textColor1)
        label.sizeToFit()
        label.center = self.boundCenter.plus(point: CGPoint.init(x: 0, y: radius/2))
        self.yearMonthLabel = label
        self.addSubview(yearMonthLabel)
    }
    private func setUpChineseCalenderLabel() {
        chineseCalenderLabel.removeFromSuperview()
        let text = date.getChineseCalender()
        let label = NSTextField()
        label.stringValue = text
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont.systemFont(ofSize: 20)
        label.alignment = .center
        label.textColor = NSColor(cgColor: ColorBoard.textColor1)
        label.sizeToFit()
        label.center = self.boundCenter.plus(point: CGPoint.init(x: 0, y: -radius/2))
        self.chineseCalenderLabel = label
        self.addSubview(chineseCalenderLabel)
    }
    private func setUpDayLabel() {
        dayLabel.removeFromSuperview()
        let text = date.toStringByFormat(format: "dd日")
        let attributetext = NSMutableAttributedString.init(string: text)
        attributetext.addAttributes([NSAttributedStringKey.font: NSFont.systemFont(ofSize: 100)], range: NSRange.init(location: 0, length: 2))
        attributetext.addAttributes([NSAttributedStringKey.font: NSFont.systemFont(ofSize: 30)], range: NSRange.init(location: 2, length: 1))
        let label = NSTextField()
        label.attributedStringValue = attributetext
        label.isEditable = false
        label.isBordered = false
        label.alignment = .center
        label.textColor = NSColor(cgColor: ColorBoard.textColor1)
        label.sizeToFit()
        label.center = self.boundCenter
        self.dayLabel = label
        self.addSubview(dayLabel)
    }
    private func setUpCircle() {
        circle.removeFromSuperview()
        circle = Circle.init(frame: self.bounds.growBig(byScale: roundSquareRatio), option: .border(5, ColorBoard.gutongliu))
        self.addSubview(circle)
    }
    func refresh() {
        setUpHolidayLabel()
        setUpSeasonLabel()
        setUpChineseCalenderLabel()
        setUpYearMonthLabel()
        setUpDayLabel()
    }
}
