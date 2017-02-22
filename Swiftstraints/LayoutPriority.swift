//
//  LayoutPriority.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 6/15/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

public enum LayoutPriority {
    
    case required
    case high
    case low
    case fittingSizeLevel
    case other(UILayoutPriority)
    
    var priority: UILayoutPriority {
        switch self {
        case .required: return UILayoutPriorityRequired
        case .high: return UILayoutPriorityDefaultHigh
        case .low: return UILayoutPriorityDefaultLow
        case .fittingSizeLevel: return UILayoutPriorityFittingSizeLevel
        case .other(let priority): return priority
        }
    }
    
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
