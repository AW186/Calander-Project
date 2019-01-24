//
//  LabelButton.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/19/18.
//  Copyright © 2018 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class LabelButton: NSTextField {
    private var reactionBlk: () -> () = {}
    private var clickGesture: NSClickGestureRecognizer = NSClickGestureRecognizer()
    func addReaction(blk: @escaping () -> ()) {
        self.removeGestureRecognizer(clickGesture)
        reactionBlk = {
            blk()
        }
        let gesture = NSClickGestureRecognizer.init(target: self, action: #selector(reaction))
        self.addGestureRecognizer(gesture)
    }
    @objc private func reaction() {
        reactionBlk()
    }
}
