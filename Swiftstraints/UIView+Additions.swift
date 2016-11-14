//
//  UIView+Additions.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 10/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Extension to allow addition of multiple constraints in a variadic list.
    public func addConstraints(_ constraints: NSLayoutConstraint...) {
        addConstraints(constraints)
    }
    
    /// Extension to allow adding of constraints via the visual format language. May also provide NSLayoutFormatOptions as a second parameter.
    public func addConstraints(_ constraints: VisualFormatLanguage, options: NSLayoutFormatOptions = []) {
        addConstraints(constraints.constraints(options))
    }
    
    /// Extension to allow adding of constraints via the visual format language. May also provide NSLayoutFormatOptions as a second parameter.
    public func addConstraints(_ constraints: VisualFormatLanguage..., options: NSLayoutFormatOptions = []) {
        addConstraints(constraints.reduce([]) { $0 + $1.constraints(options) })
    }
    
}
