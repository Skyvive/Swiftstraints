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
public struct VisualFormatLanguage {
    
    let format: String
    var metrics = NSHashTable<NSNumber>(options: [.copyIn, .objectPointerPersonality])
    var views = NSHashTable<UIView>(options: NSPointerFunctions.Options.weakMemory)
    var viewCount: Int = 0  // used to check if this VFL is still valid; since views won't persist the view pointers, if the view is deallocated, there will be an exception when constraints are created later
    
    public init(stringInterpolation strings: VisualFormatLanguage...) {
        var format = ""
        for vfl in strings {
            format.append(vfl.format)
            for metric in vfl.metrics.allObjects {
                if !metrics.contains(metric) {
                    metrics.add(metric)
                }
            }
            for view in vfl.views.allObjects {
                if !views.contains(view) {
                    views.add(view)
                    viewCount += 1
                }
            }
        }
        self.format = format
    }
    
    public init<T>(stringInterpolationSegment expr: T) {
        if let view = expr as? UIView {
            format = vflKey(view)
            views.add(view)
        } else if let number = expr as? NSNumber {
            format = vflKey(number)
            metrics.add(number)
        } else {
            format = String(describing: expr)
        }
    }
    
    func vflDictionary<T>(_ table: NSHashTable<T>) -> [String : AnyObject] {
        var dictionary = [String : AnyObject]()
        for object in table.allObjects {
            dictionary[vflKey(object)] = object
        }
        return dictionary
    }
    
    /// Returns layout constraints with options.
    public func constraints(_ options: NSLayoutConstraint.FormatOptions) -> [NSLayoutConstraint] {
        /// fail it if views are changed in case of the weak pointers' targets being deallocated
        guard views.count == viewCount else { return [] }
        return NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: vflDictionary(metrics), views: vflDictionary(views))
    }
    
    /// Returns layout constraints.
    public var constraints: [NSLayoutConstraint] {
        return constraints([])
    }
    
}

extension VisualFormatLanguage : ExpressibleByStringInterpolation {
    public typealias StringLiteralType = String
    
    public struct StringInterpolation : StringInterpolationProtocol {
        public typealias StringLiteralType = String
        
        var format: String = ""
        var metrics = NSHashTable<NSNumber>(options: [.copyIn, .objectPointerPersonality])
        var views = NSHashTable<UIView>(options: NSPointerFunctions.Options.weakMemory)
        var viewCount: Int = 0  // used to check if this VFL is still valid; since views won't persist the view pointers, if the view is deallocated, there will be an exception when constraints are created later
        
        public init(literalCapacity: Int, interpolationCount: Int) {
            format.reserveCapacity(literalCapacity)
        }
        
        public mutating func appendLiteral(_ literal: String) {
            format.append(literal)
        }
        
        public mutating func appendInterpolation(_ metric: NSNumber) {
            format.append(vflKey(metric))
            metrics.add(metric)
        }
        
        public mutating func appendInterpolation(_ view: UIView) {
            format.append(vflKey(view))
            views.add(view)
            viewCount += 1
        }
        
    }
    
    public init(stringLiteral value: String) {
        self.format = value
    }
    
    public init(stringInterpolation: StringInterpolation) {
        format = stringInterpolation.format
        metrics = stringInterpolation.metrics
        views = stringInterpolation.views
        viewCount = stringInterpolation.viewCount
    }
    
}

public typealias NSLayoutConstraints = [NSLayoutConstraint]

extension Array where Element : NSLayoutConstraint {
    
    /// Create a list of constraints using a string interpolated with nested views and metrics.
    /// You can optionally include NSLayoutFormatOptions as the second parameter.
    public init(_ visualFormatLanguage: VisualFormatLanguage, options: NSLayoutConstraint.FormatOptions = []) {
        if let constraints = visualFormatLanguage.constraints(options) as? [Element] {
            self = constraints
        } else {
            self = []
        }
    }
    
}
