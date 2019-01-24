//
//  ViewController.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/15/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    private lazy var leftDateCheckingView: LeftDateCheckingView = {
        let view = LeftDateCheckingView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 450, height: self.view.bounds.height)))
        return view
    }()
    
    private lazy var bookView: EventsListView = {
        var rect = self.view.bounds
        rect.origin.x = leftDateCheckingView.frame.width
        rect.size.width -= leftDateCheckingView.frame.width
        let dueDate: TimeInterval! = NSDate.dateFrom(year: 2018, month: 12, day: 1)?.timeIntervalSince1970
        let fromDate1: TimeInterval! = NSDate.dateFrom(year: 2018, month: 5, day: 9)?.timeIntervalSince1970
        let fromDate2: TimeInterval! = NSDate.dateFrom(year: 2018, month: 10, day: 10)?.timeIntervalSince1970
        return EventsListView.init(frame: rect, model: (AppDelegate.model[0], AppDelegate.model[1]))
    }()
    lazy var testRingSlider: RingSlider = {
        let slider = RingSlider()
        slider.frame = self.view.bounds
        slider.enableEidit = true
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        generateFile()
        getModel()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.cgColor
        self.view.addSubview(bookView)
        self.view.addSubview(leftDateCheckingView)
//        self.view.addSubview(testRingSlider)
    }
    
    private func getModel() {
        let filePath: String = NSHomeDirectory() + "/Documents/webs.plist"
        let arr = NSArray.init(contentsOfFile: filePath) as! [[Dictionary<String, String>]]
        let eventArr1 = arr[0].map({ (arg) -> Event in
            return Event.init(dict: arg)
        })
        let eventArr2 = arr[1].map({ (arg) -> Event in
            return Event.init(dict: arg)
        })
        AppDelegate.model = [EventList(array: eventArr1), EventList(array: eventArr2)]
    }
    override func viewDidAppear() {
        guard let window = self.view.window else {
            fatalError()
        }
        window.isMovableByWindowBackground = false
    }
    func generateFile() {
        let dueDate: TimeInterval! = NSDate.dateFrom(year: 2018, month: 12, day: 1)?.timeIntervalSince1970
        let fromDate1: TimeInterval! = NSDate.dateFrom(year: 2018, month: 5, day: 9)?.timeIntervalSince1970
        let fromDate2: TimeInterval! = NSDate.dateFrom(year: 2018, month: 10, day: 10)?.timeIntervalSince1970
        let array = [[Event(dueDate: dueDate, fromDate: fromDate1, name: "事件1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1")], [Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1"), Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1")]]
        let filePath: String = NSHomeDirectory() + "/Documents/webs.plist"
        let newArr = array.map { (arr) -> [Dictionary<String, String>] in
            return arr.map({ (arg) -> Dictionary<String, String> in
                return arg.toDict()
            })
        }
        (newArr as NSArray).write(toFile: filePath, atomically: true)
        let arr = NSArray.init(contentsOfFile: filePath)
        print(arr)
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        leftDateCheckingView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 450, height: self.view.bounds.height))
        var rect = self.view.bounds
        rect.origin.x = leftDateCheckingView.frame.width
        rect.size.width -= leftDateCheckingView.frame.width
        bookView.frame = rect
    }
}

