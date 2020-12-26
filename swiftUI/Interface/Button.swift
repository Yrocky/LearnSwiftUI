//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A control that performs an action when triggered.
///
/// You create a button by providing an action and a label. The action is either
/// a method or closure property that does something when a user clicks or taps
/// the button. The label is a view that describes the button's action, for
/// example, by showing text such as Cancel or an icon such as a back arrow.
///
///     Button(action: signIn) {
///         Text("Sign In")
///     }
///
/// For the common case of text-only labels, you can use the convenience
/// initializer that takes a title string (or localized string key) as its first
/// parameter, instead of a trailing closure:
///
///     Button("Sign In", action: signIn)
///
/// The method of triggering the button varies by platform:
/// - In iOS and watchOS, the user triggers a standard button by tapping on it.
/// - In macOS, the user triggers a standard button by clicking on it.
/// - In tvOS, the user triggers a standard button by pressing "select" on an
///   external remote, like the Siri Remote, while focusing on the button.
///
/// ### Adding Buttons to Containers
///
/// Use buttons for any user interface element that triggers actions on press.
/// Buttons automatically adapt their visual style to match the expected style
/// within these different containers and contexts. For example, to create a
/// list cell that triggers an action when selected by the user, add a button to
/// the list's content. For example:
///
///     // A list of items, where the last row, when triggered,
///     // opens a UI for adding a new item.
///     List {
///         ForEach(items) { item in
///             Text(item.title)
///         }
///         Button("Add Item", action: addItem)
///     }
///
/// Similarly, to create a context menu item that triggers an action, add a
/// button to the menu's content:
///
///     .contextMenu {
///         Button("Cut", action: cut)
///         Button("Copy", action: copy)
///         Button("Paste", action: paste)
///     }
///
/// This pattern extends to most other container views in SwiftUI that have
/// customizable, interactive content, like forms (instances of ``Form``).
///
/// ### Styling Buttons
///
/// You can customize a button's appearance and interaction behavior. To add a
/// custom appearance with standard interaction behavior, create a style that
/// conforms to the ``ButtonStyle`` protocol. To customize both appearance and
/// interaction behavior, create a style that conforms to the
/// ``PrimitiveButtonStyle`` protocol. To set a specific style for all button
/// instances within a view, use the ``View/buttonStyle(_:)-66fbx`` modifier:
///
///     HStack {
///         Button("Sign In", action: signIn)
///         Button("Register", action: register)
///     }
///     .buttonStyle(BorderedButtonStyle())
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Button<Label> : View where Label : View {

    /// Creates a button that displays a custom label.
    ///
    /// - Parameters:
    ///   - action: The action to perform when the user triggers the button.
    ///   - label: A view that describes the purpose of the button's `action`.
    public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Button where Label == Text {

    /// Creates a button that generates its label from a localized string key.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// localized key similar to ``Text/init(_:tableName:bundle:comment:)``. See
    /// ``Text`` for more information about localizing strings.
    ///
    /// To initialize a button with a string variable, use
    /// ``Button/init(_:action:)-lpm7`` instead.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the button's localized title, that describes
    ///     the purpose of the button's `action`.
    ///   - action: The action to perform when the user triggers the button.
    public init(_ titleKey: LocalizedStringKey, action: @escaping () -> Void)

    /// Creates a button that generates its label from a string.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// title similar to ``Text/init(_:)-9d1g4``. See ``Text`` for more
    /// information about localizing strings.
    ///
    /// To initialize a button with a localized string key, use
    /// ``Button/init(_:action:)-1asy`` instead.
    ///
    /// - Parameters:
    ///   - title: A string that describes the purpose of the button's `action`.
    ///   - action: The action to perform when the user triggers the button.
    public init<S>(_ title: S, action: @escaping () -> Void) where S : StringProtocol
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Button where Label == PrimitiveButtonStyleConfiguration.Label {

    /// Creates a button based on a configuration for a style with a custom
    /// appearance and custom interaction behavior.
    ///
    /// Use this initializer within the
    /// ``PrimitiveButtonStyle/makeBody(configuration:)`` method of a
    /// ``PrimitiveButtonStyle`` to create an instance of the button that you
    /// want to style. This is useful for custom button styles that modify the
    /// current button style, rather than implementing a brand new style.
    ///
    /// For example, the following style adds a red border around the button,
    /// but otherwise preserves the button's current style:
    ///
    ///     struct RedBorderedButtonStyle : PrimitiveButtonStyle {
    ///         func makeBody(configuration: Configuration) -> some View {
    ///             Button(configuration)
    ///                 .border(Color.red)
    ///         }
    ///     }
    ///
    /// - Parameter configuration: A configuration for a style with a custom
    ///   appearance and custom interaction behavior.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public init(_ configuration: PrimitiveButtonStyleConfiguration)
}

/// A type that applies standard interaction behavior and a custom appearance to
/// all buttons within a view hierarchy.
///
/// To configure the current button style for a view hierarchy, use the
/// ``View/buttonStyle(_:)-7qx1`` modifier. Specify a style that conforms to
/// ``ButtonStyle`` when creating a button that uses the standard button
/// interaction behavior defined for each platform. To create a button with
/// custom interaction behavior, use ``PrimitiveButtonStyle`` instead.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol ButtonStyle {

    /// A view that represents the body of a button.
    associatedtype Body : View

    /// Creates a view that represents the body of a button.
    ///
    /// The system calls this method for each ``Button`` instance in a view
    /// hierarchy where this style is the current button style.
    ///
    /// - Parameter configuration : The properties of the button.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a button.
    typealias Configuration = ButtonStyleConfiguration
}

/// The properties of a button.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ButtonStyleConfiguration {

    /// A type-erased label of a button.
    public struct Label : View {

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public typealias Body = Never
    }

    /// A view that describes the effect of pressing the button.
    public let label: ButtonStyleConfiguration.Label

    /// A Boolean that indicates whether the user is currently pressing the
    /// button.
    public let isPressed: Bool
}


/// A type that applies custom interaction behavior and a custom appearance to
/// all buttons within a view hierarchy.
///
/// To configure the current button style for a view hierarchy, use the
/// ``View/buttonStyle(_:)-66fbx`` modifier. Specify a style that conforms to
/// ``PrimitiveButtonStyle`` to create a button with custom interaction
/// behavior. To create a button with the standard button interaction behavior
/// defined for each platform, use ``ButtonStyle`` instead.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol PrimitiveButtonStyle {

    /// A view that represents the body of a button.
    associatedtype Body : View

    /// Creates a view that represents the body of a button.
    ///
    /// The system calls this method for each ``Button`` instance in a view
    /// hierarchy where this style is the current button style.
    ///
    /// - Parameter configuration : The properties of the button.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a button.
    typealias Configuration = PrimitiveButtonStyleConfiguration
}

/// The properties of a button.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PrimitiveButtonStyleConfiguration {

    /// A type-erased label of a button.
    public struct Label : View {

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public typealias Body = Never
    }

    /// A view that describes the effect of calling the button's action.
    public let label: PrimitiveButtonStyleConfiguration.Label

    /// Performs the button's action.
    public func trigger()
}


/// The default button style, based on the button's context.
///
/// If you create a button directly on a blank canvas, the style varies by
/// platform. iOS uses the borderless button style by default, whereas macOS,
/// tvOS, and watchOS use the bordered button style.
///
/// If you create a button inside a container, like a ``List``, the style
/// resolves to the recommended style for buttons inside that container for that
/// specific platform.
///
/// You can override a button's style. To apply the default style to a button,
/// or to a view that contains buttons, use the ``View/buttonStyle(_:)-66fbx``
/// modifier.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct DefaultButtonStyle : PrimitiveButtonStyle {

    /// Creates a default button style.
    public init()

    /// Creates a view that represents the body of a button.
    ///
    /// The system calls this method for each ``Button`` instance in a view
    /// hierarchy where this style is the current button style.
    ///
    /// - Parameter configuration : The properties of the button.
    public func makeBody(configuration: DefaultButtonStyle.Configuration) -> some View


    /// A view that represents the body of a button.
    public typealias Body = some View
}


/// A button style that doesn't apply a border.
///
/// To apply this style to a button, or to a view that contains buttons, use the
/// ``View/buttonStyle(_:)-66fbx`` modifier.
@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct BorderlessButtonStyle : PrimitiveButtonStyle {

    /// Creates a borderless button style.
    public init()

    /// Creates a view that represents the body of a button.
    ///
    /// The system calls this method for each ``Button`` instance in a view
    /// hierarchy where this style is the current button style.
    ///
    /// - Parameter configuration : The properties of the button.
    public func makeBody(configuration: BorderlessButtonStyle.Configuration) -> some View


    /// A view that represents the body of a button.
    public typealias Body = some View
}


/// A button style that doesn't style or decorate its content while idle, but
/// may apply a visual effect to indicate the pressed, focused, or enabled state
/// of the button.
///
/// To apply this style to a button, or to a view that contains buttons, use the
/// ``View/buttonStyle(_:)-66fbx`` modifier.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PlainButtonStyle : PrimitiveButtonStyle {

    /// Creates a plain button style.
    public init()

    /// Creates a view that represents the body of a button.
    ///
    /// The system calls this method for each ``Button`` instance in a view
    /// hierarchy where this style is the current button style.
    ///
    /// - Parameter configuration : The properties of the button.
    public func makeBody(configuration: PlainButtonStyle.Configuration) -> some View


    /// A view that represents the body of a button.
    public typealias Body = some View
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the style for buttons within this view to a button style with a
    /// custom appearance and standard interaction behavior.
    ///
    /// To set a specific style for all button instances within a view, use the
    /// ``View/buttonStyle(_:)-66fbx`` modifier:
    ///
    ///     HStack {
    ///         Button("Sign In", action: signIn)
    ///         Button("Register", action: register)
    ///     }
    ///     .buttonStyle(BorderedButtonStyle())
    public func buttonStyle<S>(_ style: S) -> some View where S : ButtonStyle

}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the style for buttons within this view to a button style with a
    /// custom appearance and custom interaction behavior.
    ///
    /// To set a specific style for all button instances within a view, use the
    /// ``View/buttonStyle(_:)-66fbx`` modifier:
    ///
    ///     HStack {
    ///         Button("Sign In", action: signIn)
    ///         Button("Register", action: register)
    ///     }
    ///     .buttonStyle(BorderedButtonStyle())
    public func buttonStyle<S>(_ style: S) -> some View where S : PrimitiveButtonStyle

}
