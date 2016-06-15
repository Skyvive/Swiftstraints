//
//  DimensionAnchor.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 10/22/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol DimensionAnchor {
    var dimension: NSLayoutDimension { get }
    var multiplier: CGFloat { get }
    var constant: CGFloat { get }
}

struct CompoundDimension : DimensionAnchor {
    let dimension: NSLayoutDimension
    let multiplier: CGFloat
    let constant: CGFloat
}

extension DimensionAnchor {
    
    func add(addend: CGFloat) -> CompoundDimension {
        return CompoundDimension(dimension: dimension, multiplier: multiplier, constant: constant + addend)
    }
    
    func multiply(factor: CGFloat) -> CompoundDimension {
        return CompoundDimension(dimension: dimension, multiplier: multiplier * factor, constant: constant * factor)
    }
    
}

extension NSLayoutDimension : DimensionAnchor {
    public var dimension: NSLayoutDimension { return self }
    public var multiplier: CGFloat { return 1  }
    public var constant: CGFloat { return 0 }
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
public func <=(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraintLessThanOrEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an equation comparing a dimension anchor and a constant.
public func ==(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraintEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
public func >=(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraintGreaterThanOrEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
public func <=(constant: CGFloat, dimension: DimensionAnchor) -> NSLayoutConstraint {
    return dimension.dimension.constraintLessThanOrEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an equation comparing a dimension anchor and a constant.
public func ==(constant: CGFloat, dimension: DimensionAnchor) -> NSLayoutConstraint {
    return dimension.dimension.constraintEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an inequality comparing a dimension anchor and a constant.
public func >=(constant: CGFloat, dimension: DimensionAnchor) -> NSLayoutConstraint {
    return dimension.dimension.constraintGreaterThanOrEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

/// Create a layout constraint from an inequality comparing two dimension anchors.
public func <=(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraintLessThanOrEqualToAnchor(rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier)
}

/// Create a layout constraint from an equation comparing two dimension anchors.
public func ==(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraintEqualToAnchor(rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier)
}

/// Create a layout constraint from an inequality comparing two dimension anchors.
public func >=(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraintGreaterThanOrEqualToAnchor(rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier)
}

/// Add a constant to a dimension anchor.
public func +(dimension: DimensionAnchor, addend: CGFloat) -> DimensionAnchor {
    return dimension.add(addend)
}

/// Add a constant to a dimension anchor.
public func +(addend: CGFloat, dimension: DimensionAnchor) -> DimensionAnchor {
    return dimension.add(addend)
}

/// Subtract a constant from a dimension anchor.
public func -(dimension: DimensionAnchor, subtrahend: CGFloat) -> DimensionAnchor {
    return dimension.add(-subtrahend)
}

/// Multiply a dimension anchor by a factor.
public func *(dimension: DimensionAnchor, factor: CGFloat) -> DimensionAnchor {
    return dimension.multiply(factor)
}

/// Multiply a dimension anchor by a factor.
public func *(factor: CGFloat, dimension: DimensionAnchor) -> DimensionAnchor {
    return dimension.multiply(factor)
}

/// Divide a dimension anchor by a factor.
public func /(dimension: DimensionAnchor, divisor: CGFloat) -> DimensionAnchor {
    return dimension.multiply(1/divisor)
}

