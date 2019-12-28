//
//  YearView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 2/18/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWYearView: AWNavigationView {
    weak var calendarSystem: CalenderSystemDelegate?
    var date: NSDate = NSDate()
    init(date: NSDate, frame: CGRect) {
        self.date = date
        super.init(frame: frame)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupMonthView() {
        
    }
    func layoutMonthView() {
        
    }
}

