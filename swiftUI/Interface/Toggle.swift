//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A control that toggles between on and off states.
///
/// You create a toggle by providing an `isOn` binding and a label. Bind `isOn`
/// to a Boolean property that determines whether the toggle is on or off. Set
/// the label to a view that visually describes the purpose of switching between
/// toggle states. For example:
///
///     @State private var vibrateOnRing = false
///
///     var body: some View {
///         Toggle(isOn: $vibrateOnRing) {
///             Text("Vibrate on Ring")
///         }
///     }
///
/// For the common case of text-only labels, you can use the convenience
/// initializer that takes a title string (or localized string key) as its first
/// parameter, instead of a trailing closure:
///
///     @State private var vibrateOnRing = true
///
///     var body: some View {
///         Toggle("Vibrate on Ring", isOn: $vibrateOnRing)
///     }
///
/// ### Styling Toggles
///
/// You can customize the appearance and interaction of toggles by creating
/// styles that conform to the ``ToggleStyle`` protocol. To set a specific style
/// for all toggle instances within a view, use the ``View/toggleStyle(_:)``
/// modifier:
///
///     VStack {
///         Toggle("Vibrate on Ring", isOn: $vibrateOnRing)
///         Toggle("Vibrate on Silent", isOn: $vibrateOnSilent)
///     }
///     .toggleStyle(SwitchToggleStyle())
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Toggle<Label> : View where Label : View {

    /// Creates a toggle that displays a custom label.
    ///
    /// - Parameters:
    ///   - isOn: A binding to a property that determines whether the toggle is on
    ///     or off.
    ///   - label: A view that describes the purpose of the toggle.
    public init(isOn: Binding<Bool>, @ViewBuilder label: () -> Label)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Toggle where Label == ToggleStyleConfiguration.Label {

    /// Creates a toggle based on a toggle style configuration.
    ///
    /// You can use this initializer within the
    /// ``ToggleStyle/makeBody(configuration:)`` method of a ``ToggleStyle`` to
    /// create an instance of the styled toggle. This is useful for custom
    /// toggle styles that only modify the current toggle style, as opposed to
    /// implementing a brand new style.
    ///
    /// For example, the following style adds a red border around the toggle,
    /// but otherwise preserves the toggle's current style:
    ///
    ///     struct RedBorderedToggleStyle : ToggleStyle {
    ///         typealias Body = Toggle
    ///
    ///         func makeBody(configuration: Configuration) -> some View {
    ///             Toggle(configuration)
    ///                 .border(Color.red)
    ///         }
    ///     }
    ///
    /// - Parameter configuration: A toggle style configuration.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public init(_ configuration: ToggleStyleConfiguration)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Toggle where Label == Text {

    /// Creates a toggle that generates its label from a localized string key.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// localized key similar to ``Text/init(_:tableName:bundle:comment:)``. See
    /// `Text` for more information about localizing strings.
    ///
    /// To initialize a toggle with a string variable, use
    /// ``Toggle/init(_:isOn:)-2qurm`` instead.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the toggle's localized title, that describes
    ///     the purpose of the toggle.
    ///   - isOn: A binding to a property that indicates whether the toggle is
    ///    on or off.
    public init(_ titleKey: LocalizedStringKey, isOn: Binding<Bool>)

    /// Creates a toggle that generates its label from a string.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// title similar to ``Text/init(_:)-9d1g4``. See `Text` for more
    /// information about localizing strings.
    ///
    /// To initialize a toggle with a localized string key, use
    /// ``Toggle/init(_:isOn:)-8qx3l`` instead.
    ///
    /// - Parameters:
    ///   - title: A string that describes the purpose of the toggle.
    ///   - isOn: A binding to a property that indicates whether the toggle is
    ///    on or off.
    public init<S>(_ title: S, isOn: Binding<Bool>) where S : StringProtocol
}

/// A type that specifies the appearance and interaction of all toggles within a
/// view hierarchy.
///
/// To configure the current toggle style for a view hiearchy, use the
/// ``View/toggleStyle(_:)`` modifier.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol ToggleStyle {

    /// A view that represents the appearance and interaction of a toggle.
    associatedtype Body : View

    /// Creates a view that represents the body of a toggle.
    ///
    /// The system calls this method for each ``Toggle`` instance in a view
    /// hierarchy where this style is the current toggle style.
    ///
    /// - Parameter configuration: The properties of the toggle, such as its
    ///   label and its “on” state.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a toggle instance.
    typealias Configuration = ToggleStyleConfiguration
}

/// The properties of a toggle instance.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ToggleStyleConfiguration {

    /// A type-erased label of a toggle.
    public struct Label : View {

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public typealias Body = Never
    }

    /// A view that describes the effect of switching the toggle between its
    /// on and off states.
    public let label: ToggleStyleConfiguration.Label

    /// A binding to a state property that indicates whether the toggle is on or
    /// off.
    public var isOn: Bool { get nonmutating set }

    public var $isOn: Binding<Bool> { get }
}


/// The default toggle style.
///
/// If you create a toggle directly on a blank canvas, the style varies:
///
/// - For the phone, pad, and watch idioms, the default toggle style is a
///   switch.
/// - For the Mac idiom, the default toggle style is a checkbox.
/// - For the TV idom, the default toggle style is a button.
///
/// If you create a toggle inside a container, such as a ``List``, the toggle
/// automatically uses a style appropriate to the context. To apply a different
/// style to a toggle, or to a view that contains toggles, use the
/// ``View/toggleStyle(_:)`` modifier. To revert a custom-styled toggle to the
///  default, use `toggleStyle(DefaultToggleStyle())`.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct DefaultToggleStyle : ToggleStyle {

    /// Creates a default toggle style.
    public init()

    /// Creates a view that represents the body of a toggle.
    ///
    /// The system calls this method for each ``Toggle`` instance in a view
    /// hierarchy where this style is the current toggle style.
    ///
    /// - Parameter configuration: The properties of the toggle.
    public func makeBody(configuration: DefaultToggleStyle.Configuration) -> some View


    /// A view that represents the appearance and interaction of a toggle.
    public typealias Body = some View
}


/// A toggle style that displays a leading label and a trailing switch.
///
/// To apply this style to a toggle, or to a view that contains toggles, use the
/// ``View/toggleStyle(_:)`` modifier.
@available(iOS 13.0, macOS 10.15, watchOS 6.0, *)
@available(tvOS, unavailable)
public struct SwitchToggleStyle : ToggleStyle {

    /// Creates a switch toggle style.
    public init()

    /// Creates a switch style with a tint color.
    @available(iOS 14.0, macOS 11.0, watchOS 7.0, *)
    @available(tvOS, unavailable)
    public init(tint: Color)

    /// Creates a view representing the body of a toggle.
    ///
    /// The system calls this method for each ``Toggle`` instance in a view
    /// hierarchy where this style is the current toggle style.
    ///
    /// - Parameter configuration: The properties of the toggle, such as its
    ///   label and its “on” state.
    public func makeBody(configuration: SwitchToggleStyle.Configuration) -> some View


    /// A view that represents the appearance and interaction of a toggle.
    public typealias Body = some View
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the style for toggles within this view.
    ///
    /// To set a specific style for all toggle instances within a view, use the
    /// ``View/toggleStyle(_:)`` modifier, as follows:
    ///
    ///     VStack {
    ///         Toggle("Vibrate on Ring", isOn: $vibrateOnRing)
    ///         Toggle("Vibrate on Silent", isOn: $vibrateOnSilent)
    ///     }
    ///     .toggleStyle(SwitchToggleStyle())
    ///
    /// - Parameter style: The style to set.
    public func toggleStyle<S>(_ style: S) -> some View where S : ToggleStyle

}
