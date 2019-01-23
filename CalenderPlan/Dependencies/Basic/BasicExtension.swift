//
//  BasicExtension.swift
//  MyDocumentBasedTest
//
//9/18/18.
//
//

import Foundation

infix operator ==
func ==<T> (lhs: Array<T>, rhs: Set<T>) -> Bool {
    guard lhs.count == rhs.count else { return false }
    var result = true
    lhs.forEach { (element) in
        result = rhs.contains(element)
    }
    return result
}

extension Optional {
    func transportData(to dst: inout Wrapped) {
        guard let retval = self else {
            return
        }
        dst = retval
    }
}
