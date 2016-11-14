//
//  LayoutConstraints.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/12/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

private func vflKey(_ object: AnyObject) -> String {
    return "A\(UInt(bitPattern: Unmanaged.passUnretained(object).toOpaque().hashValue))B"
}

/// Represents constraints created from a interpolated string in the visual format language.
public struct VisualFormatLanguage : ExpressibleByStringInterpolation {
    
    let format: String
    var metrics = NSHashTable<NSNumber>(options: NSPointerFunctions.Options.weakMemory)
    var views = NSHashTable<UIView>(options: NSPointerFunctions.Options.weakMemory)
    
    public init(stringInterpolation strings: VisualFormatLanguage...) {
        var format = ""
        for vfl in strings {
            format.append(vfl.format)
            for metric in vfl.metrics.allObjects {
                metrics.add(metric)
            }
            for view in vfl.views.allObjects {
                views.add(view)
            }
        }
        self.format = format
    }
    
    public init<T>(stringInterpolationSegment expr: T) {
        format = String(describing: expr)
    }
    
    public init(stringInterpolationSegment view: UIView) {
        format = vflKey(view)
        views.add(view)
    }
    
    public init(stringInterpolationSegment number: NSNumber) {
        format = vflKey(number)
        metrics.add(number)
    }
    
    func vflDictionary<T>(_ table: NSHashTable<T>) -> [String : AnyObject] {
        var dictionary = [String : AnyObject]()
        for object in table.allObjects {
            dictionary[vflKey(object)] = object
        }
        return dictionary
    }
    
    /// Returns layout constraints with options.
    public func constraints(_ options: NSLayoutFormatOptions) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: vflDictionary(metrics), views: vflDictionary(views))
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
