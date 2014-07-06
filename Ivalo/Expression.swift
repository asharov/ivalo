//
//  Expression.swift
//  Ivalo
//
//  Created by Jaakko Kangasharju on 06/07/14.
//  Copyright (c) 2014 Jaakko Kangasharju. All rights reserved.
//

import Foundation

operator prefix | {}
operator postfix | {}
operator prefix - {}
operator postfix - {}
operator infix ~=~ { precedence 130 }

enum Dimension {
    case Width
    case Height
}

enum Expression {
    case Number(CGFloat)
    case ViewEdge(Edge, UIView)
    case ViewDimension(Dimension, UIView)
}

@prefix func | (expression: Expression) -> Expression {
    switch expression {
    case .ViewEdge(.Right, let view):
        return Expression.ViewDimension(.Width, view)
    default:
        assert(false)
        return Expression.Number(CGFLOAT_MAX)
    }
}

@postfix func | (view: UIView) -> Expression {
    return Expression.ViewEdge(.Right, view)
}

@prefix func - (expression: Expression) -> Expression {
    switch expression {
    case .ViewEdge(.Bottom, let view):
        return Expression.ViewDimension(.Height, view)
    default:
        assert(false)
        return Expression.Number(CGFLOAT_MAX)
    }
}

@postfix func - (view: UIView) -> Expression {
    return Expression.ViewEdge(.Bottom, view)
}

func ~=~ (left: Expression, right: Expression) -> NSLayoutConstraint[] {
    switch (left) {
    case .ViewDimension(.Width, let leftView):
        switch (right) {
        case .ViewDimension(.Width, let rightView):
            return [NSLayoutConstraint(item: leftView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: rightView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)]
        default:
            assert(false)
        }
    case .ViewDimension(.Height, let leftView):
        switch (right) {
        case .ViewDimension(.Height, let rightView):
            return [NSLayoutConstraint(item: leftView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: rightView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)]
        default:
            assert(false)
        }
    default:
        assert(false)
    }
    return []
}
