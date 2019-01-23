//
//  EventEditModelView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/10/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class EventEditModelView: NSView {
    private var eventEditingView: EventEditingView
    private var event: Event
    private var backBar: BackBar = BackBar()
    var callBackBlk: () -> () = {}
    init(frame frameRect: NSRect, event: Event) {
        self.event = event
        self.eventEditingView = EventEditingView.init(frame: NSRect.zero, event: event)
        super.init(frame: frameRect)
        backBar.reactionBlk = { [unowned self] in self.callBackBlk() }
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventEditModelView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.addSubview(backBar)
        self.addSubview(eventEditingView)
    }
    override func layout() {
        super.layout()
        layoutBackBar()
        layoutEventEditView()
    }
    func layoutEventEditView() {
        eventEditingView.frame.size.height = self.bounds.height
        eventEditingView.frame.size.width = self.bounds.width-backBar.frame.width
        eventEditingView.frame.origin = backBar.frame.rightBottomCorner
    }
    func layoutBackBar() {
        backBar.frame.size.height = self.bounds.height
        backBar.frame.size.width = 30
        backBar.frame.origin = self.bounds.origin
    }
}
