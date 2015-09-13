//
//  Swiftstraints.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 5/11/15.
//  Copyright (c) 2015 Skyvive. All rights reserved.
//

import Foundation

extension UIView {
    
    public var left: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Left) }
    public var right: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Right) }
    public var top: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Top) }
    public var bottom: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Bottom) }
    public var leading: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Leading) }
    public var trailing: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Trailing) }
    public var width: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Width) }
    public var height: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Height) }
    public var centerX: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.CenterX) }
    public var centerY: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.CenterY) }
    public var baseline: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.Baseline) }
    
    public var firstBaseline: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.FirstBaseline) }
    public var leftMargin: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.LeftMargin) }
    public var rightMargin: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.RightMargin) }
    public var topMargin: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.TopMargin) }
    public var bottomMargin: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.BottomMargin) }
    public var leadingMargin: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.LeadingMargin) }
    public var trailingMargin: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.TrailingMargin) }
    public var centerXWithinMargins: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.CenterXWithinMargins) }
    public var centerYWithinMargins: NSLayoutConstraint { return layoutConstraint(NSLayoutAttribute.CenterYWithinMargins) }
    
    public func addConstraints(constraints: NSLayoutConstraint...) {
        self.addConstraints(constraints)
    }
    
}