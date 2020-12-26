//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A control for presenting a menu of actions.
///
/// The following example presents a menu of three buttons and a submenu, which
/// contains three buttons of its own.
///
///     Menu("Actions") {
///         Button("Duplicate", action: duplicate)
///         Button("Rename", action: rename)
///         Button("Delete…", action: delete)
///         Menu("Copy") {
///             Button("Copy", action: copy)
///             Button("Copy Formatted", action: copyFormatted)
///             Button("Copy Library Path", action: copyPath)
///         }
///     }
///
/// You can create the menu's title with a ``LocalizedStringKey``, as seen in
/// the previous example, or with a view builder that creates multiple views,
/// such as an image and a text view:
///
///     Menu {
///         Button("Open in Preview", action: openInPreview)
///         Button("Save as PDF", action: saveAsPDF)
///     } label: {
///         Image(systemName: "document")
///         Text("PDF")
///     }
///
/// ### Styling Menus
///
/// Use the ``View/menuStyle(_:)`` modifier to change the style of all menus
/// in a view. The following example shows how to apply a custom style:
///
///     Menu("Editing") {
///         Button("Set In Point", action: setInPoint)
///         Button("Set Out Point", action: setOutPoint)
///     }
///     .menuStyle(EditingControlsMenuStyle())
///
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct Menu<Label, Content> : View where Label : View, Content : View {

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
extension Menu {

    /// Creates a menu with a custom label.
    ///
    /// - Parameters:
    ///     - content: A group of menu items.
    ///     - label: A view describing the content of the menu.
    public init(@ViewBuilder content: () -> Content, @ViewBuilder label: () -> Label)

    /// Creates a menu that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///     - titleKey: The key for the link's localized title, which describes
    ///         the contents of the menu.
    ///     - content: A group of menu items.
    public init(_ titleKey: LocalizedStringKey, @ViewBuilder content: () -> Content) where Label == Text

    /// Creates a menu that generates its label from a string.
    ///
    /// To create the label with a localized string key, use
    /// ``Menu/init(_:content:)-7v768`` instead.
    ///
    /// - Parameters:
    ///     - title: A string that describes the contents of the menu.
    ///     - content: A group of menu items.
    public init<S>(_ title: S, @ViewBuilder content: () -> Content) where Label == Text, S : StringProtocol
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension Menu where Label == MenuStyleConfiguration.Label, Content == MenuStyleConfiguration.Content {

    /// Creates a menu based on a style configuration.
    ///
    /// Use this initializer within the ``MenuStyle/makeBody(configuration:)``
    /// method of a ``MenuStyle`` instance to create an instance of the menu
    /// being styled. This is useful for custom menu styles that modify the
    /// current menu style.
    ///
    /// For example, the following code creates a new, custom style that adds a
    /// red border around the current menu style:
    ///
    ///     struct RedBorderMenuStyle: MenuStyle {
    ///         func makeBody(configuration: Configuration) -> some View {
    ///             Menu(configuration)
    ///                 .border(Color.red)
    ///         }
    ///     }
    ///
    public init(_ configuration: MenuStyleConfiguration)
}

/// A type that applies standard interaction behavior and a custom appearance
/// to all menus within a view hierarchy.
///
/// To configure the current menu style for a view hiearchy, use the
/// ``View/menuStyle(_:)`` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol MenuStyle {

    /// A view that represents the body of a menu.
    associatedtype Body : View

    /// Creates a view that represents the body of a menu.
    ///
    /// - Parameter configuration: The properties of the menu.
    ///
    /// The system calls this method for each ``Menu`` instance in a view
    /// hierarchy where this style is the current menu style.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a menu.
    typealias Configuration = MenuStyleConfiguration
}

/// A configuration of a menu.
///
/// Use the ``Menu/init(_:)`` initializer of ``Menu`` to create an
/// instance using the current menu style, which you can modify to create a
/// custom style.
///
/// For example, the following code creates a new, custom style that adds a red
/// border to the current menu style:
///
///     struct RedBorderMenuStyle : MenuStyle {
///         func makeBody(configuration: Configuration) -> some View {
///             Menu(configuration)
///                 .border(Color.red)
///         }
///     }
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct MenuStyleConfiguration {

    /// A type-erased label of a menu.
    public struct Label : View {

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public typealias Body = Never
    }

    /// A type-erased content of a menu.
    public struct Content : View {

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public typealias Body = Never
    }
}


/// A menu style that displays a borderless button that toggles the display of
/// the menu's contents when pressed.
///
/// On macOS, the button optionally displays an arrow indicating that it presents
/// a menu.
///
/// Pressing and then dragging into the contents triggers the chosen action on
/// release.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct BorderlessButtonMenuStyle : MenuStyle {

    /// Creates a borderless button menu style.
    ///
    /// By default, the borderless style displays a visual indicator that it
    /// represents a menu.
    public init()

    /// Creates a view that represents the body of a menu.
    ///
    /// - Parameter configuration: The properties of the menu.
    ///
    /// The system calls this method for each ``Menu`` instance in a view
    /// hierarchy where this style is the current menu style.
    public func makeBody(configuration: BorderlessButtonMenuStyle.Configuration) -> some View


    /// A view that represents the body of a menu.
    public typealias Body = some View
}


/// The default menu style, based on the menu's context.
///
/// The default menu style can vary by platform. By default, macOS uses the
/// bordered button style.
///
/// If you create a menu inside a container, the style resolves to the
/// recommended style for menus inside that container for that specific platform.
/// For example, a menu nested within another menu will resolve to a submenu:
///
///     Menu("Edit") {
///         Menu("Arrange") {
///             Button("Bring to Front", action: moveSelectionToFront)
///             Button("Send to Back", action: moveSelectionToBack)
///         }
///         Button("Delete", action: deleteSelection)
///     }
///
/// You can override a menu's style. To apply the default style to a menu, or to
/// a view that contains a menu, use the ``View/menuStyle(_:)`` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DefaultMenuStyle : MenuStyle {

    /// Creates a default menu style.
    public init()

    /// Creates a view that represents the body of a menu.
    ///
    /// - Parameter configuration: The properties of the menu.
    ///
    /// The system calls this method for each ``Menu`` instance in a view
    /// hierarchy where this style is the current menu style.
    public func makeBody(configuration: DefaultMenuStyle.Configuration) -> some View


    /// A view that represents the body of a menu.
    public typealias Body = some View
}



/// A container for views that you present as menu items in a contextual menu
/// after completion of the standard system gesture.
///
/// Relate the controls that a `ContextMenu` contains to the context from
/// which you show them.
@available(iOS, introduced: 13.0, deprecated: 100000.0, message: "Use `contextMenu(menuItems:)` instead.")
@available(macOS, introduced: 10.15, deprecated: 100000.0, message: "Use `contextMenu(menuItems:)` instead.")
@available(tvOS, unavailable)
@available(watchOS, introduced: 6.0, deprecated: 7.0)
public struct ContextMenu<MenuItems> where MenuItems : View {

    public init(@ViewBuilder menuItems: () -> MenuItems)
}


@available(iOS 13.0, macOS 10.15, tvOS 14.0, *)
@available(watchOS, introduced: 6.0, deprecated: 7.0)
extension View {

    /// Adds a context menu to the view.
    ///
    /// Use contextual menus to add actions that change depending on the user's
    /// current focus and task.
    ///
    /// The following example creates a ``Text`` view with a contextual menu.
    /// Note that the actions invoked by the menu selection could be coded
    /// directly inside the button closures or, as shown below, invoked via
    /// function references.
    ///
    ///     func selectHearts() {
    ///         // Act on hearts selection.
    ///     }
    ///     func selectClubs() { ... }
    ///     func selectSpades() { ... }
    ///     func selectDiamonds() { ... }
    ///
    ///     Text("Favorite Card Suit")
    ///         .padding()
    ///         .contextMenu {
    ///             Button("♥️ - Hearts", action: selectHearts)
    ///             Button("♣️ - Clubs", action: selectClubs)
    ///             Button("♠️ - Spades", action: selectSpades)
    ///             Button("♦️ - Diamonds", action: selectDiamonds)
    ///         }
    ///
    /// ![A context menu showing four menu items.](SwiftUI-contextMenu.png)
    ///
    /// - Parameter menuItems: A `contextMenu` that contains one or more menu items.
    /// - Returns: A view that adds a contextual menu to this view.
    public func contextMenu<MenuItems>(@ViewBuilder menuItems: () -> MenuItems) -> some View where MenuItems : View

}


@available(iOS, introduced: 13.0, deprecated: 100000.0, message: "Use `contextMenu(menuItems:)` instead.")
@available(macOS, introduced: 10.15, deprecated: 100000.0, message: "Use `contextMenu(menuItems:)` instead.")
@available(tvOS, unavailable)
@available(watchOS, introduced: 6.0, deprecated: 7.0)
extension View {

    /// Attaches a context menu and its children to the view.
    ///
    /// Use `contextMenu(_:)` to attach a contextual menu struct and its
    /// children to the view. This modifier allows for the contextual menu to be
    /// conditionally available by passing `nil` as the value for `contextMenu`.
    ///
    /// In the example below a ``ContextMenu`` that contains four menu items is
    /// created and is passed into the `contextMenu(_:)` modifier. The
    /// attachment of context menu is controlled by the Boolean value
    /// `shouldShowMenu` which is `true`, enabling the contextual menu.
    ///
    /// Note that the actions invoked by the menu selection could be coded
    /// directly inside the button closures or, as shown below, invoked via
    /// function references.
    ///
    ///     func selectHearts() {
    ///         // Act on hearts selection.
    ///     }
    ///     func selectClubs() { ... }
    ///     func selectSpades() { ... }
    ///     func selectDiamonds() { ... }
    ///
    ///     let menuItems = ContextMenu {
    ///         Button("♥️ - Hearts", action: selectHearts)
    ///         Button("♣️ - Clubs", action: selectClubs)
    ///         Button("♠️ - Spades", action: selectSpades)
    ///         Button("♦️ - Diamonds", action: selectDiamonds)
    ///     }
    ///
    ///     struct ContextMenuMenuItems: View {
    ///         private var shouldShowMenu = true
    ///         var body: some View {
    ///             VStack {
    ///                 Text("Favorite Card Suit")
    ///                     .padding()
    ///                     .contextMenu(shouldShowMenu ? menuItems : nil)
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameter contextMenu: A context menu container for views that you
    ///   present as menu items in a contextual menu.
    ///
    /// - Returns: A view that adds a contextual menu to this view.
    public func contextMenu<MenuItems>(_ contextMenu: ContextMenu<MenuItems>?) -> some View where MenuItems : View

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Sets the style for menus within this view.
    ///
    /// To set a specific style for all menu instances within a view, use the
    /// `menuStyle(_:)` modifier:
    ///
    ///     Menu("PDF") {
    ///         Button("Open in Preview", action: openInPreview)
    ///         Button("Save as PDF", action: saveAsPDF)
    ///     }
    ///     .menuStyle(ButtonMenuStyle())
    ///
    public func menuStyle<S>(_ style: S) -> some View where S : MenuStyle

}
