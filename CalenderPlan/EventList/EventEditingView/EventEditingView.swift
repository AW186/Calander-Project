//
//  EventEditingView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/12/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class EventEditingView: NSView {
    var eventCompletedBlk: () -> () = {}
    var deleteAction: () -> () = { }
    var editBtnFontSize: CGFloat = 20
    let ringSize: CGFloat = 300
    var editing: Bool {
        return self.isEditing
    }
    private var dueDatePicker: NSDatePicker = NSDatePicker.init()
    private var deleteBtn: LabelButton = LabelButton()
    private var fromDatePicker: NSDatePicker = NSDatePicker.init()
    private var editBtn: NSTextField = LabelButton()
    private let event: Event
    private let ringSlider: RingSlider = RingSlider()
    private var nameTextField: LimitedLengthTF = LimitedLengthTF()
    private let dueDateTextField: NSTextField = NSTextField()
    private let dueDateContentTF: NSTextField = NSTextField()
    private let fromDateTextField: NSTextField = NSTextField()
    private let fromDateContentTF: NSTextField = NSTextField()
    private let discriptionTextField: NSTextField = NSTextField()
    private let editIconBtn: EditIconBtn = EditIconBtn()
    private var discriptionContentTF: LimitedLengthTF = LimitedLengthTF()
    private let completeRateTextField: NSTextField = NSTextField()
    private let discriptionScrView: NSScrollView = NSScrollView()
    private var isEditing = false {
        didSet {
            isEditing ? enableEditingMode() : disableEditingMode()
        }
    }
    private var checkEditing: Bool {
        get {
            return isEditing
        }
    }
    init(frame frameRect: NSRect, event: Event) {
        self.event = event
        super.init(frame: frameRect)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventEditingView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.wantsLayer = true
        self.layer?.backgroundColor = ColorBoard.yuebai
        setUpNameTextField()
        setUpRingSlider()
        setUpDueDateTextField()
        setUpFromDateTextField()
        setUpDiscriptionTextField()
        setUpCompleteRateTextField()
        setUpEditBtn()
        setUpEditIconBtn()
        setUpDeleteBtn()
    }
    override func layout() {
        super.layout()
        layoutNameTextField()
        layoutRingSlider()
        layoutDueDateTextField()
        layoutFromDateTextField()
        layoutDiscriptionTextField()
        layoutCompleteRateTextField()
        layoutEditBtn()
        layoutEditIconBtn()
        layoutDueDatePicker()
        layoutFromDatePicker()
        layoutDeleteBtn()
    }
    private func setUpDeleteBtn() {
        deleteBtn.addReaction { [unowned self] in
            if self.dialogOKCancel(question: "确认删除吗？", text: "删除后将无法恢复") {
                self.deleteAction()
            }
        }
        deleteBtn.stringValue = "删除"
        deleteBtn.isEditable = false
        deleteBtn.isBordered = false
        deleteBtn.font = NSFont.systemFont(ofSize: 15)
        deleteBtn.textColor = NSColor(cgColor: ColorBoard.yuhong)
        self.addSubview(deleteBtn)
    }
    private func layoutDeleteBtn() {
        deleteBtn.sizeToFit()
        deleteBtn.frame.origin = editBtn.frame.origin
        deleteBtn.frame.rightTopCorner.x = ringSlider.frame.rightBottomCorner.x
    }
    private func setUpEditIconBtn() {
        editIconBtn.addReaction { [unowned self] in
            self.isEditing = !self.isEditing
        }
        self.addSubview(editIconBtn)
    }
    private func layoutEditIconBtn() {
        editIconBtn.frame.size = CGSize.init(width: 20, height: 20)
        editIconBtn.frame.origin = editBtn.frame.rightBottomCorner.horizantalShift(5).verticalShift(3)
    }
    private func setUpEditBtn() {
        editBtn.isEditable = false
        editBtn.isBordered = false
        editBtn.textColor = NSColor(cgColor: ColorBoard.textColor1)
        editBtn.stringValue = Words.edit[Words.chinese]!
        editBtn.font = NSFont.systemFont(ofSize: editBtnFontSize)
        self.addSubview(editBtn)
    }
    private func layoutEditBtn() {
        editBtn.sizeToFit()
        editBtn.frame.origin = dueDateTextField.frame.leftTopCorner.verticalShift(5)
    }
    private func setUpRingSlider() {
        layoutRingSlider()
        ringSlider.percentage = CGFloat(event.compeletingRate)
        ringSlider.reactionBlk = { [unowned self] (rate) in
            self.completeRateTextField.stringValue = "\(Int(rate*100))%"
            self.layoutCompleteRateTextField()
        }
        self.addSubview(ringSlider)
    }
    private func layoutRingSlider() {
        ringSlider.frame.size = CGSize.init(length: ringSize)
        ringSlider.center.x = self.boundCenter.x
        ringSlider.frame.origin.y = self.bounds.height*7/8-ringSize
    }
    private func setUpNameTextField() {
        nameTextField.stringValue = event.name.count > 0 ? event.name : "未名"
        nameTextField.font = NSFont.systemFont(ofSize: 30)
        nameTextField.maximumNumberOfChar = 10
        nameTextField.textDidChangeBlk = { [unowned self] _ in
            self.layoutNameTextField()
        }
        nameTextField.alignment = .center
        nameTextField.isEditable = false
        nameTextField.isBordered = false
        nameTextField.textColor = NSColor.black
        self.addSubview(nameTextField)
    }
    private func layoutNameTextField() {
        nameTextField.sizeToFit()
        nameTextField.frame.size.width = 350
        nameTextField.frame.origin.y = self.bounds.height-nameTextField.frame.height-10
        nameTextField.center.x = self.boundCenter.x
    }
    private func setUpDueDateTextField() {
        dueDateTextField.stringValue = "截止日期"
        dueDateTextField.font = NSFont.systemFont(ofSize: 15)
        dueDateTextField.isEditable = false
        dueDateTextField.isBordered = false
        dueDateTextField.textColor = NSColor(cgColor: ColorBoard.textColor1)
        self.addSubview(dueDateTextField)
        
        let date = Date(timeIntervalSince1970: event.dueDate)
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        dueDateContentTF.stringValue = format.string(from: date)
        dueDateContentTF.font = NSFont.systemFont(ofSize: 15)
        dueDateContentTF.isEditable = false
        dueDateContentTF.isBordered = false
        dueDateContentTF.textColor = NSColor(cgColor: ColorBoard.textColor1)
        self.addSubview(dueDateContentTF)
    }
    private func layoutDueDateTextField() {
        dueDateTextField.sizeToFit()
        dueDateTextField.frame.origin = ringSlider.frame.origin.verticalShift(20)
        
        dueDateContentTF.sizeToFit()
        dueDateContentTF.frame.origin = dueDateTextField.frame.rightBottomCorner.horizantalShift(5)
    }
    private func setUpFromDateTextField() {
        fromDateTextField.stringValue = "起始日期"
        fromDateTextField.font = NSFont.systemFont(ofSize: 15)
        fromDateTextField.isEditable = false
        fromDateTextField.isBordered = false
        fromDateTextField.textColor = NSColor(cgColor: ColorBoard.textColor1)
        self.addSubview(fromDateTextField)
        
        let date = Date(timeIntervalSince1970: event.fromDate)
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日"
        fromDateContentTF.stringValue = format.string(from: date)
        fromDateContentTF.font = NSFont.systemFont(ofSize: 15)
        fromDateContentTF.isEditable = false
        fromDateContentTF.isBordered = false
        fromDateContentTF.textColor = NSColor(cgColor: ColorBoard.textColor1)
        self.addSubview(fromDateContentTF)
    }
    private func layoutFromDateTextField() {
        fromDateTextField.sizeToFit()
        fromDateTextField.frame.leftTopCorner = dueDateTextField.frame.origin.verticalShift(-10)
        
        fromDateContentTF.sizeToFit()
        fromDateContentTF.frame.origin = fromDateTextField.frame.rightBottomCorner.horizantalShift(5)
    }
    private func setUpDiscriptionTextField() {
        discriptionTextField.stringValue = "任务说明："
        discriptionTextField.font = NSFont.systemFont(ofSize: 15)
        discriptionTextField.isEditable = false
        discriptionTextField.isBordered = false
        discriptionTextField.textColor = NSColor(cgColor: ColorBoard.textColor1)
        self.addSubview(discriptionTextField)
        
        discriptionContentTF.stringValue = event.discription
        discriptionContentTF.placeholderString = "暂无"
        discriptionContentTF.maximumNumberOfChar = 140
        discriptionContentTF.font = NSFont.systemFont(ofSize: 15)
        discriptionContentTF.maximumNumberOfLines = 999
        discriptionContentTF.isEditable = false
        discriptionContentTF.isBordered = false
        discriptionContentTF.textColor = NSColor(cgColor: ColorBoard.textColor1)
        
        self.addSubview(discriptionContentTF)
    }
    private func layoutDiscriptionTextField() {
        
        discriptionTextField.sizeToFit()
        discriptionTextField.frame.leftTopCorner = fromDateTextField.frame.origin.verticalShift(-10)
        
        discriptionContentTF.frame.size.width = ringSlider.frame.size.width
        discriptionContentTF.frame.size.height = 100
        
        discriptionContentTF.frame.origin = discriptionTextField.frame.origin.verticalShift(-discriptionContentTF.frame.height-10)
    }
    private func setUpCompleteRateTextField() {
        completeRateTextField.stringValue = "\(Int(ringSlider.percentage*100))%"
        completeRateTextField.font = NSFont.systemFont(ofSize: 50)
        completeRateTextField.isEditable = false
        completeRateTextField.isBordered = false
        completeRateTextField.textColor = NSColor(cgColor: ColorBoard.textColor1)
        self.addSubview(completeRateTextField)
    }
    private func layoutCompleteRateTextField() {
        completeRateTextField.sizeToFit()
        completeRateTextField.center = ringSlider.center
    }
}

extension EventEditingView {
    private func enableEditingMode() {
        self.editIconBtn.isTint = true
        dueDateContentTF.removeFromSuperview()
        fromDateContentTF.removeFromSuperview()
        ringSlider.enableEidit = true
        discriptionContentTF.isEditable = true
        discriptionContentTF.isBordered = true
        nameTextField.isEditable = true
        self.setUpDueDatePicker()
        self.setUpfromDatePicker()
    }
    private func disableEditingMode() {
        self.editIconBtn.isTint = false
        ringSlider.enableEidit = false
        
        event.dueDate = dueDatePicker.dateValue.timeIntervalSince1970
        event.fromDate = fromDatePicker.dateValue.timeIntervalSince1970
        event.discription = discriptionContentTF.stringValue
        event.name = nameTextField.stringValue
        event.compeletingRate = Double(ringSlider.percentage)
        
        dueDatePicker.removeFromSuperview()
        fromDatePicker.removeFromSuperview()
        dueDateTextField.removeFromSuperview()
        fromDateTextField.removeFromSuperview()
        discriptionContentTF.removeFromSuperview()
        discriptionTextField.removeFromSuperview()
        nameTextField.removeFromSuperview()
        discriptionContentTF = LimitedLengthTF()
        nameTextField = LimitedLengthTF()
        
        setUpDueDateTextField()
        setUpFromDateTextField()
        setUpDiscriptionTextField()
        setUpNameTextField()
        layoutDueDateTextField()
        layoutFromDateTextField()
        layoutDiscriptionTextField()
        layoutNameTextField()
        
    }
    private func setUpDueDatePicker() {
        dueDatePicker.datePickerElements = .yearMonthDayDatePickerElementFlag
        dueDatePicker.dateValue = Date.init(timeIntervalSince1970: event.dueDate)
        self.addSubview(dueDatePicker)
    }
    private func layoutDueDatePicker() {
        dueDatePicker.frame.size = CGSize.init(width: 100, height: 20)
        dueDatePicker.frame.origin = dueDateTextField.frame.rightBottomCorner
    }
    private func setUpfromDatePicker() {
        fromDatePicker.datePickerElements = .yearMonthDayDatePickerElementFlag
        fromDatePicker.dateValue = Date.init(timeIntervalSince1970: event.fromDate)
        self.addSubview(fromDatePicker)
    }
    private func layoutFromDatePicker() {
        fromDatePicker.frame.size = CGSize.init(width: 100, height: 20)
        fromDatePicker.frame.origin = fromDateTextField.frame.rightBottomCorner
    }
    private func dialogOKCancel(question: String, text: String) -> Bool {
        let myPopup: NSAlert = NSAlert()
        myPopup.messageText = question
        myPopup.informativeText = text
        myPopup.alertStyle = NSAlert.Style.warning
        myPopup.addButton(withTitle: "删除")
        myPopup.addButton(withTitle: "取消")
        return myPopup.runModal() == NSApplication.ModalResponse.alertFirstButtonReturn
    }
    
}











