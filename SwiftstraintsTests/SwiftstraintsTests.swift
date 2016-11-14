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
    
    func testAxisExpressions() {
        let view = UIView()
        XCTAssert(view.topAnchor.constant == 0)
        XCTAssert((view.topAnchor + 10).constant == 10)
        XCTAssert((10 + view.topAnchor).constant == 10)
        XCTAssert((view.topAnchor - 10).constant == -10)
    }
    
    func testAxisConstraints() {
        let view1 = UIView()
        let view2 = UIView()
        XCTAssert((view1.topAnchor == view2.bottomAnchor) == view1.topAnchor.constraint(equalTo: view2.bottomAnchor))
        XCTAssert((view1.topAnchor == view2.bottomAnchor + 10) == view1.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: 10))
        XCTAssert((view1.topAnchor + 10 == view2.bottomAnchor) == view1.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: -10))
        XCTAssert((view1.topAnchor <= view2.bottomAnchor) == view1.topAnchor.constraint(lessThanOrEqualTo: view2.bottomAnchor))
        XCTAssert((view1.topAnchor >= view2.bottomAnchor) == view1.topAnchor.constraint(greaterThanOrEqualTo: view2.bottomAnchor))
    }
    
    func testDimensionExpressions() {
        let view = UIView()
        XCTAssert((view.widthAnchor + 10).constant == 10)
        XCTAssert((10 + view.widthAnchor).constant == 10)
        XCTAssert((view.widthAnchor * 10).multiplier == 10)
        XCTAssert((10 * view.widthAnchor).multiplier == 10)
        XCTAssert((view.widthAnchor - 10).constant == -10)
        XCTAssert((view.widthAnchor / 10).multiplier == (1/10))
        XCTAssert((view.widthAnchor * 10 + 10).multiplier == 10)
        XCTAssert(((view.widthAnchor - 10)*10).constant == -100)
        XCTAssert(((view.widthAnchor + 10)/10).constant == 1)
    }
    
    func testDimensionConstraints() {
        let view = UIView()
        XCTAssert((view.widthAnchor == 10) == view.widthAnchor.constraint(equalToConstant: 10))
        XCTAssert((view.widthAnchor == view.heightAnchor) == view.widthAnchor.constraint(equalTo: view.heightAnchor))
        XCTAssert((view.widthAnchor == view.heightAnchor + 10) == view.widthAnchor.constraint(equalTo: view.heightAnchor, constant: 10))
        XCTAssert((view.widthAnchor == view.heightAnchor*10) == view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 10))
        XCTAssert((view.widthAnchor == view.heightAnchor*10 + 10) == view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 10, constant: 10))
        XCTAssert((view.widthAnchor*2 == view.heightAnchor*4) == view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2))
        XCTAssert((view.widthAnchor*2 == view.heightAnchor*2 + 2) == view.widthAnchor.constraint(equalTo: view.heightAnchor, constant: 1))
        XCTAssert((view.widthAnchor*3 + 1 <= view.heightAnchor*6 + 7) == view.widthAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 2, constant: 2))
        XCTAssert((view.widthAnchor*3 + 1 == view.heightAnchor*6 + 7) == view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2, constant: 2))
        XCTAssert((view.widthAnchor*3 + 1 >= view.heightAnchor*6 + 7) == view.widthAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 2, constant: 2))
    }
    
    func testPriority() {
        let view = UIView()
        XCTAssert((view.widthAnchor == view.heightAnchor | .required).priority == UILayoutPriorityRequired)
        XCTAssert((view.widthAnchor == view.heightAnchor | .high).priority == UILayoutPriorityDefaultHigh)
        XCTAssert((view.widthAnchor == view.heightAnchor | .low).priority == UILayoutPriorityDefaultLow)
        XCTAssert((view.widthAnchor == view.heightAnchor | .other(0.18)).priority == 0.18)
        XCTAssert((view.widthAnchor == view.heightAnchor + 10 | .low).priority == UILayoutPriorityDefaultLow)
        XCTAssert((view.widthAnchor == 10 | .low).priority == UILayoutPriorityDefaultLow)
        XCTAssert((view.topAnchor == view.bottomAnchor | .high).priority == UILayoutPriorityDefaultHigh)
        XCTAssert((view.topAnchor == view.bottomAnchor + 10 | .low).priority == UILayoutPriorityDefaultLow)
    }
    
    func testVisualFormatLanguage() {
        let superview = UIView()
        let leftView = UIView()
        let rightView = UIView()
        superview.addSubview(leftView)
        superview.addSubview(rightView)
        let shorthandConstraints = NSLayoutConstraints("H:|-8-[\(leftView)(>=80,<=100)]-8-[\(rightView)]-8-|")
        let normalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[leftView(>=80,<=100)]-8-[rightView]-8-|",
            options: [],
            metrics: nil,
            views: ["leftView" : leftView, "rightView" : rightView])
        for (lh, rh) in zip(shorthandConstraints, normalConstraints) {
            XCTAssert(lh == rh)
        }
    }
    
    func testAddConstraints() {
        let superview = UIView()
        let topView = UIView()
        let bottomView = UIView()
        superview.addSubview(topView)
        superview.addSubview(bottomView)
        superview.addConstraints("V:|[\(topView)][\(bottomView)]|")
        superview.addConstraints("H:|[\(topView)]|",
                                 "H:|[\(bottomView)]|")
        superview.addConstraints(topView.heightAnchor == superview.heightAnchor / 2,
                                 bottomView.heightAnchor == topView.heightAnchor)
    }
    
}
