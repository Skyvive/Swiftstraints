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

public func <=(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraintLessThanOrEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

public func ==(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraintEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

public func >=(dimension: DimensionAnchor, constant: CGFloat) -> NSLayoutConstraint {
    return dimension.dimension.constraintGreaterThanOrEqualToConstant((constant - dimension.constant)/dimension.multiplier)
}

public func <=(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraintLessThanOrEqualToAnchor(rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier)
}

public func ==(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraintEqualToAnchor(rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier)
}

public func >=(lhs: DimensionAnchor, rhs: DimensionAnchor) -> NSLayoutConstraint {
    return lhs.dimension.constraintGreaterThanOrEqualToAnchor(rhs.dimension, multiplier: rhs.multiplier/lhs.multiplier, constant: (rhs.constant - lhs.constant)/lhs.multiplier)
}

public func +(dimension: DimensionAnchor, addend: CGFloat) -> DimensionAnchor {
    return dimension.add(addend)
}

public func +(addend: CGFloat, dimension: DimensionAnchor) -> DimensionAnchor {
    return dimension.add(addend)
}

public func -(dimension: DimensionAnchor, subtrahend: CGFloat) -> DimensionAnchor {
    return dimension.add(-subtrahend)
}

public func *(dimension: DimensionAnchor, factor: CGFloat) -> DimensionAnchor {
    return dimension.multiply(factor)
}

public func *(factor: CGFloat, dimension: DimensionAnchor) -> DimensionAnchor {
    return dimension.multiply(factor)
}

public func /(dimension: DimensionAnchor, divisor: CGFloat) -> DimensionAnchor {
    return dimension.multiply(1/divisor)
}

