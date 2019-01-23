//
//  IntExtension.swift
//  CalenderPlan
//
//10/19/18.
//
//

import Foundation

extension Int {
    func forTerms(blk: () -> ()) {
        for _ in 0..<self {
            blk()
        }
    }
    func forTerms(blk: (Int) -> ()) {
        for index in 0..<self {
            blk(index)
        }
    }
}
