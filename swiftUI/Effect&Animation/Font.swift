//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// An environment-dependent font.
///
/// The system resolves a font's value at the time it uses the font in a given
/// environment because ``Font`` is a late-binding token.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Font : Hashable {

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

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (lhs: Font, rhs: Font) -> Bool

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font {

    /// A font with the large title text style.
    public static let largeTitle: Font

    /// A font with the title text style.
    public static let title: Font

    /// Create a font for second level hierarchical headings.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static let title2: Font

    /// Create a font for third level hierarchical headings.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static let title3: Font

    /// A font with the headline text style.
    public static let headline: Font

    /// A font with the subheadline text style.
    public static let subheadline: Font

    /// A font with the body text style.
    public static let body: Font

    /// A font with the callout text style.
    public static let callout: Font

    /// A font with the footnote text style.
    public static let footnote: Font

    /// A font with the caption text style.
    public static let caption: Font

    /// Create a font with the alternate caption text style.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static let caption2: Font

    /// Gets a system font with the given style and design.
    public static func system(_ style: Font.TextStyle, design: Font.Design = .default) -> Font

    /// A dynamic text style to use for fonts.
    public enum TextStyle : CaseIterable {

        /// The font style for large titles.
        case largeTitle

        /// The font used for first level hierarchical headings.
        case title

        /// The font used for second level hierarchical headings.
        @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
        case title2

        /// The font used for third level hierarchical headings.
        @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
        case title3

        /// The font used for headings.
        case headline

        /// The font used for subheadings.
        case subheadline

        /// The font used for body text.
        case body

        /// The font used for callouts.
        case callout

        /// The font used in footnotes.
        case footnote

        /// The font used for standard captions.
        case caption

        /// The font used for alternate captions.
        @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
        case caption2

        /// A collection of all values of this type.
        public static var allCases: [Font.TextStyle]

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Font.TextStyle, b: Font.TextStyle) -> Bool

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

        /// A type that can represent a collection of all values of this type.
        public typealias AllCases = [Font.TextStyle]
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font {

    /// Adds italics to the font.
    public func italic() -> Font

    /// Adjusts the font to enable all small capitals.
    ///
    /// See ``Font/lowercaseSmallCaps()`` and ``Font/uppercaseSmallCaps()`` for
    /// more details.
    public func smallCaps() -> Font

    /// Adjusts the font to enable lowercase small capitals.
    ///
    /// This function turns lowercase characters into small capitals for the
    /// font. It is generally used for display lines set in large and small
    /// caps, such as titles. It may include forms related to small capitals,
    /// such as old-style figures.
    public func lowercaseSmallCaps() -> Font

    /// Adjusts the font to enable uppercase small capitals.
    ///
    /// This feature turns capital characters into small capitals. It is
    /// generally used for words which would otherwise be set in all caps, such
    /// as acronyms, but which are desired in small-cap form to avoid disrupting
    /// the flow of text.
    public func uppercaseSmallCaps() -> Font

    /// Adjusts the font to use monospace digits.
    public func monospacedDigit() -> Font

    /// Sets the weight of the font.
    public func weight(_ weight: Font.Weight) -> Font

    /// Adds bold styling to the font.
    public func bold() -> Font

    /// Create a version of `self` that uses leading (line spacing) adjustment.
    ///
    /// The availability of leading adjustments depends on font.
    ///
    /// For example, `Font.body.tightLeading()` will return a `Font` in `body`
    /// text style with tight line spacing. This modifier may return the
    /// original `Font` unchanged for some fonts.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public func leading(_ leading: Font.Leading) -> Font

    /// A weight to use for fonts.
    @frozen public struct Weight : Hashable {

        public static let ultraLight: Font.Weight

        public static let thin: Font.Weight

        public static let light: Font.Weight

        public static let regular: Font.Weight

        public static let medium: Font.Weight

        public static let semibold: Font.Weight

        public static let bold: Font.Weight

        public static let heavy: Font.Weight

        public static let black: Font.Weight

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Font.Weight, b: Font.Weight) -> Bool

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

    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public enum Leading {

        case standard

        case tight

        case loose

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Font.Leading, b: Font.Leading) -> Bool

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
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font {

    /// Specifies a system font to use, along with the style, weight, and any
    /// design parameters you want applied to the text.
    ///
    /// Use this function to create a system font by specifying the size and
    /// weight, and a type design together. The following styles the system font
    /// as 17 point, ``Font/Weight/semibold`` text:
    ///
    ///     Text("Hello").font(.system(size: 17, weight: .semibold))
    ///
    /// While the following styles the text as 17 point ``Font/Weight/bold``,
    /// and applies a `serif` ``Font/Design`` to the system font:
    ///
    ///     Text("Hello").font(.system(size: 17, weight: .bold, design: .serif))
    ///
    /// If you want to use the default ``Font/Weight``
    /// (``Font/Weight/regular``), you don't need to specify the `weight` in the
    /// method. The following example styles the text as 17 point
    /// ``Font/Weight/regular``, and uses a ``Font/Design/rounded`` system font:
    ///
    ///     Text("Hello").font(.system(size: 17, design: .rounded))
    public static func system(size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> Font

    /// A design to use for fonts.
    public enum Design : Hashable {

        case `default`

        @available(watchOS 7.0, *)
        case serif

        case rounded

        @available(watchOS 7.0, *)
        case monospaced

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Font.Design, b: Font.Design) -> Bool

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
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font {

    /// Create a custom font with the given `name` and `size` that scales with
    /// the body text style.
    public static func custom(_ name: String, size: CGFloat) -> Font

    /// Create a custom font with the given `name` and `size` that scales
    /// relative to the given `textStyle`.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static func custom(_ name: String, size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font

    /// Create a custom font with the given `name` and a fixed `size` that does
    /// not scale with Dynamic Type.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public static func custom(_ name: String, fixedSize: CGFloat) -> Font

    /// Creates a custom font from a platform font instance.
    ///
    /// Initializing ``Font`` with platform font instance
    /// (<doc://com.apple.documentation/documentation/CoreText/CTFont-q6r>) can bridge SwiftUI
    /// ``Font`` with <doc://com.apple.documentation/documentation/AppKit/NSFont> or
    /// <doc://com.apple.documentation/documentation/UIKit/UIFont>, both of which are
    /// toll-free bridged to
    /// <doc://com.apple.documentation/documentation/CoreText/CTFont-q6r>. For example:
    ///
    ///     // Use native Core Text API to create desired ctFont.
    ///     let ctFont = CTFontCreateUIFontForLanguage(.system, 12, nil)!
    ///
    ///     // Create SwiftUI Text with the CTFont instance.
    ///     let text = Text("Hello").font(Font(ctFont))
    public init(_ font: CTFont)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font.TextStyle : Equatable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Font.TextStyle : Hashable {
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Font.Leading : Equatable {
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Font.Leading : Hashable {
}
