//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation

/// A type that can serve as the animatable data of an animatable type.
/// 向量运算
/// `VectorArithmetic` extends the `AdditiveArithmetic` protocol with scalar
/// multiplication and a way to query the vector magnitude of the value. Use
/// this type as the `animatableData` associated type of a type that conforms to
/// the ``Animatable`` protocol.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol VectorArithmetic : AdditiveArithmetic {

    /// Multiplies each component of this value by the given value.
    mutating func scale(by rhs: Double)

    /// Returns the dot-product of this vector arithmetic instance with itself.
    var magnitudeSquared: Double { get }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Float : VectorArithmetic {

    /// Multiplies each component of this value by the given value.
    public mutating func scale(by rhs: Double)

    /// Returns the dot-product of this vector arithmetic instance with itself.
    public var magnitudeSquared: Double { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Double : VectorArithmetic {

    /// Multiplies each component of this value by the given value.
    public mutating func scale(by rhs: Double)

    /// Returns the dot-product of this vector arithmetic instance with itself.
    public var magnitudeSquared: Double { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension CGFloat : VectorArithmetic {

    /// Multiplies each component of this value by the given value.
    public mutating func scale(by rhs: Double)

    /// Returns the dot-product of this vector arithmetic instance with itself.
    public var magnitudeSquared: Double { get }
}

/// A type with values that support addition and subtraction.
///
/// The `AdditiveArithmetic` protocol provides a suitable basis for additive
/// arithmetic on scalar values, such as integers and floating-point numbers,
/// or vectors. You can write generic methods that operate on any numeric type
/// in the standard library by using the `AdditiveArithmetic` protocol as a
/// generic constraint.
///
/// The following code declares a method that calculates the total of any
/// sequence with `AdditiveArithmetic` elements.
///
///     extension Sequence where Element: AdditiveArithmetic {
///         func sum() -> Element {
///             return reduce(.zero, +)
///         }
///     }
///
/// The `sum()` method is now available on any sequence with values that
/// conform to `AdditiveArithmetic`, whether it is an array of `Double` or a
/// range of `Int`.
///
///     let arraySum = [1.1, 2.2, 3.3, 4.4, 5.5].sum()
///     // arraySum == 16.5
///
///     let rangeSum = (1..<10).sum()
///     // rangeSum == 45
///
/// Conforming to the AdditiveArithmetic Protocol
/// =============================================
///
/// To add `AdditiveArithmetic` protocol conformance to your own custom type,
/// implement the required operators, and provide a static `zero` property
/// using a type that can represent the magnitude of any value of your custom
/// type.
public protocol AdditiveArithmetic : Equatable {

    /// The zero value.
    ///
    /// Zero is the identity element for addition. For any value,
    /// `x + .zero == x` and `.zero + x == x`.
    static var zero: Self { get }

    /// Adds two values and produces their sum.
    ///
    /// The addition operator (`+`) calculates the sum of its two arguments. For
    /// example:
    ///
    ///     1 + 2                   // 3
    ///     -10 + 15                // 5
    ///     -15 + -5                // -20
    ///     21.5 + 3.25             // 24.75
    ///
    /// You cannot use `+` with arguments of different types. To add values of
    /// different types, convert one of the values to the other value's type.
    ///
    ///     let x: Int8 = 21
    ///     let y: Int = 1000000
    ///     Int(x) + y              // 1000021
    ///
    /// - Parameters:
    ///   - lhs: The first value to add.
    ///   - rhs: The second value to add.
    static func + (lhs: Self, rhs: Self) -> Self

    /// Adds two values and stores the result in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The first value to add.
    ///   - rhs: The second value to add.
    static func += (lhs: inout Self, rhs: Self)

    /// Subtracts one value from another and produces their difference.
    ///
    /// The subtraction operator (`-`) calculates the difference of its two
    /// arguments. For example:
    ///
    ///     8 - 3                   // 5
    ///     -10 - 5                 // -15
    ///     100 - -5                // 105
    ///     10.5 - 100.0            // -89.5
    ///
    /// You cannot use `-` with arguments of different types. To subtract values
    /// of different types, convert one of the values to the other value's type.
    ///
    ///     let x: UInt8 = 21
    ///     let y: UInt = 1000000
    ///     y - UInt(x)             // 999979
    ///
    /// - Parameters:
    ///   - lhs: A numeric value.
    ///   - rhs: The value to subtract from `lhs`.
    static func - (lhs: Self, rhs: Self) -> Self

    /// Subtracts the second value from the first and stores the difference in the
    /// left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: A numeric value.
    ///   - rhs: The value to subtract from `lhs`.
    static func -= (lhs: inout Self, rhs: Self)
}

extension AdditiveArithmetic {

    /// Adds two values and stores the result in the left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: The first value to add.
    ///   - rhs: The second value to add.
    public static func += (lhs: inout Self, rhs: Self)

    /// Subtracts the second value from the first and stores the difference in the
    /// left-hand-side variable.
    ///
    /// - Parameters:
    ///   - lhs: A numeric value.
    ///   - rhs: The value to subtract from `lhs`.
    public static func -= (lhs: inout Self, rhs: Self)

    /// Returns the given number unchanged.
    ///
    /// You can use the unary plus operator (`+`) to provide symmetry in your
    /// code for positive numbers when also using the unary minus operator.
    ///
    ///     let x = -21
    ///     let y = +21
    ///     // x == -21
    ///     // y == 21
    ///
    /// - Returns: The given argument without any changes.
    prefix public static func + (x: Self) -> Self
}

extension AdditiveArithmetic where Self : ExpressibleByIntegerLiteral {

    /// The zero value.
    ///
    /// Zero is the identity element for addition. For any value,
    /// `x + .zero == x` and `.zero + x == x`.
    @inlinable public static var zero: Self { get }
}