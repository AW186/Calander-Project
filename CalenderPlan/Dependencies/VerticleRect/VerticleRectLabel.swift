//
//  RoundRectLabel.swift
//  MyDocumentBasedTest
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/21/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class VerticleRectLabel: NSView {
    private let label: NSTextField
    private let rect: RectView
    init() {
        label = NSTextField()
        rect = RectView.init(frame: NSRect.zero, option: .backgroundColor(NSColor.black.cgColor))
        super.init(frame: NSRect.zero)
    }
    init(frame frameRect: NSRect, text: String, fontSize: CGFloat, option: RectView.Options) {
        switch option {
        case .border(let arg, _):
            label = NSTextField(frame: CGRect.init(origin: CGPoint.zero, size: frameRect.size).growBig(byRadius: -arg))
        case .borderAndColor(let arg, _, _):
            label = NSTextField(frame: CGRect.init(origin: CGPoint.zero, size: frameRect.size).growBig(byRadius: -arg))
        default:
            label = NSTextField(frame: CGRect.init(origin: CGPoint.zero, size: frameRect.size))
        }
        label.stringValue = text
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont.systemFont(ofSize: fontSize)
        label.alignment = .center
        label.textColor = NSColor(cgColor: ColorBoard.textColor1)
        self.rect = RectView.init(frame: CGRect.init(origin: CGPoint.zero, size: frameRect.size), option: option)
        super.init(frame: frameRect)
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.addSubview(rect)
        self.addSubview(label)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
