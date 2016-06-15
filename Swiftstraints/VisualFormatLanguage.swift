//
//  LayoutConstraints.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/12/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

extension NSObject {
    
    var vflKey: String {
        return "A\(UInt(bitPattern: unsafeAddressOf(self).hashValue))B"
    }
    
}

func + <Key, Value>(lh: [Key : Value], rh: [Key : Value]) -> [Key : Value] {
    var dictionary = lh
    for (key, value) in rh {
        dictionary[key] = value
    }
    return dictionary
}

/// Represents constraints created from a interpolated string in the visual format language.
public struct VisualFormatLanguage : StringInterpolationConvertible {
    
    let format: String
    var metrics = [String : NSNumber]()
    var views = [String : UIView]()
    
    public init(stringInterpolation strings: VisualFormatLanguage...) {
        format = strings.reduce("") { return $0.0 + $0.1.format }
        views = strings.reduce([:]) { return $0.0 + $0.1.views }
    }
    
    public init<T>(stringInterpolationSegment expr: T) {
        if let view = expr as? UIView {
            format = view.vflKey
            views[format] = view
        } else if let number = expr as? NSNumber {
            format = number.vflKey
            metrics[format] = number
        } else {
            format = "\(expr)"
        }
    }
    
    /// Returns layout constraints with options.
    public func constraints(options: NSLayoutFormatOptions) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics, views: views)
    }
    
    /// Returns layout constraints.
    public var constraints: [NSLayoutConstraint] {
        return constraints([])
    }
    
}

public typealias NSLayoutConstraints = [NSLayoutConstraint]

extension Array where Element : NSLayoutConstraint {
    
    /// Create a list of constraints using a string interpolated with nested views and metrics.
    /// You can optionally include NSLayoutFormatOptions as the second parameter.
    public init(_ visualFormatLanguage: VisualFormatLanguage, options: NSLayoutFormatOptions = []) {
        if let constraints = visualFormatLanguage.constraints(options) as? [Element] {
            self = constraints
        } else {
            self = []
        }
    }
    
}
