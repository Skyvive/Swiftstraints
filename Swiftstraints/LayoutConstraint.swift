//
//  NSLayoutConstraint+Swiftstraints.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/12/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol LayoutExpression {
    var layoutDimension: NSLayoutDimension { get }
    var multiplier: CGFloat { get }
    var constant: CGFloat { get }
}

struct CompoundLayoutExpression : LayoutExpression {
    let layoutDimension: NSLayoutDimension
    let multiplier: CGFloat
    let constant: CGFloat
}

extension NSLayoutDimension : LayoutExpression {
    public var layoutDimension: NSLayoutDimension { return self }
    public var multiplier: CGFloat { return 1 }
    public var constant: CGFloat { return 0 }
}

public func + (expression: LayoutExpression, value: CGFloat) -> LayoutExpression {
    return CompoundLayoutExpression(layoutDimension: expression.layoutDimension, multiplier: expression.multiplier, constant: expression.constant + value)
}

public func - (expression: LayoutExpression, value: CGFloat) -> LayoutExpression {
    return expression + (-value)
}

public func * (expression: LayoutExpression, value: CGFloat) -> LayoutExpression {
    return CompoundLayoutExpression(layoutDimension: expression.layoutDimension, multiplier: expression.multiplier * value, constant: expression.constant * value)
}

public func / (expression: LayoutExpression, value: CGFloat) -> LayoutExpression {
    return expression * (1/value)
}

public func + (value: CGFloat, expression: LayoutExpression) -> LayoutExpression {
    return expression + value
}

public func - (value: CGFloat, expression: LayoutExpression) -> LayoutExpression {
    return expression - value
}

public func * (value: CGFloat, expression: LayoutExpression) -> LayoutExpression {
    return expression * value
}

public func / (value: CGFloat, expression: LayoutExpression) -> LayoutExpression {
    return expression / value
}

public func <= (lh: LayoutExpression, rh: LayoutExpression) -> NSLayoutConstraint {
    return lh.layoutDimension.constraintLessThanOrEqualToAnchor(rh.layoutDimension, multiplier: rh.multiplier/lh.multiplier, constant: (rh.constant - lh.constant)/lh.multiplier)
}

public func == (lh: LayoutExpression, rh: LayoutExpression) -> NSLayoutConstraint {
    return lh.layoutDimension.constraintEqualToAnchor(rh.layoutDimension, multiplier: rh.multiplier/lh.multiplier, constant: (rh.constant - lh.constant)/lh.multiplier)
}

public func >= (lh: LayoutExpression, rh: LayoutExpression) -> NSLayoutConstraint {
    return lh.layoutDimension.constraintGreaterThanOrEqualToAnchor(rh.layoutDimension, multiplier: rh.multiplier/lh.multiplier, constant: (rh.constant - lh.constant)/lh.multiplier)
}

public func <= (expression: LayoutExpression, constant: CGFloat) -> NSLayoutConstraint {
    return expression.layoutDimension.constraintLessThanOrEqualToConstant((constant - expression.constant)/expression.multiplier)
}

public func == (expression: LayoutExpression, constant: CGFloat) -> NSLayoutConstraint {
    return expression.layoutDimension.constraintEqualToConstant((constant - expression.constant)/expression.multiplier)
}

public func >= (expression: LayoutExpression, constant: CGFloat) -> NSLayoutConstraint {
    return expression.layoutDimension.constraintGreaterThanOrEqualToConstant((constant - expression.constant)/expression.multiplier)
}

public func <= (constant: CGFloat, expression: LayoutExpression) -> NSLayoutConstraint {
    return expression >= constant
}

public func == (constant: CGFloat, expression: LayoutExpression) -> NSLayoutConstraint {
    return expression == constant
}

public func >= (constant: CGFloat, expression: LayoutExpression) -> NSLayoutConstraint {
    return expression <= constant
}
