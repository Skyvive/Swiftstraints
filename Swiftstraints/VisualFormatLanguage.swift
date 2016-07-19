//
//  LayoutConstraints.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/12/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

private func vflKey(object: AnyObject) -> String {
    return "A\(UInt(bitPattern: unsafeAddressOf(object).hashValue))B"
}

extension NSHashTable {
    
    private func addObjects(objects: [AnyObject]) {
        for object in objects {
            addObject(object)
        }
    }
    
    var vflDictionary: [String : AnyObject] {
        var dictionary = [String : AnyObject]()
        for object in allObjects {
            dictionary[vflKey(object)] = object
        }
        return dictionary
    }
    
}

/// Represents constraints created from a interpolated string in the visual format language.
public struct VisualFormatLanguage : StringInterpolationConvertible {
    
    let format: String
    var metrics = NSHashTable(options: NSPointerFunctionsOptions.WeakMemory)
    var views = NSHashTable(options: NSPointerFunctionsOptions.WeakMemory)
    
    public init(stringInterpolation strings: VisualFormatLanguage...) {
        var format = ""
        for vfl in strings {
            format.appendContentsOf(vfl.format)
            metrics.addObjects(vfl.metrics.allObjects)
            views.addObjects(vfl.views.allObjects)
        }
        self.format = format
    }
    
    public init<T>(stringInterpolationSegment expr: T) {
        format = String(expr)
    }
    
    public init(stringInterpolationSegment view: UIView) {
        format = vflKey(view)
        views.addObject(view)
    }
    
    public init(stringInterpolationSegment number: NSNumber) {
        format = vflKey(number)
        metrics.addObject(number)
    }
    
    /// Returns layout constraints with options.
    public func constraints(options: NSLayoutFormatOptions) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraintsWithVisualFormat(format, options: options, metrics: metrics.vflDictionary, views: views.vflDictionary)
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
