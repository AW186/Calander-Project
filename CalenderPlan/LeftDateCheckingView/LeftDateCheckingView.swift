//
//  LeftDateCheckingView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/18/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class LeftDateCheckingView: NSView {
    private lazy var dateView: DateView = {
        let view = DateView(frame: CGRect.init(x: 0, y: self.bounds.height-450, width: 450, height: 450))
        view.layer?.masksToBounds = false
        return view
    }()
    private func setShadow() {
        self.wantsLayer = true
        self.shadow = NSShadow()
        self.layer?.backgroundColor = ColorBoard.yuebai
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowOpacity = 0.2
        self.layer?.shadowOffset = CGSize(width: 0, height: 0)
        self.layer?.shadowRadius = 30
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.addSubview(dateView)
        setShadow()
    }
    override func layout() {
        super.layout()
        dateView.frame.origin.y = self.bounds.height-450
    }
    func refresh() {
        dateView.refresh()
    }
}
