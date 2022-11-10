//
//  SwiftstraintsTests.swift
//  SwiftstraintsTests
//
//  Created by Bradley Hilton on 5/11/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//
#if canImport(UIKit)

import UIKit
import XCTest
@testable import Swiftstraints

func == (lh: NSLayoutConstraint, rh: NSLayoutConstraint) -> Bool {
    return lh.firstItem === rh.firstItem &&
        lh.firstAttribute == rh.firstAttribute &&
        lh.relation == rh.relation &&
        lh.secondItem === rh.secondItem &&
        lh.secondAttribute == rh.secondAttribute &&
        lh.multiplier == rh.multiplier &&
        lh.constant == rh.constant &&
        lh.isActive == rh.isActive
}

class SwiftstraintsTests: XCTestCase {
    
    func testAxisExpressions() {
        let view = UIView()
        XCTAssert((view.topAnchor + 10).constant == 10)
        XCTAssert((10 + view.topAnchor).constant == 10)
        XCTAssert((view.topAnchor - 10).constant == -10)
        XCTAssert(view.topAnchor.constant == 0)
    }
    
    func testAxisConstraints() {
        let view1AndView2Superview = UIView()
        let view1 = UIView()
        let view2 = UIView()
        view1AndView2Superview.addSubview(view1)
        view1AndView2Superview.addSubview(view2)
        XCTAssert((view1.topAnchor == view2.bottomAnchor) == view1.topAnchor.constraint(equalTo: view2.bottomAnchor))
        XCTAssert((view1.topAnchor == view2.bottomAnchor + 10) == view1.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: 10))
        XCTAssert((view1.topAnchor + 10 == view2.bottomAnchor) == view1.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: -10))
        XCTAssert((view1.topAnchor <= view2.bottomAnchor) == view1.topAnchor.constraint(lessThanOrEqualTo: view2.bottomAnchor))
        XCTAssert((view1.topAnchor >= view2.bottomAnchor) == view1.topAnchor.constraint(greaterThanOrEqualTo: view2.bottomAnchor))

        let swiftyConstraint1 = view1.topAnchor ==! view2.bottomAnchor
        XCTAssert(swiftyConstraint1.isActive)
        let constraint1 = view1.topAnchor.constraint(equalTo: view2.bottomAnchor)
        constraint1.isActive = true
        XCTAssert(swiftyConstraint1 == constraint1)
        
        let swiftyConstraint2 = view1.topAnchor ==! (view2.bottomAnchor + 10)
        XCTAssert(swiftyConstraint2.isActive)
        let constraint2 = view1.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: 10)
        constraint2.isActive = true
        XCTAssert(swiftyConstraint2 == constraint2)
        
        let swiftyConstraint3 = (view1.topAnchor + 10) ==! view2.bottomAnchor
        XCTAssert(swiftyConstraint3.isActive)
        let constraint3 = view1.topAnchor.constraint(equalTo: view2.bottomAnchor, constant: -10)
        constraint3.isActive = true
        XCTAssert(swiftyConstraint3 == constraint3)
        
        let swiftyConstraint4 = view1.topAnchor <=! view2.bottomAnchor
        XCTAssert(swiftyConstraint4.isActive)
        let constraint4 = view1.topAnchor.constraint(lessThanOrEqualTo: view2.bottomAnchor)
        constraint4.isActive = true
        XCTAssert(swiftyConstraint4 == constraint4)
        
        let swiftyConstraint5 = view1.topAnchor >=! view2.bottomAnchor
        XCTAssert(swiftyConstraint5.isActive)
        let constraint5 = view1.topAnchor.constraint(greaterThanOrEqualTo: view2.bottomAnchor)
        constraint5.isActive = true
        XCTAssert(swiftyConstraint5 == constraint5)
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
        
        let swiftyConstraint1 = view.widthAnchor ==! 10
        XCTAssert(swiftyConstraint1.isActive)
        let constraint1 = view.widthAnchor.constraint(equalToConstant: 10)
        constraint1.isActive = true
        XCTAssert(swiftyConstraint1 == constraint1)
        
        let swiftyConstraint2 = view.widthAnchor ==! view.heightAnchor
        XCTAssert(swiftyConstraint2.isActive)
        let constraint2 = view.widthAnchor.constraint(equalTo: view.heightAnchor)
        constraint2.isActive = true
        XCTAssert(swiftyConstraint2 == constraint2)
        
        let swiftyConstraint3 = view.widthAnchor ==! (view.heightAnchor + 10)
        XCTAssert(swiftyConstraint3.isActive)
        let constraint3 = view.widthAnchor.constraint(equalTo: view.heightAnchor, constant: 10)
        constraint3.isActive = true
        XCTAssert(swiftyConstraint3 == constraint3)
        
        let swiftyConstraint4 = view.widthAnchor ==! (view.heightAnchor*10)
        XCTAssert(swiftyConstraint4.isActive)
        let constraint4 = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 10)
        constraint4.isActive = true
        XCTAssert(swiftyConstraint4 == constraint4)
        
        let swiftyConstraint5 = view.widthAnchor ==! (view.heightAnchor*10 + 10)
        XCTAssert(swiftyConstraint5.isActive)
        let constraint5 = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 10, constant: 10)
        constraint5.isActive = true
        XCTAssert(swiftyConstraint5 == constraint5)
        
        let swiftyConstraint6 = (view.widthAnchor*2) ==! (view.heightAnchor*4)
        XCTAssert(swiftyConstraint6.isActive)
        let constraint6 = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2)
        constraint6.isActive = true
        XCTAssert(swiftyConstraint6 == constraint6)
        
        let swiftyConstraint7 = (view.widthAnchor*2) ==! (view.heightAnchor*2 + 2)
        XCTAssert(swiftyConstraint7.isActive)
        let constraint7 = view.widthAnchor.constraint(equalTo: view.heightAnchor, constant: 1)
        constraint7.isActive = true
        XCTAssert(swiftyConstraint7 == constraint7)
        
        let swiftyConstraint8 = (view.widthAnchor*3 + 1) <=! (view.heightAnchor*6 + 7)
        XCTAssert(swiftyConstraint8.isActive)
        let constraint8 = view.widthAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 2, constant: 2)
        constraint8.isActive = true
        XCTAssert(swiftyConstraint8 == constraint8)
        
        let swiftyConstraint9 = (view.widthAnchor*3 + 1) ==! (view.heightAnchor*6 + 7)
        XCTAssert(swiftyConstraint9.isActive)
        let constraint9 = view.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2, constant: 2)
        constraint9.isActive = true
        XCTAssert(swiftyConstraint9 == constraint9)
        
        let swiftyConstraint10 = (view.widthAnchor*3 + 1) >=! (view.heightAnchor*6 + 7)
        XCTAssert(swiftyConstraint10.isActive)
        let constraint10 = view.widthAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 2, constant: 2)
        constraint10.isActive = true
        XCTAssert(swiftyConstraint10 == constraint10)
    }
    
    func testPriority() {
        let view = UIView()
        XCTAssert((view.widthAnchor == view.heightAnchor | .required).priority == UILayoutPriority.required)
        XCTAssert((view.widthAnchor == view.heightAnchor | .high).priority == UILayoutPriority.defaultHigh)
        XCTAssert((view.widthAnchor == view.heightAnchor | .low).priority == UILayoutPriority.defaultLow)
        XCTAssert((view.widthAnchor == view.heightAnchor | .other(UILayoutPriority(rawValue: 0.18))).priority.rawValue == 0.18)
        XCTAssert((view.widthAnchor == view.heightAnchor + 10 | .low).priority == UILayoutPriority.defaultLow)
        XCTAssert((view.widthAnchor == 10 | .low).priority == UILayoutPriority.defaultLow)
        XCTAssert((view.topAnchor == view.bottomAnchor | .high).priority == UILayoutPriority.defaultHigh)
        XCTAssert((view.topAnchor == view.bottomAnchor + 10 | .low).priority == UILayoutPriority.defaultLow)
        XCTAssert((view.widthAnchor ==! (view.heightAnchor | .required)).priority == UILayoutPriority.required)
        XCTAssert((view.widthAnchor ==! (view.heightAnchor | .high)).priority == UILayoutPriority.defaultHigh)
        XCTAssert((view.widthAnchor ==! (view.heightAnchor | .low)).priority == UILayoutPriority.defaultLow)
        XCTAssert((view.widthAnchor ==! (view.heightAnchor | .other(UILayoutPriority(rawValue: 0.18)))).priority.rawValue == 0.18)
        XCTAssert((view.widthAnchor ==! (view.heightAnchor + 10 | .low)).priority == UILayoutPriority.defaultLow)
        XCTAssert((view.widthAnchor ==! (10 | .low)).priority == UILayoutPriority.defaultLow)
        XCTAssert((view.topAnchor ==! (view.bottomAnchor | .high)).priority == UILayoutPriority.defaultHigh)
        XCTAssert((view.topAnchor ==! (view.bottomAnchor + 10 | .low)).priority == UILayoutPriority.defaultLow)
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
    
    func testVFLComponent() {
        let superview = UIView()
        let view1 = UIView()
        let view2 = UIView()
        superview.addSubview(view1)
        superview.addSubview(view2)

        _ = {
            let shorthandConstraints = NSLayoutConstraints(H:|-[view1]-(>=5)-[view2]-3-|)
            let normalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view1]-(>=5)-[view2]-3-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["view1" : view1, "view2" : view2])
            for (lh, rh) in zip(shorthandConstraints, normalConstraints) {
                XCTAssert(lh == rh)
            }
        }()
        
        _ = {
            let shorthandConstraints = NSLayoutConstraints(H:|-[view1]-(>=5)-[view2:==view1]-3-|)
            let normalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[view1]-(>=5)-[view2(==view1)]-3-|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: ["view1" : view1, "view2" : view2])
            for (lh, rh) in zip(shorthandConstraints, normalConstraints) {
                XCTAssert(lh == rh)
            }
        }()
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
#endif
