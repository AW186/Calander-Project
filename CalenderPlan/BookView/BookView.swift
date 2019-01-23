//
//  BookView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/18/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class BookView: NSView {
    private var pageControl: BookPageControl = BookPageControl()
    private var scrollContentView: NSView = NSView()
    private var scrollView: ScrollView = ScrollView()
    private var pages: [EventTable] = []
    var animationDuration: TimeInterval = 0
    var pageStyle: PageContentStyle = PageContentStyle.full
    enum PageControlStyle {
        case leftWithSize(CGSize)
        case rightWithSize(CGSize)
        case leftWithGap(CGFloat)
        case rightWithGap(CGFloat)
        case full
    }
    enum PageControlSaperateStyle {
        struct ShadowInfo {
            var radius: CGFloat = 5
            var alpha: CGFloat = 0.3
            var color: CGColor = NSColor.black.cgColor
        }
        case shadow(ShadowInfo)
        case line
        case none
    }
    weak var dataSource: BookViewDataSource?
    override func layout() {
        super.layout()
        layoutScrollView()
        pagesLayout()
        pageControl.frame = getProperFrameForPageControl()
    }
    private func pagesLayout() {
        guard pages.count > 0 else {
            return
        }
        switch pageStyle {
        case .full:
            pages.count.forTerms { (index) in
                pages[index].frame = self.bounds
                pages[index].frame.size.height -= pageControl.frame.height
                pages[index].frame.origin.x += CGFloat(index)*self.bounds.size.width
            }
        case .mid:
            pages.count.forTerms { (index) in
                pages[index].center = self.bounds.size.getCenter()
                pages[index].frame.size.height -= pageControl.frame.height
                pages[index].frame.origin.x += CGFloat(index)*self.bounds.size.width
            }
        case .defuat:
            pages.count.forTerms { (index) in
                pages[index].frame.size.height -= pageControl.frame.height
                pages[index].frame.origin.x += CGFloat(index)*self.bounds.size.width
            }
        }
    }
}

extension BookView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        refreshData()
    }
    func refreshData() {
        guard dataSource != nil else {
            return
        }
        setUpPages()
        setUpPageControl()
    }
    func refreshAt(page: Int, row: Int) {
        self.pages[page].refreshAt(row: row)
    }
    private func setUpPageControl() {
        pageControl.removeFromSuperview()
        guard let dataSource = self.dataSource else { return }
        let pages: Int = dataSource.numberOfPages()
        var strings: [String] = []
        pages.forTerms { (index) in
            strings.append(dataSource.pageTitle(for: index))
        }
        pageControl = BookPageControl(frame: getProperFrameForPageControl(), totalPage: pages, pageReader: strings)
        pageControl.delegate = self
        pageControl.setSeperator(style: dataSource.pageControlSepratorStyle())
        self.addSubview(pageControl)
    }
    private func getProperFrameForPageControl() -> CGRect {
        guard let dataSource = self.dataSource else { return CGRect.zero }
        let pages: Int = dataSource.numberOfPages()
        var frameRect = self.bounds
        switch dataSource.pageControlStyle() {
        case .leftWithSize(let size):
            frameRect.size = CGSize.init(width: size.width*CGFloat(pages), height: size.height)
            frameRect.origin.y = self.bounds.height-frameRect.height
        case .rightWithSize(let size):
            frameRect.size = CGSize.init(width: size.width*CGFloat(pages), height: size.height)
            frameRect.origin.y = self.bounds.height-frameRect.height
            frameRect.origin.x = self.bounds.width-frameRect.width
        case .leftWithGap(let size):
            frameRect.size.height /= 10
            frameRect.size.width -= size
            frameRect.origin.y = self.bounds.height-frameRect.height
        case .rightWithGap(let size):
            frameRect.size.height /= 10
            frameRect.size.width -= size
            frameRect.origin.y = self.bounds.height-frameRect.height
            frameRect.origin.x = self.bounds.width-frameRect.width
        case .full:
            frameRect.size.height /= 10
            frameRect.origin.y = self.bounds.height-frameRect.height
        }
        return frameRect
    }
    private func setUpPages() {
        scrollContentView.removeFromSuperview()
        scrollView.removeFromSuperview()
        scrollView = ScrollView()
        guard let dataSource = self.dataSource else {
            return
        }
        
        let totalPages = dataSource.numberOfPages()
        scrollContentView = NSView.init(frame: CGRect.zero)
        pages.removeAll()
        totalPages.forTerms { (index) in
            pages.append(getEachPage(index: index, dataSource: dataSource))
            scrollContentView.addSubview(pages[index])
        }
        self.scrollView.contentView = self.scrollContentView
        self.addSubview(scrollView)
    }
    private func layoutScrollView() {
        guard let dataSource = self.dataSource else {
            return
        }
        let gapToTheTop: CGFloat = {
            switch dataSource.pageControlStyle() {
            case .leftWithSize(let size):
                return size.height
            case .rightWithSize(let size):
                return size.height
            case .leftWithGap(_):
                return self.bounds.height/10
            case .rightWithGap(_):
                return self.bounds.height/10
            case .full:
                return self.bounds.height/10
            }
        }()
        let totalPages = dataSource.numberOfPages()
        let rect = CGRect.init(origin: CGPoint.zero,
                               size: CGSize.init(width: self.bounds.width*CGFloat(totalPages),
                                                 height: self.bounds.height-gapToTheTop))
        scrollContentView.frame = rect
        scrollView.frame = self.bounds
        scrollView.frame.size.height -= gapToTheTop
    }
    private func getEachPage(index: Int, dataSource: BookViewDataSource) -> EventTable {
        let view = dataSource.viewForEachPage(for: index)
        switch pageStyle {
        case .full:
            view.frame = self.bounds
            view.frame.size.height -= pageControl.frame.height
            view.frame.origin.x += CGFloat(index)*self.bounds.size.width
        case .mid:
            view.center = self.bounds.size.getCenter()
            view.frame.size.height -= pageControl.frame.height
            view.frame.origin.x += CGFloat(index)*self.bounds.size.width
        case .defuat:
            view.frame.origin.x += CGFloat(index)*self.bounds.size.width
            view.frame.size.height -= pageControl.frame.height
        }
        return view
    }
}

extension BookView: BookPageControlDelegate {
    func setTint(label: NSTextField) {
        label.textColor = NSColor(cgColor: ColorBoard.tintTextColor)
    }
    func setDefuat(label: NSTextField) {
        label.textColor = NSColor.black
    }
    func accessToPage(page: Int) -> Int {
        scrollView.offset.x = CGFloat(page)*self.bounds.width
        return page
    }
}
