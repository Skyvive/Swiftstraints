//
//  UIView+Additions.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 10/16/15.
//  Copyright © 2015 Skyvive. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addConstraints(constraints: NSLayoutConstraint...) {
        addConstraints(constraints)
    }
    
    public func addConstraints(visualFormatLanguage: VisualFormatLanguage, options: NSLayoutFormatOptions = []) {
        addConstraints(visualFormatLanguage.constraints(options))
    }
    
}