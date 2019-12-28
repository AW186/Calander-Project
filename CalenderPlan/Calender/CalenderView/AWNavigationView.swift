//
//  CalenderView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/25/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWNavigationView: NSView {
    private var headerView: NSView = NSView()
    var numberOfNavs: Int = 0
    private var navigators: [NSView] = []
    var heightOfHeader: CGFloat = 0 {
        didSet {
            guard superview != nil else {
                return
            }
            layoutHeader()
        }
    }
    var edgeGapOfHeader: CGFloat = 0 {
        didSet {
            guard superview != nil else {
                return
            }
            layoutHeader()
        }
    }
    var verticalGapOfHeader: CGFloat = 0 {
        didSet {
            guard superview != nil else {
                return
            }
            layoutHeader()
        }
    }
    var layoutOpt: LayoutOption = .gridLayoutWithColumnAndSize(column: 0, size: CGSize.zero, top: 0, left: 0, bot: 0, right: 0)
    enum LayoutOption {
        case singleColumn(gapLeft: CGFloat, gapRight: CGFloat, height: CGFloat, verticalGap: CGFloat)
        case singleRow(gapLeft: CGFloat, gapRight: CGFloat, height: CGFloat, horizontalGap: CGFloat)
        case autoBySize(size: CGSize, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat, horizantalGap: CGFloat, verticalGap: CGFloat)
        case gridLayoutWithConstantRow(row: Int, horizantalGap: CGFloat, verticalGap: CGFloat, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat)
        case gridLayoutWithConstantColumn(column: Int, horizantalGap: CGFloat, verticalGap: CGFloat, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat)
        case gridLayoutWithColumnAndSize(column: Int, size: CGSize, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat)
        case gridLayoutWithRowAndSize(row: Int, size: CGSize, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat)
        case gridLayoutWithVariableEdgeAndRow(row: Int, size: CGSize, horizantalGap: CGFloat, verticalGap: CGFloat)
        case gridLayoutWithVariableEdgeAndColumn(column: Int, size: CGSize, horizantalGap: CGFloat, verticalGap: CGFloat)
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupHeader()
        setupNavigators()
    }
    
    override func layout() {
        super.layout()
    }
    private func setupHeader() {
        headerView = getHeader()
        self.addSubview(headerView)
    }
    private func setupNavigators() {
        navigators.forEach { (arg) in
            arg.removeFromSuperview()
        }
        navigators.removeAll()
        for index in 0..<numberOfNavs {
            let view = getNavigator(at: index)
            self.addSubview(view)
            navigators.append(view)
        }
    }
    func getHeader() -> NSView {
        return NSView()
    }
    func getNavigator(at index: Int) -> NSView {
        return NSView()
    }
}
//MARK: - Layout methods
extension AWNavigationView {
    private func layoutHeader() {
        
    }
    private func layoutNavigations() {
        switch self.layoutOpt {
        case .singleRow(let gapLeft, let gapRight, let height, let horizontalGap):
            singleRow(gapLeft: gapLeft, gapRight: gapRight, height: height, horizontalGap: horizontalGap)
        case .singleColumn(let gapLeft, let gapRight, let height, let verticalGap):
            singleColumn(gapLeft: gapLeft, gapRight: gapRight, height: height, verticalGap: verticalGap)
        case .autoBySize(let size, let top, let left, let bot, let right, let horizantalGap, let verticalGap):
            autoBySize(size: size, top: top, left: left, bot: bot, right: right, horizantalGap: horizantalGap, verticalGap: verticalGap)
        case .gridLayoutWithConstantRow(let row, let horizantalGap, let verticalGap, let top, let left, let bot, let right):
            gridLayoutWithConstantRow(row: row, horizantalGap: horizantalGap, verticalGap: verticalGap, top: top, left: left, bot: bot, right: right)
        case .gridLayoutWithConstantColumn(let column, let horizantalGap, let verticalGap, let top, let left, let bot, let right):
            gridLayoutWithConstantColumn(column: column, horizantalGap: horizantalGap, verticalGap: verticalGap, top: top, left: left, bot: bot, right: right)
        case .gridLayoutWithRowAndSize(let row, let size, let top, let left, let bot, let right):
            gridLayoutWithRowAndSize(row: row, size: size, top: top, left: left, bot: bot, right: right)
        case .gridLayoutWithColumnAndSize(let column, let size, let top, let left, let bot, let right):
            gridLayoutWithColumnAndSize(column: column, size: size, top: top, left: left, bot: bot, right: right)
        case .gridLayoutWithVariableEdgeAndColumn(let column, let size, let horizantalGap, let verticalGap):
            gridLayoutWithVariableEdgeAndColumn(column: column, size: size, horizantalGap: horizantalGap, verticalGap: verticalGap)
        case .gridLayoutWithVariableEdgeAndRow(let row, let size, let horizantalGap, let verticalGap):
            gridLayoutWithVariableEdgeAndRow(row: row, size: size, horizantalGap: horizantalGap, verticalGap: verticalGap)
        }
    }
    private func singleColumn(gapLeft: CGFloat, gapRight: CGFloat, height: CGFloat, verticalGap: CGFloat) {
        
    }
    private func singleRow(gapLeft: CGFloat, gapRight: CGFloat, height: CGFloat, horizontalGap: CGFloat) {
        
    }
    private func autoBySize(size: CGSize, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat, horizantalGap: CGFloat, verticalGap: CGFloat) {
        
    }
    private func gridLayoutWithConstantRow(row: Int, horizantalGap: CGFloat, verticalGap: CGFloat, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat) {
        
    }
    private func gridLayoutWithConstantColumn(column: Int, horizantalGap: CGFloat, verticalGap: CGFloat, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat) {
        
    }
    private func gridLayoutWithColumnAndSize(column: Int, size: CGSize, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat) {
        
    }
    private func gridLayoutWithRowAndSize(row: Int, size: CGSize, top: CGFloat, left: CGFloat, bot: CGFloat, right: CGFloat) {
        
    }
    private func gridLayoutWithVariableEdgeAndRow(row: Int, size: CGSize, horizantalGap: CGFloat, verticalGap: CGFloat) {
        
    }
    private func gridLayoutWithVariableEdgeAndColumn(column: Int, size: CGSize, horizantalGap: CGFloat, verticalGap: CGFloat) {
        
    }
}
