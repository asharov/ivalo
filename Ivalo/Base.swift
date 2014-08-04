//
//  Base.swift
//  Ivalo
//
//  Created by Jaakko Kangasharju on 04/07/14.
//  Copyright (c) 2014 Jaakko Kangasharju. All rights reserved.
//

import Foundation

infix operator  <-- { associativity left }

public enum Edge {
    case Left
    case Top
    case Right
    case Bottom
}

public enum Dimension {
    case Width
    case Height
}

func attributeForEdge (edge: Edge) -> NSLayoutAttribute {
    switch edge {
    case .Left:
        return NSLayoutAttribute.Left
    case .Top:
        return NSLayoutAttribute.Top
    case .Right:
        return NSLayoutAttribute.Right
    case .Bottom:
        return NSLayoutAttribute.Bottom
    }
}

func opposingEdge (edge: Edge) -> Edge {
    switch edge {
    case .Left:
        return Edge.Right
    case .Top:
        return Edge.Bottom
    case .Right:
        return Edge.Left
    case .Bottom:
        return Edge.Top
    }
}

func attributeForDimension (dimension: Dimension) -> NSLayoutAttribute {
    switch dimension {
    case .Width:
        return NSLayoutAttribute.Width
    case .Height:
        return NSLayoutAttribute.Height
    }
}

func <-- (view: UIView, constraint: NSLayoutConstraint) -> UIView {
    view.addConstraint(constraint)
    return view
}

func <-- (view: UIView, constraints: [NSLayoutConstraint]) -> UIView {
    view.addConstraints(constraints)
    return view
}
