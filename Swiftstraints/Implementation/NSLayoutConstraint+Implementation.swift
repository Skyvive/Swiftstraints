//
//  NSLayoutConstraint+Swiftstraints.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/12/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

public func +(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    return constraint(left, setConstant: left.constant + right)
}

public func +(left: CGFloat, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return constraint(right, setConstant: left + right.constant)
}

public func -(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    return constraint(left, setConstant: left.constant - right)
}

public func -(left: CGFloat, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return constraint(right, setConstant: left - right.constant)
}

public func *(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    return constraint(left, setMultiplier: left.multiplier * right)
}

public func *(left: CGFloat, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return constraint(right, setMultiplier: left * right.multiplier)
}

public func /(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    return constraint(left, setMultiplier: left.multiplier / right)
}

public func /(left: CGFloat, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return constraint(right, setMultiplier: left/right.multiplier)
}

public func ^ (left: NSLayoutConstraint, right: UILayoutPriority) -> NSLayoutConstraint {
    left.priority = right
    return left
}

public func ==(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    return constraint(left, setConstant: right - left.constant).relation(NSLayoutRelation.Equal).nilSecondItem()
}

public func <=(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    return constraint(left, setConstant: right - left.constant).relation(NSLayoutRelation.LessThanOrEqual).nilSecondItem()
}

public func >=(left: NSLayoutConstraint, right: CGFloat) -> NSLayoutConstraint {
    return constraint(left, setConstant: right - left.constant).relation(NSLayoutRelation.GreaterThanOrEqual).nilSecondItem()
}

public func ==(left: CGFloat, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return constraint(right, setConstant: right.constant - left).relation(NSLayoutRelation.Equal).nilSecondItem()
}

public func <=(left: CGFloat, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return constraint(right, setConstant: right.constant - left).relation(NSLayoutRelation.GreaterThanOrEqual).nilSecondItem()
}

public func >=(left: CGFloat, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return constraint(right, setConstant: right.constant - left).relation(NSLayoutRelation.LessThanOrEqual).nilSecondItem()
}

public func ==(left: NSLayoutConstraint, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return mergeConstraints(left, right: right).relation(NSLayoutRelation.Equal)
}

public func <=(left: NSLayoutConstraint, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return mergeConstraints(left, right: right).relation(NSLayoutRelation.LessThanOrEqual)
}

public func >=(left: NSLayoutConstraint, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return mergeConstraints(left, right: right).relation(NSLayoutRelation.GreaterThanOrEqual)
}

func constraint(constraint: NSLayoutConstraint, setConstant constant: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: constraint.firstItem,
        attribute: constraint.firstAttribute,
        relatedBy: constraint.relation,
        toItem: constraint.secondItem,
        attribute: constraint.secondAttribute,
        multiplier: constraint.multiplier,
        constant: constant,
        priority: constraint.priority)
}

func constraint(constraint: NSLayoutConstraint, setMultiplier multiplier: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: constraint.firstItem,
        attribute: constraint.firstAttribute,
        relatedBy: constraint.relation,
        toItem: constraint.secondItem,
        attribute: constraint.secondAttribute,
        multiplier: multiplier,
        constant: constraint.constant,
        priority: constraint.priority)
}

func mergeConstraints(left: NSLayoutConstraint, right: NSLayoutConstraint) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: left.firstItem,
        attribute: left.firstAttribute,
        relatedBy: left.relation,
        toItem: right.firstItem,
        attribute: right.firstAttribute,
        multiplier: right.multiplier / left.multiplier,
        constant: right.constant - left.constant,
        priority: right.priority)
}

extension NSLayoutConstraint {
    
    public convenience init(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier: CGFloat, constant c: CGFloat, priority p: UILayoutPriority) {
        self.init(item: view1,
            attribute: attr1,
            relatedBy: relation,
            toItem: view2,
            attribute: attr2,
            multiplier: multiplier,
            constant: c)
        self.priority = p
    }
    
    func relation(relation: NSLayoutRelation) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem,
            attribute: self.firstAttribute,
            relatedBy: relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: self.multiplier,
            constant: self.constant,
            priority: self.priority)
    }
    
    func nilSecondItem() -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 0,
            constant: self.constant,
            priority: self.priority)
    }
    
}


