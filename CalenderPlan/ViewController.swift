//
//  ViewController.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/15/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    private var timer = Timer()
    private var vview = VarificationView()
    private var didVarified = false
    
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
        if varify() {
           setup()
        } else {
            vview = VarificationView.init(frame: self.view.bounds)
            vview.completeBlock = { [unowned self] (arg) in
                self.setup()
                self.generateUserInfoFile(str: arg)
                self.vview.removeFromSuperview()
            }
            self.view.addSubview(vview)
        }
//        self.view.addSubview(testRingSlider)
    }
    
    private func setup() {
        didVarified = true
        getModel()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = ColorBoard.yuebai
        self.view.addSubview(bookView)
        self.view.addSubview(leftDateCheckingView)
        
        if #available(OSX 10.12, *) {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { [unowned self] (_) in
                self.leftDateCheckingView.refresh()
                self.bookView.refresh()
            })
        } else {
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshFunc), userInfo: nil, repeats: true)
            // Fallback on earlier versions
        }
    }
    
    @objc private func refreshFunc() {
        self.leftDateCheckingView.refresh()
        self.bookView.refresh()
    }
    
    private func getModel() {
        let filePath: String = NSHomeDirectory() + "/Documents/datap.plist"
        print(filePath)
        let fm = FileManager.default
        guard fm.fileExists(atPath: filePath) else {
            generateFile()
            return getModel()
        }
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
    private func varify() -> Bool {
        let uid = getuid()
        var characters = [Int]()
        var index = UInt32(uid)
        var count = 0
        while(index != 0) {
            characters.append(Int((Int(index)+count)%10))
            index /= 10
            count += 1
        }
        count = 0
        var retval = true
        let filePath = NSHomeDirectory() + "/Documents/info.file"
        guard let stringVal = try? String.init(contentsOfFile: filePath) else {
            return false
        }
        guard stringVal.count == characters.count else {
            return false
        }
        let varifyCode: [Character] = ["^", "#", "?", ">", "@", "!", "&", "%", "*", "$"]
        stringVal.forEach { (arg) in
            if arg != varifyCode[(characters[count])%10] {
                retval = false
            }
            count += 1
        }
        return retval
    }
    private func generateUserInfoFile(str: String) {
        let filePath = NSHomeDirectory() + "/Documents/info.file"
        do {
            try str.write(toFile: filePath, atomically: true, encoding: String.Encoding.utf16)
        } catch {
            print("error occured when writting data to info.file")
        }
    }
    func generateFile() {
        let dueDate: TimeInterval! = NSDate.dateFrom(year: 2018, month: 12, day: 1)?.timeIntervalSince1970
        let fromDate1: TimeInterval! = NSDate.dateFrom(year: 2018, month: 5, day: 9)?.timeIntervalSince1970
        let fromDate2: TimeInterval! = NSDate.dateFrom(year: 2018, month: 10, day: 10)?.timeIntervalSince1970
        let array = [[Event(dueDate: dueDate, fromDate: fromDate1, name: "事件1")], [Event(dueDate: dueDate, fromDate: fromDate2, name: "Event1")]]
        let filePath: String = NSHomeDirectory() + "/Documents/datap.plist"
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
        if(didVarified) {
            leftDateCheckingView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 450, height: self.view.bounds.height))
            var rect = self.view.bounds
            rect.origin.x = leftDateCheckingView.frame.width
            rect.size.width -= leftDateCheckingView.frame.width
            bookView.frame = rect
        } else {
            vview.frame = self.view.bounds
        }
    }
}

