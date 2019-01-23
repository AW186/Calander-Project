//
//  VerticleTableViewDataSource.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/23/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

protocol VerticleTableViewDataSource: class {
    func numberOfRows() -> Int
    func cellFor(row: Int) -> VerticleTableViewCell
    func heightFor(row: Int) -> CGFloat
    func gapBetweenRows() -> CGFloat
}
