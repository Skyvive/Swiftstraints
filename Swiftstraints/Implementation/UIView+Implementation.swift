//
//  UIView+Implementation.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/12/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

let ZeroView = UIView()

extension UIView {
    
    func layoutConstraint(attribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
            attribute: attribute,
            relatedBy: NSLayoutRelation.Equal,
            toItem: ZeroView,
            attribute: attribute,
            multiplier: 1.0,
            constant: 0)
    }
    
    func addLayoutConstraints(constraints: AnyObject...) {
        for object in constraints {
            if let constraint = object as? NSLayoutConstraint {
                self.addConstraint(constraint)
            } else if let layoutConstraints = object as? NSArray {
                if layoutConstraints.count > 0 {
                    if let array = layoutConstraints[0] as? [NSLayoutConstraint] {
                        self.addConstraints(array)
                    }
                }
            }
        }
    }

}