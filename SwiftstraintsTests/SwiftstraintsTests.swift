//
//  SwiftstraintsTests.swift
//  SwiftstraintsTests
//
//  Created by Bradley Hilton on 5/11/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import UIKit
import XCTest
import Swiftstraints

func == (lh: NSLayoutConstraint, rh: NSLayoutConstraint) -> Bool {
    return lh.firstItem === rh.firstItem &&
        lh.firstAttribute == rh.firstAttribute &&
        lh.relation == rh.relation &&
        lh.secondItem === rh.secondItem &&
        lh.secondAttribute == rh.secondAttribute &&
        lh.multiplier == rh.multiplier &&
        lh.constant == rh.constant
}

class SwiftstraintsTests: XCTestCase {
    
    func testExpressions() {
        let view = UIView()
        XCTAssert((view.widthAnchor + 10).constant == 10)
        XCTAssert((view.widthAnchor * 10).multiplier == 10)
        XCTAssert((view.widthAnchor - 10).constant == -10)
        XCTAssert((view.widthAnchor / 10).multiplier == (1/10))
        XCTAssert(((view.widthAnchor - 10)*10).constant == -100)
        XCTAssert(((view.widthAnchor + 10)/10).constant == 1)
    }
    
    func testConstraints() {
        let view = UIView()
        XCTAssert((view.widthAnchor == 10) == view.widthAnchor.constraintEqualToConstant(10))
        XCTAssert((view.widthAnchor == view.heightAnchor) == view.widthAnchor.constraintEqualToAnchor(view.heightAnchor))
        XCTAssert((view.widthAnchor == view.heightAnchor + 10) == view.widthAnchor.constraintEqualToAnchor(view.heightAnchor, constant: 10))
        XCTAssert((view.widthAnchor == view.heightAnchor*10) == view.widthAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 10))
        XCTAssert((view.widthAnchor == view.heightAnchor*10 + 10) == view.widthAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 10, constant: 10))
        XCTAssert((view.widthAnchor*2 == view.heightAnchor*4) == view.widthAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 2))
        XCTAssert((view.widthAnchor*2 == view.heightAnchor*2 + 2) == view.widthAnchor.constraintEqualToAnchor(view.heightAnchor, constant: 1))
        XCTAssert((view.widthAnchor*3 + 1 <= view.heightAnchor*6 + 7) == view.widthAnchor.constraintLessThanOrEqualToAnchor(view.heightAnchor, multiplier: 2, constant: 2))
        XCTAssert((view.widthAnchor*3 + 1 == view.heightAnchor*6 + 7) == view.widthAnchor.constraintEqualToAnchor(view.heightAnchor, multiplier: 2, constant: 2))
        XCTAssert((view.widthAnchor*3 + 1 >= view.heightAnchor*6 + 7) == view.widthAnchor.constraintGreaterThanOrEqualToAnchor(view.heightAnchor, multiplier: 2, constant: 2))
    }
    
    func testVisualFormatLanguage() {
        let superview = UIView()
        let leftView = UIView()
        let rightView = UIView()
        superview.addSubview(leftView)
        superview.addSubview(rightView)
        let shorthandConstraints = NSLayoutConstraints("H:|-8-[\(leftView)(>=80,<=100)]-8-[\(rightView)]-8-|")
        let normalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[leftView(>=80,<=100)]-8-[rightView]-8-|",
            options: [],
            metrics: nil,
            views: ["leftView" : leftView, "rightView" : rightView])
        for (lh, rh) in zip(shorthandConstraints, normalConstraints) {
            XCTAssert(lh == rh)
        }
    }
    
}
