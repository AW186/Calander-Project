//
//  VerticleTableDataSource.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/23/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

protocol VerticleTableViewDelegate: class {
    func cellHaveBeenClicked(at row: Int)
    func cellWillDeleted(at row: Int)
    func cellDidDeleted(at row: Int)
    func cellWillInsert(at row: Int)
    func cellDidInsert(at row: Int)
}
