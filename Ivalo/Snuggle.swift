//
//  Snuggle.swift
//  Ivalo
//
//  Created by Jaakko Kangasharju on 04/07/14.
//  Copyright (c) 2014 Jaakko Kangasharju. All rights reserved.
//

import Foundation

operator infix <-- { associativity none }
operator infix +-+ { associativity left precedence 110 }
operator infix ++ { associativity left precedence 110 }

struct ProspectiveLayout {
    let leadingEdge: Edge
    let constraints: NSLayoutConstraint[]
    let remainingGlue: CGFloat
}

func previousViewInLayout (layout: ProspectiveLayout, view: UIView?) -> UIView? {
    if (layout.constraints.endIndex > 0) {
        return layout.constraints[layout.constraints.endIndex - 1].firstItem as? UIView
    } else {
        return view?.superview
    }
}

func attributeForPreviousViewInLayout (layout: ProspectiveLayout, view: UIView) -> NSLayoutAttribute {
    let previousView = previousViewInLayout(layout, view)
    let edge = previousView == view.superview ? layout.leadingEdge : opposingEdge(layout.leadingEdge)
    return attributeForEdge(edge)
}

func sideBySide (edge: Edge, view: UIView, gap: CGFloat) -> ProspectiveLayout {
    return sideBySide(ProspectiveLayout(leadingEdge: edge, constraints: [], remainingGlue: 0.0), view, gap)
}

func sideBySide (layout: ProspectiveLayout, view: UIView, gap: CGFloat) -> ProspectiveLayout {
    let attribute = attributeForEdge(layout.leadingEdge)
    let previousView = previousViewInLayout(layout, view)
    let previousAttribute = attributeForPreviousViewInLayout(layout, view)
    let constraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: previousView, attribute: previousAttribute, multiplier: 1.0, constant: gap + layout.remainingGlue)
    return ProspectiveLayout(leadingEdge: layout.leadingEdge, constraints: layout.constraints + [constraint], remainingGlue: 0.0)
}

func sideBySide (layout: ProspectiveLayout, edge: Edge, gap: CGFloat) -> ProspectiveLayout {
    let attribute = attributeForEdge(edge)
    let view = previousViewInLayout(layout, nil)
    let constraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: view?.superview, attribute: attribute, multiplier: 1.0, constant: -gap - layout.remainingGlue)
    return ProspectiveLayout(leadingEdge: layout.leadingEdge, constraints: layout.constraints + [constraint], remainingGlue: 0.0)
}

func ++ (edge: Edge, view: UIView) -> ProspectiveLayout {
    return sideBySide(edge, view, 0.0);
}

func ++ (edge: Edge, glue: CGFloat) -> ProspectiveLayout {
    return ProspectiveLayout(leadingEdge: edge, constraints: [], remainingGlue: glue)
}

func +-+ (edge: Edge, view: UIView) -> ProspectiveLayout {
    return sideBySide(edge, view, 20.0);
}

func ++ (layout: ProspectiveLayout, view: UIView) -> ProspectiveLayout {
    return sideBySide(layout, view, 0.0)
}

func ++ (layout: ProspectiveLayout, glue: CGFloat) -> ProspectiveLayout {
    return ProspectiveLayout(leadingEdge: layout.leadingEdge, constraints: layout.constraints, remainingGlue: layout.remainingGlue + glue)
}

func +-+ (layout: ProspectiveLayout, view: UIView) -> ProspectiveLayout {
    return sideBySide(layout, view, 8.0)
}

func ++ (layout: ProspectiveLayout, edge: Edge) -> ProspectiveLayout {
    return sideBySide(layout, edge, 0.0)
}

func +-+ (layout: ProspectiveLayout, edge: Edge) -> ProspectiveLayout {
    return sideBySide(layout, edge, 20.0)
}

func <-- (view: UIView, layout: ProspectiveLayout) -> UIView {
    return view <-- layout.constraints
}
