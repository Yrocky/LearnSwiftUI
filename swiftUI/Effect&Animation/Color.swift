//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// An environment-dependent color.
///
/// A `Color` is a late-binding token: SwiftUI only resolves it to a concrete
/// value just before using it in a given environment.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Color : Hashable, CustomStringConvertible {

    /// Returns a `CGColor` that represents this color if one can be constructed
    /// that accurately represents this color.
    @available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
    public var cgColor: CGColor? { get }

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
    public static func == (lhs: Color, rhs: Color) -> Bool

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }

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
extension Color : View {

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Color {

    /// Creates a color from an instance of `CGColor`.
    public init(_ cgColor: CGColor)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {

    public enum RGBColorSpace {

        case sRGB

        case sRGBLinear

        case displayP3

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Color.RGBColorSpace, b: Color.RGBColorSpace) -> Bool

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

    public init(_ colorSpace: Color.RGBColorSpace = .sRGB, red: Double, green: Double, blue: Double, opacity: Double = 1)

    public init(_ colorSpace: Color.RGBColorSpace = .sRGB, white: Double, opacity: Double = 1)

    public init(hue: Double, saturation: Double, brightness: Double, opacity: Double = 1)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {

    /// A color that represents the system or application accent color.
    ///
    /// The accent color reflects the broad theme color that can be applied to
    /// views and controls. If an explicit value hasn't been set, the default
    /// application or system accent color will be used.
    ///
    /// On macOS, customization of the accent color is only used if the
    /// "Multicolor" accent color is selected in System Preferences.
    public static var accentColor: Color { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {

    /// A set of colors that are used by system elements and applications.
    public static let clear: Color

    public static let black: Color

    public static let white: Color

    public static let gray: Color

    public static let red: Color

    public static let green: Color

    public static let blue: Color

    public static let orange: Color

    public static let yellow: Color

    public static let pink: Color

    public static let purple: Color

    public static let primary: Color

    public static let secondary: Color
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color : ShapeStyle {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {

    /// Creates a named color.
    ///
    /// - Parameters:
    ///   - name: the name of the color resource to lookup.
    ///   - bundle: the bundle to search for the color resource in.
    public init(_ name: String, bundle: Bundle? = nil)
}

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(macOS, unavailable)
extension Color {

    /// Creates a color from an instance of `UIColor`.
    public init(_ color: UIColor)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {

    public func opacity(_ opacity: Double) -> Color
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color.RGBColorSpace : Equatable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color.RGBColorSpace : Hashable {
}


/// A control used to select a color from the system color picker UI.
///
/// The color picker provides a color well that shows the currently selected
/// color, and displays the larger system color picker that allows users to
/// select a new color.
///
/// By default color picker supports colors with opacity; to disable opacity
/// support, set the `supportsOpacity` parameter to `false`.
/// In this mode the color picker won't show controls for adjusting the opacity
/// of the selected color, and strips out opacity from any color set
/// programmatically or selected from the user's system favorites.
///
/// You use `ColorPicker` by embedding it inside a view hierarchy and
/// initializing it with a title string and a ``Binding`` to a ``Color``:
///
///     struct FormattingControls: View {
///         @State private var bgColor =
///             Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
///
///         var body: some View {
///             VStack {
///                 ColorPicker("Alignment Guides", selection: $bgColor)
///             }
///         }
///     }
///
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct ColorPicker<Label> : View where Label : View {

    /// Creates an instance that selects a color.
    ///
    /// - Parameters:
    ///     - selection: A ``Binding`` to the variable that displays the
    ///       selected ``Color``.
    ///     - supportsOpacity: A Boolean value that indicates whether the color
    ///       picker allows adjusting the selected color's opacity; the default
    ///       is `true`.
    ///     - label: A view that describes the use of the selected color.
    ///        The system color picker UI sets it's title using the text from
    ///        this view.
    ///
    public init(selection: Binding<Color>, supportsOpacity: Bool = true, @ViewBuilder label: () -> Label)

    /// Creates an instance that selects a color.
    ///
    /// - Parameters:
    ///     - selection: A ``Binding`` to the variable that displays the
    ///       selected ``CGColor``.
    ///     - supportsOpacity: A Boolean value that indicates whether the color
    ///       picker allows adjusting the selected color's opacity; the default
    ///       is `true`.
    ///     - label: A view that describes the use of the selected color.
    ///        The system color picker UI sets it's title using the text from
    ///        this view.
    ///
    public init(selection: Binding<CGColor>, supportsOpacity: Bool = true, @ViewBuilder label: () -> Label)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension ColorPicker where Label == Text {

    /// Creates a color picker with a text label generated from a title string key.
    ///
    /// Use ``ColorPicker`` to create a color well that your app uses to allow
    /// the selection of a ``Color``. The example below creates a color well
    /// using a ``Binding`` to a property stored in a settings object and title
    /// you provide:
    ///
    ///     final class Settings: ObservableObject {
    ///         @Published var alignmentGuideColor =
    ///             Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    ///     }
    ///
    ///     struct FormattingControls: View {
    ///         @State private var settings = Settings()
    ///
    ///         var body: some View {
    ///             VStack {
    ///                 // Other formatting controls.
    ///                 ColorPicker("Alignment Guides",
    ///                     selection: $settings.alignmentGuideColor
    ///                 )
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of the picker.
    ///   - selection: A ``Binding`` to the variable that displays the
    ///     selected ``Color``.
    ///   - supportsOpacity: A Boolean value that indicates whether the color
    ///     picker allows adjustments to the selected color's opacity; the
    ///     default is `true`.
    public init(_ titleKey: LocalizedStringKey, selection: Binding<Color>, supportsOpacity: Bool = true)

    /// Creates a color picker with a text label generated from a title string.
    ///
    /// Use ``ColorPicker`` to create a color well that your app uses to allow
    /// the selection of a ``Color``. The example below creates a color well
    /// using a ``Binding`` and title you provide:
    ///
    ///     func showColorPicker(_ title: String, color: Binding<Color>) {
    ///         ColorPicker(title, selection: color)
    ///     }
    ///
    /// - Parameters:
    ///   - title: The title displayed by the color picker.
    ///   - selection: A ``Binding`` to the variable containing a ``Color``.
    ///   - supportsOpacity: A Boolean value that indicates whether the color
    ///     picker allows adjustments to the selected color's opacity; the
    ///     default is `true`.
    public init<S>(_ title: S, selection: Binding<Color>, supportsOpacity: Bool = true) where S : StringProtocol

    /// Creates a color picker with a text label generated from a title string key.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of the picker.
    ///   - selection: A ``Binding`` to the variable that displays the
    ///     selected ``CGColor``.
    ///   - supportsOpacity: A Boolean value that indicates whether the color
    ///     picker allows adjustments to the selected color's opacity; the
    ///     default is `true`.
    public init(_ titleKey: LocalizedStringKey, selection: Binding<CGColor>, supportsOpacity: Bool = true)

    /// Creates a color picker with a text label generated from a title string.
    ///
    /// - Parameters:
    ///   - title: The title displayed by the color picker.
    ///   - selection: A ``Binding`` to the variable containing a ``CGColor``.
    ///   - supportsOpacity: A Boolean value that indicates whether the color
    ///     picker allows adjustments to the selected color's opacity; the
    ///     default is `true`.
    public init<S>(_ title: S, selection: Binding<CGColor>, supportsOpacity: Bool = true) where S : StringProtocol
}
