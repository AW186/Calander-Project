//
//  VerticleTableView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/23/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class VerticleTableView: ScrollView {
    private let defualtHeight: CGFloat = 50
    private var cells: [VerticleTableViewCell] = []
    private var lastFrameHeight: CGFloat = 0
    override var frame: NSRect {
        set {
            lastFrameHeight = super.frame.height
            super.frame = newValue
        }
        get {
            return super.frame
        }
    }
    weak var dataSource: VerticleTableViewDataSource?
    weak var delegate: VerticleTableViewDelegate?
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUp()
        print(self.bounds.height-self.contentView.frame.height)
        offset.y = -(self.bounds.height-self.contentView.frame.height)
    }
    override func layout() {
        super.layout()
        layoutCells()
        offset.y -= frame.height-lastFrameHeight
    }
    func reload() {
        let record = offset
        setUp()
        offset = record //max and min problem
    }
    func removeCellAt(index: Int) {
        guard index >= 0 && index < cells.count else {
            return
        }
    }
    func appendCell(_ cell: VerticleTableViewCell) {
        self.cells.append(cell)
        self.addSubview(cell)
        layoutCells(from: cells.count-1, to: cells.count-1)
    }
    func insertCellAt(index: Int, cell: VerticleTableViewCell) {
        guard index >= 0 else {
            return
        }
        guard index < cells.count else {
            appendCell(cell)
            return
        }
        self.cells.insert(cell, at: index)
        self.addSubview(cell)
        layoutCells(from: index, to: cells.count-1)
    }
}

extension VerticleTableView {
    private func setUp() {
        setUpCells()
        self.contentView.wantsLayer = true
        self.contentView.layer?.masksToBounds = false
    }
    private func setUpCells() {
        guard let dataSource = self.dataSource else {
            return
        }
        cells.forEach { (cell) in
            cell.removeFromSuperview()
        }
        cells.removeAll()
        self.contentView.removeFromSuperview()
        self.contentView = NSView.init()
        dataSource.numberOfRows().forTerms { (index) in
            cells.append(generateCellFor(row: index)!)
        }
        layoutCells()
        cells.forEach { (cell) in
            self.contentView.addSubview(cell)
        }
        self.addSubview(contentView)
    }
    private func generateCellFor(row: Int) -> VerticleTableViewCell? {
        guard let dataSource = self.dataSource else {
            return nil
        }
        let cell = dataSource.cellFor(row: row)
        cell.addReaction {
            self.delegate?.cellHaveBeenClicked(at: row)
        }
        return cell
    }
    private func layoutCells() {
        guard cells.count > 0 else {
            return
        }
        layoutCells(from: 0, to: cells.count-1)
    }
    private func layoutCells(from: Int, to: Int) {
        guard to >= from else {
            return
        }
        guard let dataSource = self.dataSource else {
            var currentHieght: CGFloat = CGFloat(cells.count)*(defualtHeight)
            contentView.frame.size.width = self.bounds.width
            contentView.frame.size.height = currentHieght
            for index in from...to {
                currentHieght -= defualtHeight
                cells[index].frame.origin = CGPoint(x: 0, y: currentHieght)
                cells[index].frame.size.width = self.bounds.width
                cells[index].frame.size.height = defualtHeight
            }
            return
        }
        var currentHieght: CGFloat = {
            var retval: CGFloat = 0
            for index in 0..<cells.count {
                retval += dataSource.heightFor(row: index)+dataSource.gapBetweenRows()
            }
            return retval
        }()
        contentView.frame.size.width = self.bounds.width
        contentView.frame.size.height = currentHieght
        if from != 0 {
            for index in 0..<from {
                currentHieght -= dataSource.heightFor(row: index)
                currentHieght -= dataSource.gapBetweenRows()
            }
        }
        for index in from...to {
            currentHieght -= dataSource.heightFor(row: index)
            currentHieght -= dataSource.gapBetweenRows()
            cells[index].frame.origin = CGPoint(x: 0, y: currentHieght)
            cells[index].frame.size.width = self.bounds.width
            cells[index].frame.size.height = dataSource.heightFor(row: index)
        }
    }
    private func getTotalHeightOfRows() -> CGFloat {
        return cells.reduce(0, { (retal, cell) -> CGFloat in
            return retal + cell.frame.height
        })
    }
}

extension VerticleTableView {
    func refreshAt(row: Int) -> Bool {
        guard row >= 0 && row < cells.count else {
            return false
        }
        cells[row].refreshData()
        return true
    }
}












