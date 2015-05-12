//
//  LayoutConstraints.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/12/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

let numberLetterMappting = ["0":"A", "1":"B", "2":"C", "3":"D", "4":"E", "5":"F", "6":"G", "7":"H", "8":"I", "9":"J"]

public class LayoutConstraints: NSArray {
    
    var format = ""
    var views = [NSString : UIView]()
    var array: [AnyObject] {
        return NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(0), metrics: nil, views: views)
    }
    
    convenience init(args: Any...) {
        self.init()
        for arg in args {
            appendObject(arg)
        }
    }
    
    public subscript(args: AnyObject...) -> LayoutConstraints {
        appendArray(args)
        return self
    }
    
    func appendArray(array: NSArray) {
        format += "["
        for (index, object) in enumerate(array) {
            format += index == 1 ? "(" : ""
            format += index > 1 ? "," : ""
            appendObject(object)
        }
        format += array.count > 1 ? ")]" : "]"
    }
    
    func appendObject(object: Any) {
        switch object {
        case let string as String: self.format += string
        case let double as Double: self.format += "\(double)"
        case let float as Float: self.format += "\(float)"
        case let int as Int: self.format += "\(int)"
        case let view as UIView: appendView(view)
        case let builder as LayoutConstraints: appendBuilder(builder); break
        case let array as NSArray: appendArray(array)
        default: break
        }
    }
    
    func appendView(view: UIView) {
        let name = nameForView(view)
        format += name as String
        views[name] = view
    }
    
    func nameForView(object: NSObject) -> NSString {
        var name = NSString(format: "%p", object)
        for (number, letter) in numberLetterMappting {
            name = name.stringByReplacingOccurrencesOfString(number, withString: letter)
        }
        return name
    }
    
    func appendBuilder(builder: LayoutConstraints) {
        format += builder.format
        for (name, view) in builder.views {
            views[name] = view
        }
    }
    
    override init() {
        super.init()
    }
    
    override init(objects: UnsafePointer<AnyObject?>, count cnt: Int) {
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init()
    }
    
    override public var count: Int { return array.count }
    
    override public func objectAtIndex(index: Int) -> AnyObject {
        assert(index < count, "The index is out of bounds")
        return array[index]
    }
    
}

postfix operator | {}
postfix operator -| {}
infix operator |- {
associativity left
precedence 140
}

infix operator ~ {
associativity left
precedence 140
}

infix operator -== {
associativity left
precedence 140
}

infix operator -<= {
associativity left
precedence 140
}

infix operator ->= {
associativity left
precedence 140
}

prefix operator == {}
prefix operator <= {}
prefix operator >= {}

public let H = LayoutConstraints(args: "H:")
public let V = LayoutConstraints(args: "V:")

public func | (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "|", right)
}

public func |- (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "|-", right)
}

public func - (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "-", right)
}

public func ~ (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "", right)
}

public func -== (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "-==", right)
}

public func -<= (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "-<=", right)
}

public func ->= (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "->=", right)
}

public func ^ (left: LayoutConstraints, right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "@", right)
}

public prefix func == (right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: "==", right)
}

public prefix func <= (right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: "<=", right)
}

public prefix func >= (right: Any) -> LayoutConstraints {
    return LayoutConstraints(args: ">=", right)
}

public postfix func | (left: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "|")
}

public postfix func -| (left: Any) -> LayoutConstraints {
    return LayoutConstraints(args: left, "-|")
}