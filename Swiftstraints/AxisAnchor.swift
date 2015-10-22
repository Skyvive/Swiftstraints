//
//  AxisAnchor.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 10/22/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import Foundation

public protocol AxisAnchor {
    var anchor: NSLayoutAnchor { get }
    var constant: CGFloat { get }
}

struct CompoundAxis : AxisAnchor {
    let anchor: NSLayoutAnchor
    let constant: CGFloat
}

extension AxisAnchor {
    
    func add(addend: CGFloat) -> CompoundAxis {
        return CompoundAxis(anchor: anchor, constant: constant + addend)
    }
    
}

extension AxisAnchor where Self : NSLayoutAnchor {
    public var anchor: NSLayoutAnchor { return self }
    public var constant: CGFloat { return 0 }
}

extension NSLayoutXAxisAnchor : AxisAnchor {}
extension NSLayoutYAxisAnchor : AxisAnchor {}

public func <=(lhs: AxisAnchor, rhs: AxisAnchor) -> NSLayoutConstraint {
    return lhs.anchor.constraintLessThanOrEqualToAnchor(rhs.anchor, constant: rhs.constant - lhs.constant)
}

public func ==(lhs: AxisAnchor, rhs: AxisAnchor) -> NSLayoutConstraint {
    return lhs.anchor.constraintEqualToAnchor(rhs.anchor, constant: rhs.constant - lhs.constant)
}

public func >=(lhs: AxisAnchor, rhs: AxisAnchor) -> NSLayoutConstraint {
    return lhs.anchor.constraintGreaterThanOrEqualToAnchor(rhs.anchor, constant: rhs.constant - lhs.constant)
}

public func +(axis: AxisAnchor, addend: CGFloat) -> AxisAnchor {
    return axis.add(addend)
}

public func +(addend: CGFloat, axis: AxisAnchor) -> AxisAnchor {
    return axis.add(addend)
}

public func -(axis: AxisAnchor, subtrahend: CGFloat) -> AxisAnchor {
    return axis.add(-subtrahend)
}
