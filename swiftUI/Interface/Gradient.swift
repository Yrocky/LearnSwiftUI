//
//  Layout.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A color gradient represented as an array of color stops, each having a
/// parametric location value.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Gradient : Equatable {

    /// One color stop in the gradient.
    @frozen public struct Stop : Equatable {

        /// The color for the stop.
        public var color: Color

        /// The parametric location of the stop.
        ///
        /// This value must be in the range `[0, 1]`.
        public var location: CGFloat

        /// Creates a color stop with a color and location.
        public init(color: Color, location: CGFloat)

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Gradient.Stop, b: Gradient.Stop) -> Bool
    }

    /// The array of color stops.
    public var stops: [Gradient.Stop]

    /// Creates a gradient from an array of color stops.
    public init(stops: [Gradient.Stop])

    /// Creates a gradient from an array of colors.
    ///
    /// The gradient synthesizes its location values to evenly space the colors
    /// along the gradient.
    public init(colors: [Color])

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Gradient, b: Gradient) -> Bool
}

/// A linear gradient.
///
/// The gradient applies the color function along an axis, as defined by its
/// start and end points. The gradient maps the unit-space points into the
/// bounding rectangle of each shape filled with the gradient.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct LinearGradient : ShapeStyle, View {

    public init(gradient: Gradient, startPoint: UnitPoint, endPoint: UnitPoint)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body
}

/// A radial gradient.
///
/// The gradient applies the color function as the distance from a center point,
/// scaled to fit within the defined start and end radii. The gradient maps the
/// unit-space center point into the bounding rectangle of each shape filled
/// with the gradient.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct RadialGradient : ShapeStyle, View {

    public init(gradient: Gradient, center: UnitPoint, startRadius: CGFloat, endRadius: CGFloat)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body
}

/// An angular gradient.
///
/// An angular gradient is also known as a "conic" gradient. This gradient
/// applies the color function as the angle changes, relative to a center point
/// and defined start and end angles. If `endAngle - startAngle > 2π`, the
/// gradient only draws the last complete turn. If `endAngle - startAngle < 2π`,
/// the gradient fills the missing area with the colors defined by gradient
/// locations one and zero, transitioning between the two halfway across the
/// missing area. The gradient maps the unit-space center point into the
/// bounding rectangle of each shape filled with the gradient.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct AngularGradient : ShapeStyle, View {

    public init(gradient: Gradient, center: UnitPoint, startAngle: Angle = .zero, endAngle: Angle = .zero)

    public init(gradient: Gradient, center: UnitPoint, angle: Angle = .zero)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body
}
