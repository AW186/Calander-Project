//
//  RoundRectLabel.swift
//  MyDocumentBasedTest
//
//9/21/18.
//
//

import Foundation
import Cocoa

class RoundRectLabel: NSView {
    private let label: NSTextField
    var textColor: NSColor = NSColor.darkGray {
        didSet {
            label.textColor = textColor
        }
    }
    var backgroundColor: NSColor = NSColor.lightGray {
        didSet {
            self.layer?.backgroundColor = backgroundColor.cgColor
            label.backgroundColor = backgroundColor
        }
    }
    var reactionBlk: () -> () = {}
    private var clickGesture: NSClickGestureRecognizer = NSClickGestureRecognizer.init()
    @objc private func clickedReaction() {
        reactionBlk()
    }
    var enableClickInteraction = false {
        didSet {
            if enableClickInteraction == false {
                self.removeGestureRecognizer(clickGesture)
            } else {
                clickGesture = NSClickGestureRecognizer(target: self, action: #selector(clickedReaction))
                self.addGestureRecognizer(clickGesture)
            }
        }
    }
    init(text: String, fontSize: CGFloat, size: CGSize) {
        let label = NSTextField()
        label.stringValue = text
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont.systemFont(ofSize: fontSize)
        label.alignment = .center
        label.textColor = textColor
        label.frame.size = size.minus(size: CGSize.init(length: label.frame.height/4))
        self.label = label
        super.init(frame: CGRect.initFrom(size: size))
        self.wantsLayer = true
        self.layer?.backgroundColor = backgroundColor.cgColor
        label.backgroundColor = backgroundColor
    }
    init(text: String, fontSize: CGFloat) {
        let label = NSTextField()
        label.stringValue = text
        label.isEditable = false
        label.isBordered = false
        label.font = NSFont.systemFont(ofSize: fontSize)
        label.alignment = .center
        label.textColor = textColor
        label.sizeToFit()
        self.label = label
        super.init(frame: label.frame.growBig(byRadius: label.frame.height/4))
        self.wantsLayer = true
        self.layer?.backgroundColor = backgroundColor.cgColor
        label.backgroundColor = backgroundColor
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RoundRectLabel {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        label.center = self.boundCenter
        label.center.y -= 3
        self.addSubview(label)
        self.roundTwoSides()
    }
}
