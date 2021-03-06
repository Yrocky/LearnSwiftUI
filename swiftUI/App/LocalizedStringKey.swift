//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// The key used to look up a string in a strings file or strings dictionary
/// file.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct LocalizedStringKey : Equatable, ExpressibleByStringInterpolation {

    public init(_ value: String)

    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
    public init(stringLiteral value: String)

    /// Creates an instance from a string interpolation.
    ///
    /// Most `StringInterpolation` types will store information about the
    /// literals and interpolations appended to them in one or more properties.
    /// `init(stringInterpolation:)` should use these properties to initialize
    /// the instance.
    ///
    /// - Parameter stringInterpolation: An instance of `StringInterpolation`
    ///             which has had each segment of the string literal appended
    ///             to it.
    public init(stringInterpolation: LocalizedStringKey.StringInterpolation)

    /// The type each segment of a string literal containing interpolations
    /// should be appended to.
    ///
    /// The `StringLiteralType` of an interpolation type must match the
    /// `StringLiteralType` of the conforming type.
    public struct StringInterpolation : StringInterpolationProtocol {

        /// Creates an empty instance ready to be filled with string literal content.
        ///
        /// Don't call this initializer directly. Instead, initialize a variable or
        /// constant using a string literal with interpolated expressions.
        ///
        /// Swift passes this initializer a pair of arguments specifying the size of
        /// the literal segments and the number of interpolated segments. Use this
        /// information to estimate the amount of storage you will need.
        ///
        /// - Parameter literalCapacity: The approximate size of all literal segments
        ///   combined. This is meant to be passed to `String.reserveCapacity(_:)`;
        ///   it may be slightly larger or smaller than the sum of the counts of each
        ///   literal segment.
        /// - Parameter interpolationCount: The number of interpolations which will be
        ///   appended. Use this value to estimate how much additional capacity will
        ///   be needed for the interpolated segments.
        public init(literalCapacity: Int, interpolationCount: Int)

        /// Appends a literal segment to the interpolation.
        ///
        /// Don't call this method directly. Instead, initialize a variable or
        /// constant using a string literal with interpolated expressions.
        ///
        /// Interpolated expressions don't pass through this method; instead, Swift
        /// selects an overload of `appendInterpolation`. For more information, see
        /// the top-level `StringInterpolationProtocol` documentation.
        ///
        /// - Parameter literal: A string literal containing the characters
        ///   that appear next in the string literal.
        public mutating func appendLiteral(_ literal: String)

        public mutating func appendInterpolation(_ string: String)

        public mutating func appendInterpolation<Subject>(_ subject: Subject, formatter: Formatter? = nil) where Subject : ReferenceConvertible

        public mutating func appendInterpolation<Subject>(_ subject: Subject, formatter: Formatter? = nil) where Subject : NSObject

        public mutating func appendInterpolation<T>(_ value: T) where T : _FormatSpecifiable

        public mutating func appendInterpolation<T>(_ value: T, specifier: String) where T : _FormatSpecifiable

        @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
        public mutating func appendInterpolation(_ text: Text)

        /// The type that should be used for literal segments.
        public typealias StringLiteralType = String
    }

    /// A type that represents a string literal.
    ///
    /// Valid types for `StringLiteralType` are `String` and `StaticString`.
    public typealias StringLiteralType = String

    /// A type that represents an extended grapheme cluster literal.
    ///
    /// Valid types for `ExtendedGraphemeClusterLiteralType` are `Character`,
    /// `String`, and `StaticString`.
    public typealias ExtendedGraphemeClusterLiteralType = String

    /// A type that represents a Unicode scalar literal.
    ///
    /// Valid types for `UnicodeScalarLiteralType` are `Unicode.Scalar`,
    /// `Character`, `String`, and `StaticString`.
    public typealias UnicodeScalarLiteralType = String

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: LocalizedStringKey, b: LocalizedStringKey) -> Bool
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension LocalizedStringKey.StringInterpolation {

    public mutating func appendInterpolation(_ image: Image)
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension LocalizedStringKey.StringInterpolation {

    public mutating func appendInterpolation(_ date: Date, style: Text.DateStyle)

    public mutating func appendInterpolation(_ dates: ClosedRange<Date>)

    public mutating func appendInterpolation(_ interval: DateInterval)
}
