//
//  AWMonthView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 2/18/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWMonthView: NSView {
    weak var calendarSystem: CalenderSystemDelegate?
    var date: NSDate = NSDate()
    var header: NSTextView = NSTextView()
    var dayViewPos: [(Int, Int)] = []
    var dayView: [ButtonView] = []
    var weekView: [ButtonView] = []
    var verticleScrollView: ScrollView = ScrollView()
    init(date: NSDate, frame: CGRect) {
        self.date = date
        super.init(frame: frame)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
    }
    override func layout() {
        super.layout()
    }
}

extension AWMonthView {
    private func setupHeader() {
        header.removeFromSuperview()
        header.string = date.getYear() + "年" + date.getMonth() + "月"
        header.textColor = NSColor(cgColor: ColorBoard.textColor1)
        header.font = NSFont.systemFont(ofSize: 50)
        
    }
    private func setupWeekBar() {
        let weekDayStr = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
        weekView.forEach { (arg) in
            arg.removeFromSuperview()
        }
        weekView.removeAll()
        for index in 0...6 {
            let view = ButtonView()
            let text = NSTextView()
            text.string = weekDayStr[index]
            text.font = NSFont.systemFont(ofSize: 24)
            text.textColor = NSColor.init(cgColor: ColorBoard.textColor1)
            text.alignment = .center
            view.frame.size = CGSize(width: self.bounds.width, height: 50)
            view.addReaction { [unowned self] in
                self.selectedWeekDay(index: index)
            }
            text.frame = view.bounds
            weekView.append(view)
            view.addSubview(text)
            self.addSubview(view)
        }
    }
    private func setupDayView() {
        guard let calendarSystem = self.calendarSystem else {
            return
        }
        dayView.forEach { (arg) in
            arg.removeFromSuperview()
        }
        dayView.removeAll()
        dayViewPos.removeAll()
        let firstDay = calendarSystem.firstDayInMonth(for: self.date)
        let offset = self.date.getWeekDay()
        for index in 0..<calendarSystem.numberOfDay(in: self.date.yearVal(),
                                                    month: self.date.monthVal())
        {
            let view = generateDayView()
            dayView.append(view)
            self.addSubview(view)
            dayViewPos.append(((index+offset)%7, (index+offset)/7))
        }
    }
    private func generateDayView() -> ButtonView {
        let view = ButtonView()
//        let text = 
        return ButtonView()
    }
    private func layoutHeader() {
        header.sizeToFit()
        header.center.y = self.bounds.height-70
        header.frame.origin.x = 30
    }
    private func layoutWeekBar() {
        guard let calendarSystem = self.calendarSystem else {
            return
        }
        let offset = self.date.getWeekDay()
        let days = calendarSystem.numberOfDay(in: self.date.yearVal(),
                                              month: self.date.monthVal())
        let rows = CGFloat((days+offset)/7 + ((days+offset)%7 > 0 ? 1 : 0))
        for index in 0..<weekView.count {
            weekView[index].frame = CGRect.init(x: CGFloat(index)*self.bounds.width,
                                                y: self.bounds.height-100,
                                                width: self.bounds.width/7,
                                                height: (weekView[0].frame.origin.y-20)/rows)
        }
    }
    private func layoutDayView() {
        
    }
}

extension AWMonthView {
    private func selectedWeekDay(index: Int) {
        
    }
}
