//
//  BezierPath.swift
//  Chart
//
//  Created by 王子豪 on 2018/7/10.
//  Copyright © 2018年 王子豪. All rights reserved.
//

import Foundation
import Cocoa

let kControlAfterEnd = false
let kControlBeforeBegin = true
class BezierPath {
    var makeUpPoints: Points = Points()
    var lineWidth: CGFloat = 1
    var allBezeirLines: [(CGFloat) -> CGPoint] = [(CGFloat) -> CGPoint]()
    init(points: Points) {
        makeUpPoints = points
        generateBezeirPath()
    }
    func generateBezeirPath() {
        if makeUpPoints.count <= 1 {
            return
        } else if makeUpPoints.count == 2 {
            return
        } else if makeUpPoints.count == 3 {
            self.allBezeirLines.append(getSecondLevelBezeirPath(points: self.makeUpPoints,
                                                                determinesControl: kControlBeforeBegin))
            self.allBezeirLines.append(getSecondLevelBezeirPath(points: self.makeUpPoints,
                                                                determinesControl: kControlAfterEnd))
        } else {
            self.allBezeirLines.append(getSecondLevelBezeirPath(points: [self.makeUpPoints[0],
                                                                         self.makeUpPoints[1],
                                                                         self.makeUpPoints[2]],
                                                                determinesControl: kControlAfterEnd))
            for index in 1...makeUpPoints.count-3 {
                self.allBezeirLines.append(getThirdLevelBezeirPath(points: [makeUpPoints[index-1],
                                                                            makeUpPoints[index],
                                                                            makeUpPoints[index+1],
                                                                            makeUpPoints[index+2]]))
            }
            self.allBezeirLines.append(getSecondLevelBezeirPath(points: [self.makeUpPoints[self.makeUpPoints.count-3],
                                                                         self.makeUpPoints[self.makeUpPoints.count-2],
                                                                         self.makeUpPoints[self.makeUpPoints.count-1]],
                                                                determinesControl: kControlBeforeBegin))
        }
    }
    func getPointsOnPath(unitDistence: CGFloat) -> Points {
        var pointsOnPath = Points()
        for index in 0...allBezeirLines.count-1 {
            var totalDistence: CGFloat = 0
            while totalDistence < 1 {
                pointsOnPath.append(allBezeirLines[index](totalDistence))
                totalDistence += unitDistence
            }
        }
        return pointsOnPath
    }
    func getSecondLevelBezeirPath(points: Points, determinesControl: Bool)->(CGFloat)->CGPoint {
        if determinesControl == kControlAfterEnd {
            let vector = points[0].minus(point: points[2]).getUnitVectorByX()
            let distence = points[1].minus(point: points[0])
            let control = points[1].plus(point: vector.multipuly(by: -distence.x/2))
            return { (time) in
                var point = CGPoint()
                let point0 = points[0]
                let point1 = control
                let point2 = points[1]
                point = point0.multipuly(by: (1-time)*(1-time))
                point = point.plus(point: point1.multipuly(by: 2*time*(1-time)))
                point = point.plus(point: point2.multipuly(by: time*time))
                return point
            }
        } else {
            let vector = points[2].minus(point: points[0]).getUnitVectorByX()
            let distence = points[2].minus(point: points[1])
            let control = points[1].plus(point: vector.multipuly(by: distence.x/2))
            return { (time) in
                var point = CGPoint()
                let point0 = points[1]
                let point1 = control
                let point2 = points[2]
                point = point0.multipuly(by: (1-time)*(1-time))
                point = point.plus(point: point1.multipuly(by: 2*time*(1-time)))
                point = point.plus(point: point2.multipuly(by: time*time))
                return point
            }
        }
    }
    func getThirdLevelBezeirPath(points: Points) -> (CGFloat) -> CGPoint {
        let vectorOne = points[2].minus(point: points[0]).getUnitVectorByX()
        let vectorTwo = points[1].minus(point: points[3]).getUnitVectorByX()
        let distence = points[2].minus(point: points[1])
        let controlOne = points[1].plus(point: vectorOne.multipuly(by: distence.x/2))
        let controlTwo = points[2].plus(point: vectorTwo.multipuly(by: -distence.x/2))
        return { (time) in
            var point = CGPoint()
            let point0 = points[1]
            let point1 = controlOne
            let point2 = controlTwo
            let point3 = points[2]
            point = point0.multipuly(by: (1-time)*(1-time)*(1-time))
            point = point.plus(point: point1.multipuly(by: 3*time*(time-1)*(time-1)))
            point = point.plus(point: point2.multipuly(by: 3*time*time*(1-time)))
            point = point.plus(point: point3.multipuly(by: time*time*time))
            return point
        }
    }
    func contains(point: CGPoint) -> Bool {
        let pointsOnPath = getPointsOnPath(unitDistence: 0.001)
        for index in 0...pointsOnPath.count-1 {
            if point.minus(point: pointsOnPath[index]).getLength() < lineWidth {
                return true
            }
        }
        return false
    }
}
