//
//  EventsListView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/20/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class EventsListView: NSView {
    private var bookView: BookView = BookView.init()
    private let model: ([Event], [Event])
    private let gap: CGFloat = 50
    private var eventEditingView: EventEditModelView = EventEditModelView.init(frame: NSRect.zero, event: Event.init(dueDate: 0, fromDate: 0, name: ""))
    var transportModel: (([Event], [Event])) -> () = { _ in }
    private var modalEnable = true
    init(frame frameRect: NSRect, model: ([Event], [Event])) {
        self.model = model
        super.init(frame: frameRect)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EventsListView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUp()
    }
    override func layout() {
        super.layout()
        bookView.frame = self.bounds
        layoutEditingView()
    }
    private func layoutEditingView() {
        eventEditingView.frame = self.bounds
        eventEditingView.frame.origin.x += gap
        eventEditingView.frame.size.width -= gap
    }
    private func setUp() {
        setUpBookView()
    }
    private func setUpBookView() {
        bookView.removeFromSuperview()
        bookView = BookView.init(frame: self.bounds)
        bookView.dataSource = self
        self.addSubview(bookView)
    }
}
extension EventsListView: BookViewDataSource {
    func pageControlSepratorStyle() -> BookView.PageControlSaperateStyle {
        return .shadow(BookView.PageControlSaperateStyle.ShadowInfo())
    }
    
    func numberOfPages() -> Int {
        return 2
    }
    
    func viewForEachPage(for page: Int) -> EventTable {
        let retval = page == 0 ? EventTable.init(frame: self.bounds, model: model.0) : EventTable.init(frame: self.bounds, model: model.1)
        retval.rowDidClickedReactionBlk = { row in
            print("page: \(page), row: \(row)")
            self.enableEventEdit(page: page, row: row)
        }
        return retval
    }
    
    func enableEventEdit(page: Int, row: Int) {
        guard modalEnable else {
            return
        }
        let event = page == 0 ? model.0[row] : model.1[row]
        eventEditingView = EventEditModelView.init(frame: self.bounds, event: event)
        eventEditingView.frame.size.width -= gap
        eventEditingView.frame.origin = self.bounds.rightBottomCorner
        eventEditingView.callBackBlk = { [unowned self] in
            self.bookView.refreshAt(page: page, row: row)
            self.disableEventEdit()
        }
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            let start = self.bounds.width
            let end = self.gap
            self.eventEditingView.animator().setFrameOrigin(NSPoint(x: start + (end - start), y: 0))
        }, completionHandler: nil)
        
        self.addSubview(eventEditingView)
        modalEnable = false
    }
    
    func disableEventEdit() {
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            self.eventEditingView.animator().setFrameOrigin(NSPoint(x: self.bounds.width, y: 0))
        }, completionHandler: { [unowned self] in
            self.eventEditingView.removeFromSuperview()
            self.modalEnable = true
        })
    }
    
    func pageContentSyle() -> PageContentStyle {
        return .full
    }
    
    func pageControlStyle() -> BookView.PageControlStyle {
        return .full
    }
    
    func pageTitle(for page: Int) -> String {
        return ["长期任务栏", "今日任务"][page]
    }
}
