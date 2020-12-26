//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// The outline of a 2D shape.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Path : Equatable, LosslessStringConvertible {

    /// Creates an empty path.
    public init()

    /// Creates a path from an immutable shape path.
    public init(_ path: CGPath)

    /// Creates a path from a copy of a mutable shape path.
    public init(_ path: CGMutablePath)

    /// Creates a path as the given rectangle.
    public init(_ rect: CGRect)

    /// Creates a path as the given rounded rectangle.
    public init(roundedRect rect: CGRect, cornerSize: CGSize, style: RoundedCornerStyle = .circular)

    /// Creates a path as the given rounded rectangle.
    public init(roundedRect rect: CGRect, cornerRadius: CGFloat, style: RoundedCornerStyle = .circular)

    /// Creates a path as an ellipse inscribed within the given rectangle.
    public init(ellipseIn rect: CGRect)

    /// Creates an empty path, and then executes the closure to add the initial
    /// elements.
    public init(_ callback: (inout Path) -> ())

    /// Initializes from the result of a previous call to
    /// `Path.stringRepresentation`. Fails if the `string` does not
    /// describe a valid path.
    public init?(_ string: String)

    /// A description of the path that may be used to recreate the path
    /// via `init?(_:)`.
    public var description: String { get }

    /// An immutable path representing the elements in the path.
    public var cgPath: CGPath { get }

    /// A Boolean value indicating whether the path contains zero elements.
    public var isEmpty: Bool { get }

    /// A rectangle containing all path segments.
    public var boundingRect: CGRect { get }

    /// Returns true if the path contains a specified point.
    ///
    /// If `eoFill` is true, this method uses the even-odd rule to define which
    /// points are inside the path. Otherwise, it uses the non-zero rule.
    public func contains(_ p: CGPoint, eoFill: Bool = false) -> Bool

    /// An element of a path.
    @frozen public enum Element : Equatable {

        /// A path element that terminates the current subpath (without closing
        /// it) and defines a new current point.
        case move(to: CGPoint)

        /// A line from the previous current point to the given point, which
        /// becomes the new current point.
        case line(to: CGPoint)

        /// A quadratic Bézier curve from the previous current point to the
        /// given end-point, using the single control point to define the curve.
        ///
        /// The end-point of the curve becomes the new current point.
        case quadCurve(to: CGPoint, control: CGPoint)

        /// A cubic Bézier curve from the previous current point to the given
        /// end-point, using the two control points to define the curve.
        ///
        /// The end-point of the curve becomes the new current point.
        case curve(to: CGPoint, control1: CGPoint, control2: CGPoint)

        /// A line from the start point of the current subpath (if any) to the
        /// current point, which terminates the subpath.
        ///
        /// After closing the subpath, the current point becomes undefined.
        case closeSubpath

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Path.Element, b: Path.Element) -> Bool
    }

    /// Calls `body` with each element in the path.
    public func forEach(_ body: (Path.Element) -> Void)

    /// Returns a stroked copy of the path using `style` to define how the
    /// stroked outline is created.
    public func strokedPath(_ style: StrokeStyle) -> Path

    /// Returns a partial copy of the path.
    ///
    /// The returned path contains the region between `from` and `to`, both of
    /// which must be fractions between zero and one defining points
    /// linearly-interpolated along the path.
    public func trimmedPath(from: CGFloat, to: CGFloat) -> Path

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Path, b: Path) -> Bool
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Path : Shape {

    /// Describes this shape as a path within a rectangular frame of reference.
    ///
    /// - Parameter rect: The frame of reference for describing this shape.
    ///
    /// - Returns: A path that describes this shape.
    public func path(in _: CGRect) -> Path

    /// The type defining the data to animate.
    public typealias AnimatableData = EmptyAnimatableData

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Path {

    /// Begins a new subpath at the specified point.
    public mutating func move(to p: CGPoint)

    /// Appends a straight line segment from the current point to the specified
    /// point.
    public mutating func addLine(to p: CGPoint)

    /// Adds a quadratic Bézier curve to the path, with the specified end point
    /// and control point.
    public mutating func addQuadCurve(to p: CGPoint, control cp: CGPoint)

    /// Adds a cubic Bézier curve to the path, with the specified end point and
    /// control points.
    public mutating func addCurve(to p: CGPoint, control1 cp1: CGPoint, control2 cp2: CGPoint)

    /// Closes and completes the current subpath.
    public mutating func closeSubpath()

    /// Adds a rectangular subpath to the path.
    public mutating func addRect(_ rect: CGRect, transform: CGAffineTransform = .identity)

    /// Adds a rounded rectangle to the path.
    public mutating func addRoundedRect(in rect: CGRect, cornerSize: CGSize, style: RoundedCornerStyle = .circular, transform: CGAffineTransform = .identity)

    /// Adds an ellipse to the path.
    public mutating func addEllipse(in rect: CGRect, transform: CGAffineTransform = .identity)

    /// Adds a sequence of rectangular subpaths to the path.
    public mutating func addRects(_ rects: [CGRect], transform: CGAffineTransform = .identity)

    /// Adds a sequence of connected straight-line segments to the path.
    public mutating func addLines(_ lines: [CGPoint])

    /// Adds an arc of a circle to the path, specified with a radius and a
    /// difference in angle.
    public mutating func addRelativeArc(center: CGPoint, radius: CGFloat, startAngle: Angle, delta: Angle, transform: CGAffineTransform = .identity)

    /// Adds an arc of a circle to the path, specified with a radius and angles.
    public mutating func addArc(center: CGPoint, radius: CGFloat, startAngle: Angle, endAngle: Angle, clockwise: Bool, transform: CGAffineTransform = .identity)

    /// Adds an arc of a circle to the path, specified with a radius and two
    /// tangent lines.
    public mutating func addArc(tangent1End p1: CGPoint, tangent2End p2: CGPoint, radius: CGFloat, transform: CGAffineTransform = .identity)

    /// Appends a copy of the given path to this path.
    public mutating func addPath(_ path: Path, transform: CGAffineTransform = .identity)

    /// Returns the last point in the path, or nil if the path contains
    /// no points.
    public var currentPoint: CGPoint? { get }

    /// Returns a path constructed by applying the transform to all points of
    /// the path.
    public func applying(_ transform: CGAffineTransform) -> Path

    /// Returns a path constructed by translating `self` by `(dx, dy)`.
    public func offsetBy(dx: CGFloat, dy: CGFloat) -> Path
}
