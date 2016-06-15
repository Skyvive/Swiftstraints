//
//  NSLayoutConstraint+Extensions.swift
//  Swiftstraints
//
//  Created by Bradley Hilton on 6/15/16.
//  Copyright © 2016 Skyvive. All rights reserved.
//

extension NSLayoutConstraint {
    
    func priority(priority: LayoutPriority) -> Self {
        self.priority = priority.priority
        return self
    }
    
}
