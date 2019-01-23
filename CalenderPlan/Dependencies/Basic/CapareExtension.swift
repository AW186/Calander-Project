//
//  CapareExtension.swift
//  CalenderPlan
//
//11/18/18.
//
//

import Foundation

infix operator >?
infix operator <?
infix operator <=?
infix operator >=?

func >?<T: Comparable>(left: T, right: T) -> T {
    return left > right ? left : right
}
func <?<T: Comparable>(left: T, right: T) -> T {
    return left < right ? left : right
}
func >=?<T: Comparable>(left: T, right: T) -> T {
    return left >= right ? left : right
}
func <=?<T: Comparable>(left: T, right: T) -> T {
    return left <= right ? left : right
}
