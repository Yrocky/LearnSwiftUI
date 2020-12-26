//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// The configuration and content of a widget to display on the Home screen or
/// in Notification Center.
///
/// Widgets show glanceable and relevant content from your app right on the iOS
/// Home screen or in Notification Center on macOS. Users can add, configure, and
/// arrange widgets to suit their individual needs. You can provide multiple
/// types of widgets, each presenting a specific kind of information. When
/// users want more information, like to read the full article for a headline
/// or to see the details of a package delivery, the widget lets them get to
/// the information in your app quickly.
///
/// There are three key components to a widget:
///
/// * A configuration that determines whether the widget is configurable,
///   identifies the widget, and defines the SwiftUI views that show the
///   widget's content.
/// * A timeline provider that drives the process of updating the widget's view
///   over time.
/// * SwiftUI views used by WidgetKit to display the widget.
///
/// For information about adding a widget extension to your app, and keeping
/// your widget up to date, see
/// <doc://com.apple.documentation/documentation/WidgetKit/Creating-a-Widget-Extension>
/// and
/// <doc://com.apple.documentation/documentation/WidgetKit/Keeping-a-Widget-Up-To-Date>,
/// respectively.
///
/// By adding a custom SiriKit intent definition, you can let users customize
/// their widgets to show the information that's most relevant to them. If
/// you've already added support for Siri or Shortcuts, you're well on your way
/// to supporting customizable widgets. For more information, see
/// <doc://com.apple.documentation/documentation/WidgetKit/Making-a-Configurable-Widget>.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol Widget {

    /// The type of configuration representing the content of the widget.
    ///
    /// When you create a custom widget, Swift infers this type from your
    /// implementation of the required ``Widget/body-swift.property`` property.
    associatedtype Body : WidgetConfiguration

    /// Creates a widget using `body` as its content.
    init()

    /// The content and behavior of the widget.
    ///
    /// For any widgets that you create, provide a computed `body` property that
    /// defines the widget as a composition of SwiftUI views.
    ///
    /// Swift infers the widget's ``SwiftUI/Scene/Body-swift.associatedtype``
    /// associated type based on the contents of the `body` property.
    var body: Self.Body { get }
}

/// A container used to expose multiple widgets from a single widget extension.
///
/// To support multiple types of widgets, add the `@main` attribute to a
/// structure that conforms to `WidgetBundle`. For example, a game might have
/// one widget to display summary information about the game and a second
/// widget to display detailed information about individual characters.
///
///     @main
///     struct GameWidgets: WidgetBundle {
///        var body: some Widget {
///            GameStatusWidget()
///            CharacterDetailWidget()
///        }
///     }
///
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol WidgetBundle {

    /// The type of widget that represents the content of the bundle.
    ///
    /// When you support more than one widget, Swift infers this type from your
    /// implementation of the required ``WidgetBundle/body-swift.property``
    /// property.
    associatedtype Body : Widget

    /// Creates a widget bundle using the bundle's body as its content.
    init()

    /// Declares the group of widgets that an app supports.
    ///
    /// The order that the widgets appear in this property determines the order
    /// they are shown to the user when adding a widget. The following example
    /// shows how to use a widget bundle builder to define a body showing
    /// a game status widget first and a character detail widget second:
    ///
    ///     @main
    ///     struct GameWidgets: WidgetBundle {
    ///        var body: some Widget {
    ///            GameStatusWidget()
    ///            CharacterDetailWidget()
    ///        }
    ///     }
    ///
    @WidgetBundleBuilder var body: Self.Body { get }
}

/// A custom attribute that constructs a widget bundle's body.
///
/// Use the `@WidgetBundleBuilder` attribute to group multiple widgets listed
/// in the ``WidgetBundle/body-swift.property`` property of a widget bundle.
/// For example, the following code defines a widget bundle that consists of
/// two widgets.
///
///     @main
///     struct GameWidgets: WidgetBundle {
///        @WidgetBundleBuilder
///        var body: some Widget {
///            GameStatusWidget()
///            CharacterDetailWidget()
///        }
///     }
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@_functionBuilder public struct WidgetBundleBuilder {

    /// Builds an empty Widget from an block containing no statements, `{ }`.
    public static func buildBlock() -> some Widget


    /// Builds a single Widget written as a child view (e..g, `{ MyWidget() }`)
    /// through unmodified.
    public static func buildBlock<Content>(_ content: Content) -> some Widget where Content : Widget

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension WidgetBundleBuilder {

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some Widget where C0 : Widget, C1 : Widget

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension WidgetBundleBuilder {

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some Widget where C0 : Widget, C1 : Widget, C2 : Widget

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension WidgetBundleBuilder {

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some Widget where C0 : Widget, C1 : Widget, C2 : Widget, C3 : Widget

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension WidgetBundleBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some Widget where C0 : Widget, C1 : Widget, C2 : Widget, C3 : Widget, C4 : Widget

}

/// A type that describes a widget's content.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol WidgetConfiguration {

    /// The type of widget configuration representing the body of
    /// this configuration.
    ///
    /// When you create a custom widget, Swift infers this type from your
    /// implementation of the required `body` property.
    associatedtype Body : WidgetConfiguration

    /// The content and behavior of this widget.
    var body: Self.Body { get }
}


/// An empty widget configuration.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@frozen public struct EmptyWidgetConfiguration : WidgetConfiguration {

    @inlinable public init()

    /// The type of widget configuration representing the body of
    /// this configuration.
    ///
    /// When you create a custom widget, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never
}

/// The Accessibility Bold Text user setting options.
///
/// The app can't override the user's choice.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum LegibilityWeight : Hashable {

    /// Use regular font weight (no Accessibility Bold).
    case regular

    /// Use heavier font weight (force Accessibility Bold).
    case bold

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: LegibilityWeight, b: LegibilityWeight) -> Bool

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

extension LegibilityWeight {

    /// Creates a legibility weight from its UILegibilityWeight equivalent.
    @available(iOS 14.0, tvOS 14.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public init?(_ uiLegibilityWeight: UILegibilityWeight)
}
