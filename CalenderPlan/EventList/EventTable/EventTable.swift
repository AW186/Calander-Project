//
//  EventTable.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/22/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class EventTable: NSView {
    var optionalSetupOffset: CGFloat? {
        didSet {
            tableView.optionalSetupOffset = self.optionalSetupOffset
        }
    }
    private var tableView: VerticleTableView = VerticleTableView()
    private var model: EventList = []
    var addNewCellBlk: () -> () = { }
    var scrollBlk: (CGFloat) -> () = { _ in }
    var rowDidClickedReactionBlk: (Int) -> () = { _ in }
    init(frame frameRect: NSRect, model: EventList) {
        self.model = model
        super.init(frame: frameRect)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUp()
    }
    private func setUp() {
        tableView.removeFromSuperview()
        tableView.optionalSetupOffset = optionalSetupOffset
        tableView.dataSource = self
        tableView.delegate = self
        tableView.scrollDelegate = self
        tableView.frame = self.bounds
        self.addSubview(tableView)
    }
    override func layout() {
        super.layout()
        tableView.frame = self.bounds
    }
    func refreshAll() {
        tableView.reload()
    }
    func refreshAt(row: Int) {
        _ = tableView.refreshAt(row: row)
    }
    func insertCellAt(row: Int, cell: Event) {
        tableView.insertCellAt(index: row, cell: EventCell.init(model: cell))
    }
    func getOffset() -> CGFloat {
        return tableView.offset.y
    }
}

extension EventTable: VerticleTableViewDataSource {
    func gapBetweenRows() -> CGFloat {
        return 10
    }
    
    func numberOfRows() -> Int {
        return model.count+1
    }
    
    func cellFor(row: Int) -> VerticleTableViewCell {
        if(row < model.count) {
            return EventCell.init(model: model[row])
        } else {
            let cell = AddCell()
            cell.reactionBlk = { [unowned self] in
                self.addNewCellBlk()
            }
            return cell
        }
    }
    
    func heightFor(row: Int) -> CGFloat {
        return 60
    }
}

extension EventTable: VerticleTableViewDelegate {
    func cellHaveBeenClicked(at row: Int) {
        rowDidClickedReactionBlk(row)
    }
    
    func cellWillDeleted(at row: Int) {
        
    }
    
    func cellDidDeleted(at row: Int) {
        
    }
    
    func cellWillInsert(at row: Int) {
        
    }
    
    func cellDidInsert(at row: Int) {
        
    }
}

extension EventTable: ScrollViewDelegate {
    func scrollViewDidScroll(currentOffsetX: CGFloat, currentOffsetY: CGFloat) {
        scrollBlk(currentOffsetY)
    }
    func setOffset(_ offset: CGFloat) {
        tableView.offset.y = offset
    }
}
