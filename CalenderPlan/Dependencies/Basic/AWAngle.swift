
//
//  AWAngle.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/3/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

struct AWAngle {
    private var angle: CGFloat
    var int: Int {
        return Int(angle)
    }
    var double: Double {
        return Double(angle)
    }
    var float: Float {
        return Float(angle)
    }
    var cgFloat: CGFloat {
        return angle
    }
    init(_ angle: Int) {
        self.angle = CGFloat(angle)
        self.toUnit()
    }
    init(_ angle: Float) {
        self.angle = CGFloat(angle)
        self.toUnit()
    }
    init(_ angle: Double) {
        self.angle = CGFloat(angle)
        self.toUnit()
    }
    init(_ angle: CGFloat) {
        self.angle = angle
        self.toUnit()
    }
}
//MARK: some basic operations
extension AWAngle {
    mutating func toUnit() {
        angle = angle.remainder(dividingBy: 360)
        angle += angle < 0 ? 360 : 0
    }
    func minus(angle: AWAngle, clockwise: Bool) -> AWAngle {
        if clockwise {
            return AWAngle(angle.angle-self.angle)
        } else {
            return AWAngle(self.angle-angle.angle)
        }
    }
    func plus(angle: AWAngle, clockwise: Bool) -> AWAngle {
        if clockwise {
            return AWAngle(angle.angle-self.angle)
        } else {
            return AWAngle(self.angle+angle.angle)
        }
    }
}










