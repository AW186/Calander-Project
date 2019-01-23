//
//  CGFloat+Angle.swift
//  CalenderPlan
//
//11/16/18.
//
//

import Foundation
import Cocoa

extension CGFloat {
    func toUnitArc() -> CGFloat {
        return self.remainder(dividingBy: 2*CGFloat.pi) < 0 ?
            self.remainder(dividingBy: 2*CGFloat.pi)+2*CGFloat.pi :
            self.remainder(dividingBy: 2*CGFloat.pi)
    }
    func toUnitDegree() -> CGFloat {
        return self.remainder(dividingBy: 360) < 0 ?
            self.remainder(dividingBy: 360)+360 :
            self.remainder(dividingBy: 360)
    }
    func degreeToArc() -> CGFloat {
        return self*CGFloat.pi/180
    }
    func arcToDegree() -> CGFloat {
        return self/CGFloat.pi*180
    }
}
