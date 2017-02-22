//
//  DimensionAnchor.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 10/22/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

@available(iOS 9.0, *)
public protocol DimensionAnchor {
    var dimension: NSLayoutDimension { get }
    var multiplier: CGFloat { get }
    var constant: CGFloat { get }
    var priority: LayoutPriority { get }
}

@available(iOS 9.0, *)
struct CompoundDimension : DimensionAnchor {
    let dimension: NSLayoutDimension
    let multiplier: CGFloat
    let constant: CGFloat
    let priority: LayoutPriority
}

@available(iOS 9.0, *)
extension DimensionAnchor {
    
    func add(_ addend: CGFloat) -> CompoundDimension {
        return CompoundDimension(dimension: dimension, multiplier: multiplier, constant: constant + addend, priority: priority)
    }
    
    func multiply(_ factor: CGFloat) -> CompoundDimension {
        return CompoundDimension(dimension: dimension, multiplier: multiplier * factor, constant: constant * factor, priority: priority)
    }
    
}

@available(iOS 9.0, *)
extension NSLayoutDimension : DimensionAnchor {
    public var dimension: NSLayoutDimension { return self }
    public var multiplier: CGFloat { return 1  }
    public var constant: CGFloat { return 0 }
    public var priority: LayoutPriority { return .required }
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func <=(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraint(lessThanOrEqualToConstant: (constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an equation comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func ==(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraint(equalToConstant: (constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func >=(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraint(greaterThanOrEqualToConstant: (constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func <=(dimension: DimensionAnchor, constant: PrioritizedConstant) -> NSLayoutConstraint {
    return dimension.dimension.constraint(lessThanOrEqualToConstant: (constant.constant - dimension.constant)/dimension.multiplier).priority(constant.priority)
}

/// Create a layout constraint from an equation comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func ==(dimension: DimensionAnchor, constant: PrioritizedConstant) -> NSLayoutConstraint {
    return dimension.dimension.constraint(equalToConstant: (constant.constant - dimension.constant)/dimension.multiplier).priority(constant.priority)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func >=(dimension: DimensionAnchor, constant: PrioritizedConstant) -> NSLayoutConstraint {
    return dimension.dimension.constraint(greaterThanOrEqualToConstant: (constant.constant - dimension.constant)/dimension.multiplier).priority(constant.priority)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func <=(constant: CGFloat, dimension: DimensionAnchor) -> NSLayoutConstraint {
    return dimension.dimension.constraint(lessThanOrEqualToConstant: (constant - dimension.constant)/dimension.multiplier).priority(dimension.priority)
}

/// Create a layout constraint from an equation comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func ==(constant: CGFloat, dimension: DimensionAnchor) -> NSLayoutConstraint {
    return dimension.dimension.constraint(equalToConstant: (constant - dimension.constant)/dimension.multiplier).priority(dimension.priority)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
@available(iOS 9.0, *)
public func >=(constant: CGFloat, dimension: DimensionAnchor) -> NSLayoutConstraint {
    return dimension.dimension.constraint(greaterThanOrEqualToConstant: (constant - dimension.constant)/dimension.multiplier).priority(dimension.priority)
}

/// Create a layout constraint from an inequality comparing two dimension anchors.
@available(iOS 9.0, *)
public func <=(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraint(lessThanOrEqualTo: rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier).priority(rhs.priority)
}

/// Create a layout constraint from an equation comparing two dimension anchors.
@available(iOS 9.0, *)
public func ==(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraint(equalTo: rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier).priority(rhs.priority)
}

/// Create a layout constraint from an inequality comparing two dimension anchors.
@available(iOS 9.0, *)
public func >=(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraint(greaterThanOrEqualTo: rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier).priority(rhs.priority)
}

/// Add a constant to a dimension anchor.
@available(iOS 9.0, *)
public func +(dimension: DimensionAnchor, addend: CGFloat) -> DimensionAnchor {
    return dimension.add(addend)
}

/// Add a constant to a dimension anchor.
@available(iOS 9.0, *)
public func +(addend: CGFloat, dimension: DimensionAnchor) -> DimensionAnchor {
    return dimension.add(addend)
}

/// Subtract a constant from a dimension anchor.
@available(iOS 9.0, *)
public func -(dimension: DimensionAnchor, subtrahend: CGFloat) -> DimensionAnchor {
    return dimension.add(-subtrahend)
}

/// Multiply a dimension anchor by a factor.
@available(iOS 9.0, *)
public func *(dimension: DimensionAnchor, factor: CGFloat) -> DimensionAnchor {
    return dimension.multiply(factor)
}

/// Multiply a dimension anchor by a factor.
@available(iOS 9.0, *)
public func *(factor: CGFloat, dimension: DimensionAnchor) -> DimensionAnchor {
    return dimension.multiply(factor)
}

/// Divide a dimension anchor by a factor.
@available(iOS 9.0, *)
public func /(dimension: DimensionAnchor, divisor: CGFloat) -> DimensionAnchor {
    return dimension.multiply(1/divisor)
}

