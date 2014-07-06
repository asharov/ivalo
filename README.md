# Ivalo

Ivalo is an operator library for expressing layout constraints in
Swift. It is intended as a type-safe and convenient alternative to the
default Auto Layout constraint creation choices. The library is still
evolving, and any kinds of contributions are appreciated.

## Base

At the moment, Ivalo still requires explicit identification of the
view that the constraints are attached to. Later on, it is possible
that this restriction will be lifted, but for now, use of the `<--`
operator is needed to attach the generated constraints to a view:

    self.view <-- Edge.Left +-+ view +-+ Edge.Right

The `<--` operator returns the view where the constraints were bound
to, to support chaining of several constraints.

## Snuggle Operators

The snuggle operators, that make views "snuggle" against each other,
are `+-+`, `++`, and the `Edge` enumeration. The `++` operator
attaches a view right at the edge of the previous view, while `+-+`
leaves a small amount of space between them. The values in the `Edge`
enumeration are used to attach views to their superview's edges.

    self.view <-- Edge.Left +-+ blueView ++ 50 ++ redView ++ Edge.Right

This sets `blueView` 20 points from its superview's left edge, leaves
50 points of horizontal space between `blueView` and `redView`, and
attaches `redView` to its superview's right edge.

## Equality Operators

Ivalo supports asserting the equality of linear functions of view
properties like edge coordinates and dimensions. Also in this case,
the result of an equality assertion needs to be attached to a view.

    self.view <-- |blueView| ~=~ 2 * |redView| + 50

This sets the width of `blueView` to be equal to the width of
`redView` multiplied by 2 and increased by 50. Linear expressions can
be used on both sides of the equality, and Ivalo will handle the
required algebra to solve the equality for you.

    self.view <-- blueView- ~=~ -redView

This sets the bottom edge of `blueView` equal to the top edge of
`redView`. The choice of `-` as the operator to signify top and bottom
edges is somewhat unfortunate, but as code is one-dimensional, putting
the operator on top of or under the operand was not possible.

## Example

The IvaloExample project demonstrates the use of the different Ivalo
operators in a simple colored-view placement example.

## Licensing

Ivalo is licensed under the MIT License, a copy of which is found in
the LICENSE.md file.
