//
//  BookPageControl.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/18/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class BookPageControl: NSView {
    private var currentPage: Int = 0
    private var totalPage: Int = 0
    private var pageReader: [String] = []
    private var textFields: [LabelButton] = []
    var backGroundColor: CGColor = NSColor.white.cgColor
    @objc private var reactionBlks: (()->()) -> () = { blk in
        blk()
    }
    private var length: CGFloat {
        get {
            return textFields.reduce(0, { (retVal, arg) -> CGFloat in
                return retVal+arg.frame.width
            })
        }
    }
    weak var delegate: BookPageControlDelegate?
    init() {
        super.init(frame: NSRect.zero)
    }
    init(frame frameRect: NSRect, totalPage: Int, pageReader: [String]) {
        self.totalPage = totalPage
        self.pageReader = pageReader
        super.init(frame: frameRect)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUp()
    }
    override func layout() {
        super.layout()
        setUp()
    }
    private func setUp() {
        textFields.forEach { (arg) in
            arg.removeFromSuperview()
        }
        textFields.removeAll()
        for index in 0...pageReader.count-1 {
            textFields.append(setUpTextField(index: index))
            self.addSubview(textFields[index])
        }
        toPage(index: currentPage)
    }
    private func setUpTextField(index: Int) -> LabelButton {
        let label = LabelButton()
        label.stringValue = pageReader[index]
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont.systemFont(ofSize: 15)
        label.alignment = .center
        label.textColor = NSColor(cgColor: ColorBoard.textColor1)
        label.sizeToFit()
        label.frame.size.width = self.bounds.width/CGFloat(totalPage)
        label.frame.origin.y = self.frame.height-label.frame.height
        label.frame.origin.x = length
        label.addReaction { [unowned self] in
            self.toPage(index: index)
        }
        return label
    }
    private func toPage(index: Int) {
        delegate?.setDefuat(label: textFields[currentPage])
        delegate?.setTint(label: textFields[index])
        guard let delegate = delegate else {
            return
        }
        currentPage = delegate.accessToPage(page: index)
    }
    func setSeperator(style: BookView.PageControlSaperateStyle) {
        switch style {
        case .shadow(let info):
            setShadow(info: info)
        case .line:
            setLine()
        default:
            break
        }
    }
    private func setShadow(info: BookView.PageControlSaperateStyle.ShadowInfo) {
        self.wantsLayer = true
        self.layer?.masksToBounds = false
        self.shadow = NSShadow()
        self.layer?.backgroundColor = backGroundColor
        self.layer?.shadowColor = info.color
        self.layer?.shadowOpacity = Float(info.alpha)
        self.layer?.shadowOffset = CGSize(width: 0, height: 0)
        self.layer?.shadowRadius = info.radius
    }
    private func setLine() {
        //incomplete
    }
}








