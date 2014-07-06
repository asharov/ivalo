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

class ExpressionValue {
    let expression: Expression
    init (expression: Expression) {
        self.expression = expression
    }
}

enum Expression {
    case Number(CGFloat)
    case ViewEdge(Edge, UIView)
    case ViewDimension(Dimension, UIView)
    case LinearFunction(CGFloat, ExpressionValue, CGFloat)
}

func expressionToLayout (expression: Expression) -> (view: UIView?, attribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) {
    switch (expression) {
    case .Number(let value):
        return (nil, NSLayoutAttribute.NotAnAttribute, 0.0, value)
    case .ViewEdge(let edge, let view):
        return (view, attributeForEdge(edge), 1.0, 0.0)
    case .ViewDimension(let dimension, let view):
        return (view, attributeForDimension(dimension), 1.0, 0.0)
    case .LinearFunction(let multiplier, let expression, let constant):
        let (view, attribute, innerMultiplier, innerConstant) = expressionToLayout(expression.expression)
        return (view, attribute, multiplier * innerMultiplier, multiplier * innerConstant + constant)
    }
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

func * (scalar: CGFloat, expression: Expression) -> Expression {
    return Expression.LinearFunction(scalar, ExpressionValue(expression: expression), 0.0)
}

func + (expression: Expression, constant: CGFloat) -> Expression {
    return Expression.LinearFunction(1.0, ExpressionValue(expression: expression), constant)
}

func ~=~ (left: Expression, right: CGFloat) -> NSLayoutConstraint[] {
    return left ~=~ Expression.Number(right)
}

func ~=~ (left: Expression, right: Expression) -> NSLayoutConstraint[] {
    let leftLayout = expressionToLayout(left)
    let rightLayout = expressionToLayout(right)
    return [NSLayoutConstraint(item: leftLayout.view, attribute: leftLayout.attribute, relatedBy: NSLayoutRelation.Equal, toItem: rightLayout.view, attribute: rightLayout.attribute, multiplier: rightLayout.multiplier / leftLayout.multiplier, constant: (rightLayout.constant - leftLayout.constant) / leftLayout.multiplier)]
}
