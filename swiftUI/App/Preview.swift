//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A specification for the context of a `PreviewContext`
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol PreviewContext {

    /// Returns the context's value of `Key`, or `Key.defaultValue`
    /// if the context does not define a value for the key.
    subscript<Key>(key: Key.Type) -> Key.Value where Key : PreviewContextKey { get }
}

/// The key for a preview context.
///
/// The default value is nil.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol PreviewContextKey {

    /// The type of the value returned by the key.
    associatedtype Value

    /// The default value of the key.
    static var defaultValue: Self.Value { get }
}

/// The simulator device that runs a preview.
///
/// Refer to a preview device by its name as shown Xcode's run destination menu,
/// like "iPhone X", or using a model number, like "iPad8,1".
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PreviewDevice : RawRepresentable, ExpressibleByStringLiteral {

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public let rawValue: String

    /// Creates a new instance with the specified raw value.
    ///
    /// If there is no value of the type that corresponds with the specified raw
    /// value, this initializer returns `nil`. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     print(PaperSize(rawValue: "Legal"))
    ///     // Prints "Optional("PaperSize.Legal")"
    ///
    ///     print(PaperSize(rawValue: "Tabloid"))
    ///     // Prints "nil"
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    public init(rawValue: String)

    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
    public init(stringLiteral: String)

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = String

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
}

/// The size constraint for a preview.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum PreviewLayout {

    /// Center the preview in a container the size of the device on which the
    /// preview is running.
    case device

    /// Fit the container to the size of the preview when offered the size of
    /// the device on which the preview is running.
    case sizeThatFits

    /// Center the preview in a fixed size container.
    case fixed(width: CGFloat, height: CGFloat)
}

/// The operating system on which to run the preview.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum PreviewPlatform {

    case iOS

    case macOS

    case tvOS

    case watchOS

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: PreviewPlatform, b: PreviewPlatform) -> Bool

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension PreviewPlatform : Equatable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension PreviewPlatform : Hashable {
}

/// A type that produces view previews in Xcode.
///
/// Xcode statically discovers types that conform to the ``PreviewProvider``
/// protocol in your app, and generates previews for each provider it discovers.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol PreviewProvider : _PreviewProvider {

    /// The type to preview.
    associatedtype Previews : View

    /// Generates a collection of previews.
    ///
    /// The following code shows how to create a preview provider that previews
    /// a view called `MyView` for iPhone X:
    ///
    ///     struct MyPreviews : PreviewProvider {
    ///         static var previews: some View {
    ///             MyView()
    ///                 .previewDevice("iPhone X")
    ///         }
    ///     }
    @ViewBuilder static var previews: Self.Previews { get }

    /// The platform on which to run the provider.
    ///
    /// If the preview provider returns `nil` for this property, Xcode infers
    /// the platform based on the file in which the ``PreviewProvider`` is
    /// defined. Return `nil` only when the file is in a target that supports
    /// multiple platforms.
    static var platform: PreviewPlatform? { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension PreviewProvider {

    /// The platform on which to run the provider.
    ///
    /// If the preview provider returns `nil` for this property, Xcode infers
    /// the platform based on the file in which the ``PreviewProvider`` is
    /// defined. Return `nil` only when the file is in a target that supports
    /// multiple platforms.
    public static var platform: PreviewPlatform? { get }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Overrides the device for a preview.
    ///
    /// If you set the preview device to `nil`, as it is by default, Xcode
    /// automatically chooses an appropriate device based on your target.
    ///
    /// You can get a list of supported values, like "iPhone 11",
    /// "iPad Pro (11-inch)", and "Apple Watch Series 5 - 44mm" by using the
    /// `xcrun` command in the Terminal app:
    ///
    ///     % xcrun simctl list devicetypes
    ///
    /// Additionally, the following values are supported for macOS platform
    /// development:
    ///  - "Mac"
    ///  - "Mac Catalyst"
    @inlinable public func previewDevice(_ value: PreviewDevice?) -> some View


    /// Overrides the size of the container for the preview.
    ///
    /// The default value is ``PreviewLayout/device``.
    @inlinable public func previewLayout(_ value: PreviewLayout) -> some View


    /// Provides a user visible name shown in the editor.
    ///
    /// The default value is `nil`.
    @inlinable public func previewDisplayName(_ value: String?) -> some View


    /// Declares a context for the preview.
    ///
    /// - Parameter value: The context for the preview; the default is `nil`.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    @inlinable public func previewContext<C>(_ value: C) -> some View where C : PreviewContext

}
