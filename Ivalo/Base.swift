//
//  Base.swift
//  Ivalo
//
//  Created by Jaakko Kangasharju on 04/07/14.
//  Copyright (c) 2014 Jaakko Kangasharju. All rights reserved.
//

import Foundation

class Barfoo {
    class func foobar () {

    }
}

enum Edge {
    case Left
    case Top
    case Right
    case Bottom
}

struct ProspectiveLayout {
    let leadingEdge: Edge
    let constraints: NSLayoutConstraint[]
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

func <-- (view: UIView, layout: ProspectiveLayout) -> UIView {
    for constraint in layout.constraints {
        view.addConstraint(constraint)
    }
    return view
}
