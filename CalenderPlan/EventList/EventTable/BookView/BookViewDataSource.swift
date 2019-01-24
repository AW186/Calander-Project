//
//  BookViewDataSource.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/18/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

protocol BookViewDataSource: class {
    func numberOfPages() -> Int
    func viewForEachPage(for page: Int) -> EventTable
    func pageContentSyle() -> PageContentStyle
    func pageControlStyle() -> BookView.PageControlStyle
    func pageControlSepratorStyle() -> BookView.PageControlSaperateStyle
    func pageTitle(for page: Int) -> String
}
