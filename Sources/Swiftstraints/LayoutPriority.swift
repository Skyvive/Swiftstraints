//
//  LayoutPriority.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 6/15/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

import UIKit

public enum LayoutPriority {
    
    case required
    case high
    case low
    case fittingSizeLevel
    case other(UILayoutPriority)
    
    var priority: UILayoutPriority {
        switch self {
        case .required: return UILayoutPriority.required
        case .high: return UILayoutPriority.defaultHigh
        case .low: return UILayoutPriority.defaultLow
        case .fittingSizeLevel: return UILayoutPriority.fittingSizeLevel
        case .other(let priority): return priority
        }
    }
    
}

public func -(lhs: LayoutPriority, rhs: UILayoutPriority) -> LayoutPriority {
    return .other(UILayoutPriority(rawValue: lhs.priority.rawValue - rhs.rawValue))
}

public func +(lhs: LayoutPriority, rhs: UILayoutPriority) -> LayoutPriority {
    return LayoutPriority.other(UILayoutPriority(rawValue: lhs.priority.rawValue + rhs.rawValue))
}

@available(iOS 9.0, *)
public func |<T : AxisAnchor>(lhs: T, rhs: LayoutPriority) -> CompoundAxis<T.AnchorType> {
    return CompoundAxis(anchor: lhs.anchor, constant: lhs.constant, priority: rhs)
}

@available(iOS 9.0, *)
public func |(dimension: DimensionAnchor, priority: LayoutPriority) -> DimensionAnchor {
    return CompoundDimension(dimension: dimension.dimension, multiplier: dimension.multiplier, constant: dimension.constant, priority: priority)
}

public struct PrioritizedConstant {
    let constant: CGFloat
    let priority: LayoutPriority
}

public func |(constant: CGFloat, priority: LayoutPriority) -> PrioritizedConstant {
    return PrioritizedConstant(constant: constant, priority: priority)
}
