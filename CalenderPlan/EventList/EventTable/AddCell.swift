//
//  AddCell.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/21/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AddCell: VerticleTableViewCell {
    private var plusBtn: PlusSymbolBtn = PlusSymbolBtn()
    var reactionBlk: () -> Void = {}
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setUpPlusBtn()
    }
    override func layout() {
        plusBtn.frame.size = CGSize.init(width: 30, height: 30)
        plusBtn.center = self.boundCenter
        super.layout()
    }
}

extension AddCell {
    private func setUpPlusBtn() {
        plusBtn.reactionBlk = { [unowned self] in
            self.reactionBlk()
        }
        plusBtn.option = .withFrame(NSColor.white, NSColor.init(cgColor: ColorBoard.borderColor1)!)
        self.addSubview(plusBtn)
    }
}
