//
//  VarificationView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 4/9/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class VarificationView: NSView {
    let uidLabel: NSTextField = NSTextField()
    let inputLabel: NSTextField = NSTextField()
    let welcomeLabel: NSTextField = NSTextField()
    let completeLabel: NSTextField = NSTextField()
    var completeBlock: (String) -> () = { _ in }
    let varifyCode: [Character] = ["^", "#", "?", ">", "@", "!", "&", "%", "*", "$"]
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
        setupWelcomeLabel()
        setupUidLabel()
        setupInputLabel()
        setupCompleteLabel()
    }
    override func layout() {
        super.layout()
        layoutWelcomeLabel()
        layoutUidLabel()
        layoutInputLabel()
        layoutCompleteLabel()
    }
    private func setupCompleteLabel() {
        completeLabel.removeFromSuperview()
        completeLabel.stringValue = "完成"
        completeLabel.textColor = NSColor(cgColor: ColorBoard.yuanshanzi)
        completeLabel.isEditable = false
        completeLabel.isBordered = false
        let gesture = NSClickGestureRecognizer.init(target: self, action: #selector(completeActionBlk))
        completeLabel.addGestureRecognizer(gesture)
        self.addSubview(completeLabel)
    }
    private func layoutCompleteLabel() {
        completeLabel.font = NSFont.systemFont(ofSize: 40)
        completeLabel.sizeToFit()
        completeLabel.center.x = inputLabel.center.x
        completeLabel.frame.leftTopCorner.y = inputLabel.frame.leftBottomCorner.y-10
    }
    @objc func completeActionBlk() {
        if varify() {
            completeBlock(inputLabel.stringValue)
        }
    }
    private func varify() -> Bool {
        let uid = getuid()
        var characters = [Int]()
        var index = UInt32(uid)
        var count = 0
        print(uid)
        while(index != 0) {
            characters.append(Int((Int(index)+count)%10))
            index /= 10
        }
        count = 0
        var retval = true
        guard inputLabel.stringValue.count == characters.count else {
            print("\(inputLabel.stringValue.count) vs \(characters.count)")
            print("\(inputLabel.stringValue) vs \(characters)")
            inputLabel.stringValue.forEach { (arg) in
                print(arg)
            }
            return false
        }
        inputLabel.stringValue.forEach { (arg) in
            print("arg: \(arg)")
            print("code: \(varifyCode[characters[count]])")
            if arg != varifyCode[(characters[count]+count)%10] {
                retval = false
            }
            count += 1
        }
        return retval
    }
    private func setupUidLabel() {
        uidLabel.removeFromSuperview()
        uidLabel.stringValue = "用户ID: \(getuid())"
        uidLabel.textColor = NSColor(cgColor: ColorBoard.textColor2)
        uidLabel.isEditable = false
        uidLabel.isBordered = false
        self.addSubview(uidLabel)
    }
    private func setupWelcomeLabel() {
        welcomeLabel.removeFromSuperview()
        welcomeLabel.stringValue = "欢迎使用【激活页面】"
        welcomeLabel.textColor = NSColor(cgColor: ColorBoard.textColor2)
        welcomeLabel.isEditable = false
        welcomeLabel.isBordered = false
        self.addSubview(welcomeLabel)
    }
    private func setupInputLabel() {
        inputLabel.removeFromSuperview()
        inputLabel.placeholderString = "输入激活码"
        inputLabel.textColor = NSColor(cgColor: ColorBoard.textColor2)
        inputLabel.isEditable = true
        inputLabel.isBordered = true
        
        self.addSubview(inputLabel)
    }
    private func layoutWelcomeLabel() {
        welcomeLabel.font = NSFont.systemFont(ofSize: 50)
        welcomeLabel.sizeToFit()
        welcomeLabel.center.x = self.bounds.width/2
        welcomeLabel.center.y = self.bounds.height*4/5
    }
    private func layoutUidLabel() {
        uidLabel.font = NSFont.systemFont(ofSize: 24)
        uidLabel.sizeToFit()
        uidLabel.center.x = self.bounds.width/2
        uidLabel.frame.leftTopCorner.y = welcomeLabel.frame.leftBottomCorner.y-60
    }
    private func layoutInputLabel() {
        inputLabel.font = NSFont.systemFont(ofSize: 24)
        inputLabel.sizeToFit()
        inputLabel.frame.size.width = uidLabel.frame.width
        inputLabel.center.x = self.bounds.width/2
        inputLabel.frame.leftTopCorner.y = uidLabel.frame.leftBottomCorner.y-10
    }
}
