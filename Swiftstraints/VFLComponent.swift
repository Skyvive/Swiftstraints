//
//  VFLComponent.swift
//  Swiftstraints
//
//  Created by Cat Jia on 1/4/2017.
//  Copyright © 2017 Skyvive. All rights reserved.
//

import UIKit

private func vflKey(_ object: AnyObject) -> String {
    return "A\(UInt(bitPattern: Unmanaged.passUnretained(object).toOpaque().hashValue))B"
}

public struct VFLComponent {
    public var format = ""
    var viewMap = NSMapTable<NSString, UIView>(keyOptions: .copyIn, valueOptions: .weakMemory)
    var metricMap = NSMapTable<NSString, NSNumber>(keyOptions: .copyIn, valueOptions: [.copyIn, .objectPointerPersonality])
}

extension VFLComponent: ExpressibleByArrayLiteral {
    public typealias Element = UIView
    public init(arrayLiteral elements: Element...) {
        guard elements.count == 1 else {
            fatalError("view component can contains only one UIView instance: \(elements)")
        }
        let view = elements[0]
        let key = vflKey(view) as NSString
        viewMap.setObject(view, forKey: key)
        self.format = "[\(key)]"
    }
}

extension VFLComponent: ExpressibleByDictionaryLiteral {
    public typealias Key = UIView
    public typealias Value = VFLComponent
    public init(dictionaryLiteral elements: (Key, Value)...) {
        guard elements.count == 1 else {
            fatalError("view component can contains only one UIView instance: \(elements)")
        }
        let view = elements[0].0
        let numbers = elements[0].1
        let key = vflKey(view) as NSString
        viewMap.setObject(view, forKey: key)
        metricMap = numbers.metricMap
        if numbers.isWrapped {
            self.format = "[\(key)\(numbers.format)]"
        } else {
            self.format = "[\(key)(\(numbers.format))]"
        }
    }
}

extension VFLComponent: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    public typealias FloatLiteralType = Double
    public init(floatLiteral value: FloatLiteralType) {
        let number = value as NSNumber
        let key = vflKey(number)
        metricMap.setObject(number, forKey: key as NSString)
        self.format = key
    }
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: IntegerLiteralType) {
        let number = value as NSNumber
        let key = vflKey(number)
        metricMap.setObject(number, forKey: key as NSString)
        self.format = key
    }
    
}

extension VFLComponent {
    fileprivate var isWrapped: Bool {
        return self.format.hasPrefix("(") && self.format.hasSuffix(")")
    }

    private func vflDictionary<T>(_ table: NSMapTable<NSString, T>) -> [String : AnyObject] {
        var dictionary = [String : AnyObject]()
        for key in table.keyEnumerator().allObjects {
            let key = key as! NSString
            dictionary[key as String] = table.object(forKey: key)
        }
        return dictionary
    }

    /// Returns layout constraints with options.
    public func constraints(axis: UILayoutConstraintAxis, options: NSLayoutFormatOptions) -> [NSLayoutConstraint] {
        /// fail it if views are changed in case of the weak pointers' targets being deallocated
        let keyCount = viewMap.keyEnumerator().allObjects.count
        guard let viewCount = viewMap.objectEnumerator()?.allObjects.count, keyCount == viewCount else { return [] }
        let axisPrefix: String
        switch axis {
        case .horizontal: axisPrefix = "H:"
        case .vertical:   axisPrefix = "V:"
        }
        return NSLayoutConstraint.constraints(withVisualFormat: axisPrefix + format, options: options, metrics: vflDictionary(metricMap), views: vflDictionary(viewMap))
    }
    
}


// MARK: - operators

prefix operator ==
prefix operator >=
prefix operator <=
prefix operator |
prefix operator |-
postfix operator |
postfix operator -|
infix operator .~: MultiplicationPrecedence

/// used for dimensions
public prefix func ==(x: VFLComponent) -> VFLComponent {
    var x = x
    x.format = "(==" + x.format + ")"
    return x
}
public prefix func >=(x: VFLComponent) -> VFLComponent {
    var x = x
    x.format = "(>=" + x.format + ")"
    return x
}
public prefix func <=(x: VFLComponent) -> VFLComponent {
    var x = x
    x.format = "(<=" + x.format + ")"
    return x
}


/// used for superview
public prefix func |(x: VFLComponent) -> VFLComponent {
    var x = x
    x.format = "|" + x.format
    return x
}
public prefix func |-(x: VFLComponent) -> VFLComponent {
    var x = x
    x.format = "|-" + x.format
    return x
}
public postfix func |(x: VFLComponent) -> VFLComponent {
    var x = x
    x.format = x.format + "|"
    return x
}
public postfix func -|(x: VFLComponent) -> VFLComponent {
    var x = x
    x.format = x.format + "-|"
    return x
}

/// used for connections
public func -(lhs: VFLComponent, rhs: VFLComponent) -> VFLComponent {
    var result = lhs
    result.format = lhs.format + "-" + rhs.format
    for key in rhs.viewMap.keyEnumerator().allObjects {
        let key = key as! NSString
        let view = rhs.viewMap.object(forKey: key)
        result.viewMap.setObject(view, forKey: key)
    }
    for key in rhs.metricMap.keyEnumerator().allObjects {
        let key = key as! NSString
        let number = rhs.metricMap.object(forKey: key)
        result.metricMap.setObject(number, forKey: key)
    }
    return result
}

/// used for UILayoutPriority
public func .~(dimension: VFLComponent, priority: LayoutPriority) -> VFLComponent {
    var result = dimension
    if dimension.isWrapped {
        var format = dimension.format
        format.remove(at: format.startIndex)
        format.remove(at: format.index(format.endIndex, offsetBy: -1))
        result.format = "(\(format)@\(String(priority.priority)))"
    } else {
        result.format = dimension.format + "@" + String(priority.priority)
    }
    return result
}


/// usages:
/// let constraints = NSLayoutConstraints(H:|-[view1]-(>=5)-[view2]-3-|)
/// NSLayoutConstraints(H:|-30-[versionLabel:==3.~(.high)]-10-[logoView:>=5]-30-|)
/// NSLayoutConstraints(V:|-30-[versionLabel:20]-10-[logoView]-(30.~(.required - 1))-|)

extension Array where Element: NSLayoutConstraint {
    public init(H: VFLComponent, options: NSLayoutFormatOptions = []) {
        self = H.constraints(axis: .horizontal, options: options) as! [Element]
    }
    public init(V: VFLComponent, options: NSLayoutFormatOptions = []) {
        self = V.constraints(axis: .vertical, options: options) as! [Element]
    }
}
