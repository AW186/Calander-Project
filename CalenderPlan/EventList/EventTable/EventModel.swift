//
//  EventModel.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

class EventList: ExpressibleByArrayLiteral {
    required init(arrayLiteral elements: Event...) {
        data = elements
    }
    
    init(array: [Event]) {
        self.data = array
    }
    
    typealias ArrayLiteralElement = Event
    
    var data: [Event] = []
    
    var count: Int {
        return data.count
    }
    
    subscript(index: Int) -> Event {
        return data[index]
    }
    
    func append(_ element: Event) {
        data.append(element)
    }
    
}
