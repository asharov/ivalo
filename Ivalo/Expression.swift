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
operator infix ~=~ { associativity left precedence 130 }

// A marker protocol to use as a type parameter to make nonsensical constraints,
// like equating a left edge with a height, compile-time errors instead of run-time
// assertion failures
protocol ExpressionType {

}

struct HorizontalExpression : ExpressionType {

}

struct VerticalExpression : ExpressionType {

}

struct DimensionExpression : ExpressionType {

}

class ExpressionValue<T: ExpressionType> {
    let expression: Expression<T>
    init (expression: Expression<T>) {
        self.expression = expression
    }
}

enum Expression<T: ExpressionType> {
    case Number(CGFloat)
    case ViewEdge(Edge, UIView)
    case ViewDimension(Dimension, UIView)
    case LinearFunction(CGFloat, ExpressionValue<T>, CGFloat)
}

struct Equality<T: ExpressionType> {
    let expressions: [Expression<T>]
}

func expressionToLayout<T: ExpressionType> (expression: Expression<T>) -> (view: UIView?, attribute: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat) {
    switch (expression) {
    case .Number(let value):
        return (nil, .NotAnAttribute, 0.0, value)
    case .ViewEdge(let edge, let view):
        return (view, attributeForEdge(edge), 1.0, 0.0)
    case .ViewDimension(let dimension, let view):
        return (view, attributeForDimension(dimension), 1.0, 0.0)
    case .LinearFunction(let multiplier, let expression, let constant):
        let (view, attribute, innerMultiplier, innerConstant) = expressionToLayout(expression.expression)
        return (view, attribute, multiplier * innerMultiplier, multiplier * innerConstant + constant)
    }
}

func equalityConstraint<T: ExpressionType> (left: Expression<T>, right: Expression<T>) -> NSLayoutConstraint {
    let leftLayout = expressionToLayout(left)
    let rightLayout = expressionToLayout(right)
    return NSLayoutConstraint(item: leftLayout.view, attribute: leftLayout.attribute, relatedBy: NSLayoutRelation.Equal, toItem: rightLayout.view, attribute: rightLayout.attribute, multiplier: rightLayout.multiplier / leftLayout.multiplier, constant: (rightLayout.constant - leftLayout.constant) / leftLayout.multiplier)
}

@prefix func | (view: UIView) -> Expression<HorizontalExpression> {
    return .ViewEdge(.Left, view)
}

@prefix func | (expression: Expression<HorizontalExpression>) -> Expression<DimensionExpression> {
    switch expression {
    case .ViewEdge(.Right, let view):
        return .ViewDimension(.Width, view)
    default:
        assert(false)
        return .Number(CGFLOAT_MAX)
    }
}

@postfix func | (view: UIView) -> Expression<HorizontalExpression> {
    return .ViewEdge(.Right, view)
}

@prefix func - (view: UIView) -> Expression<VerticalExpression> {
    return .ViewEdge(.Top, view)
}

@prefix func - (expression: Expression<VerticalExpression>) -> Expression<DimensionExpression> {
    switch expression {
    case .ViewEdge(.Bottom, let view):
        return .ViewDimension(.Height, view)
    default:
        assert(false)
        return .Number(CGFLOAT_MAX)
    }
}

@postfix func - (view: UIView) -> Expression<VerticalExpression> {
    return .ViewEdge(.Bottom, view)
}

func *<T: ExpressionType> (scalar: CGFloat, expression: Expression<T>) -> Expression<T> {
    return .LinearFunction(scalar, ExpressionValue(expression: expression), 0.0)
}

func +<T: ExpressionType> (expression: Expression<T>, constant: CGFloat) -> Expression<T> {
    return .LinearFunction(1.0, ExpressionValue(expression: expression), constant)
}

func ~=~<T: ExpressionType> (left: Expression<T>, right: CGFloat) -> Equality<T> {
    return left ~=~ .Number(right)
}

func ~=~<T: ExpressionType> (left: Expression<T>, right: Expression<T>) -> Equality<T> {
    return Equality(expressions: [left, right])
}

func ~=~<T: ExpressionType> (left: Equality<T>, right: CGFloat) -> Equality<T> {
    return left ~=~ .Number(right)
}

func ~=~<T: ExpressionType> (left: Equality<T>, right: Expression<T>) -> Equality<T> {
    return Equality(expressions: left.expressions + [right])
}

func <--<T: ExpressionType> (view: UIView, equality: Equality<T>) -> UIView {
    for i in 1..<equality.expressions.count {
        view <-- equalityConstraint(equality.expressions[i-1], equality.expressions[i])
    }
    return view
}
