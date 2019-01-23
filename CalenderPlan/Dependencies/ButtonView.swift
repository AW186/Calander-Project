//
//  ButtonView.swift
//  CalenderPlan
//
//10/20/18.
//
//

import Foundation
import Cocoa

class ButtonView: NSView {
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
