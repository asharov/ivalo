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

func sideBySide (edge: Edge, view: UIView, gap: CGFloat) -> ProspectiveLayout {
    let attribute = attributeForEdge(edge)
    let constraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: view.superview, attribute: attribute, multiplier: 1.0, constant: gap)
    return ProspectiveLayout(leadingEdge: edge, constraints: [constraint])
}

func sideBySide (layout: ProspectiveLayout, view: UIView, gap: CGFloat) -> ProspectiveLayout {
    let attribute = attributeForEdge(layout.leadingEdge)
    let previousView = layout.constraints[layout.constraints.endIndex - 1].firstItem as UIView
    let previousAttribute = attributeForEdge(opposingEdge(layout.leadingEdge))
    let constraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: previousView, attribute: previousAttribute, multiplier: 1.0, constant: gap)
    return ProspectiveLayout(leadingEdge: layout.leadingEdge, constraints: layout.constraints + [constraint])
}

func sideBySide (layout: ProspectiveLayout, edge: Edge, gap: CGFloat) -> ProspectiveLayout {
    let attribute = attributeForEdge(edge)
    let view = layout.constraints[layout.constraints.endIndex - 1].firstItem as UIView
    let constraint = NSLayoutConstraint(item: view, attribute: attribute, relatedBy: NSLayoutRelation.Equal, toItem: view.superview, attribute: attribute, multiplier: 1.0, constant: -gap)
    return ProspectiveLayout(leadingEdge: layout.leadingEdge, constraints: layout.constraints + [constraint])
}

func ++ (edge: Edge, view: UIView) -> ProspectiveLayout {
    return sideBySide(edge, view, 0.0);
}

func +-+ (edge: Edge, view: UIView) -> ProspectiveLayout {
    return sideBySide(edge, view, 20.0);
}

func ++ (layout: ProspectiveLayout, view: UIView) -> ProspectiveLayout {
    return sideBySide(layout, view, 0.0)
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
