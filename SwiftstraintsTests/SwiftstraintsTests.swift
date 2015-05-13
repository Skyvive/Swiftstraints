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

class SwiftstraintsTests: XCTestCase {
    
    func testExample() {
        let superview = UIView()
        let leftView = UIView()
        let rightView = UIView()
        superview.addSubview(leftView)
        superview.addSubview(rightView)
        let constraint = leftView.width == rightView.width * 2.0 + 12 ^ 800
        let constraints = H|-[leftView[<=rightView]]-<=200^300-[rightView]-|
        superview.addConstraints(leftView.width == rightView.width, V|-[leftView]-|)
    }
    
}
