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
    private var tableView: VerticleTableView = VerticleTableView()
    private var model: [Event] = []
    var rowDidClickedReactionBlk: (Int) -> () = { _ in }
    init(frame frameRect: NSRect, model: [Event]) {
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.bounds
        self.addSubview(tableView)
    }
    override func layout() {
        super.layout()
        tableView.frame = self.bounds
    }
    func refreshAt(row: Int) {
        tableView.refreshAt(row: row)
    }
}

extension EventTable: VerticleTableViewDataSource {
    func gapBetweenRows() -> CGFloat {
        return 10
    }
    
    func numberOfRows() -> Int {
        return model.count
    }
    
    func cellFor(row: Int) -> VerticleTableViewCell {
        
        return EventCell.init(model: model[row])
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
