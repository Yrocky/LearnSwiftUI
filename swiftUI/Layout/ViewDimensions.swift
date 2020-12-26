//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A view's size and its alignment guides in its own coordinate space.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ViewDimensions {

    /// The view's width.
    public var width: CGFloat { get }

    /// The view's height.
    public var height: CGFloat { get }

    /// Gets the value of the given horizontal guide.
    public subscript(guide: HorizontalAlignment) -> CGFloat { get }

    /// Gets the value of the given vertical guide.
    public subscript(guide: VerticalAlignment) -> CGFloat { get }

    /// Gets the explicit value of the given alignment guide in this view, or
    /// `nil` if no such value exists.
    public subscript(explicit guide: HorizontalAlignment) -> CGFloat? { get }

    /// Gets the explicit value of the given alignment guide in this view, or
    /// `nil` if no such value exists.
    public subscript(explicit guide: VerticalAlignment) -> CGFloat? { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension ViewDimensions : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: ViewDimensions, rhs: ViewDimensions) -> Bool
}
