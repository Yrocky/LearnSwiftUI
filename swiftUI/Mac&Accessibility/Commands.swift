//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// Conforming types represent a group of related commands that can be exposed
/// to the user via the main menu on macOS and key commands on iOS.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol Commands {

    /// The type of command group representing the body of this command group.
    associatedtype Body : Commands

    /// The composition of commands that comprise the command group.
    @CommandsBuilder var body: Self.Body { get }
}

/// Constructs command sets from multi-expression closures. Like `ViewBuilder`,
/// it supports up to ten expressions in the closure body.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
@_functionBuilder public struct CommandsBuilder {

    /// Builds an empty command set from an block containing no statements.
    public static func buildBlock() -> EmptyCommands

    /// Passes a single command group written as a child group through
    /// modified.
    public static func buildBlock<Content>(_ content: Content) -> Content where Content : Commands
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some Commands where C0 : Commands, C1 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands, C3 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands, C3 : Commands, C4 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands, C3 : Commands, C4 : Commands, C5 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands, C3 : Commands, C4 : Commands, C5 : Commands, C6 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands, C3 : Commands, C4 : Commands, C5 : Commands, C6 : Commands, C7 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands, C3 : Commands, C4 : Commands, C5 : Commands, C6 : Commands, C7 : Commands, C8 : Commands

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension CommandsBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some Commands where C0 : Commands, C1 : Commands, C2 : Commands, C3 : Commands, C4 : Commands, C5 : Commands, C6 : Commands, C7 : Commands, C8 : Commands, C9 : Commands

}


/// A built-in set of commands for manipulating window sidebars.
///
/// These commands are optional and can be explicitly requested by passing a
/// value of this type to the `Scene.commands(_:)` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct SidebarCommands : Commands {

    /// A new value describing the built-in sidebar-related commands.
    public init()

    /// The composition of commands that comprise the command group.
    public var body: some Commands { get }

    /// The type of command group representing the body of this command group.
    public typealias Body = some Commands
}


/// A built-in group of commands for searching, editing, and transforming
/// selections of text.
///
/// These commands are optional and can be explicitly requested by passing a
/// value of this type to the `Scene.commands(_:)` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct TextEditingCommands : Commands {

    /// A new value describing the built-in text-editing commands.
    public init()

    /// The composition of commands that comprise the command group.
    public var body: some Commands { get }

    /// The type of command group representing the body of this command group.
    public typealias Body = some Commands
}


/// A built-in set of commands for transforming the styles applied to selections
/// of text.
///
/// These commands are optional and can be explicitly requested by passing a
/// value of this type to the `Scene.commands(_:)` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct TextFormattingCommands : Commands {

    /// A new value describing the built-in text-formatting commands.
    public init()

    /// The composition of commands that comprise the command group.
    public var body: some Commands { get }

    /// The type of command group representing the body of this command group.
    public typealias Body = some Commands
}

/// A built-in set of commands for manipulating window toolbars.
///
/// These commands are optional and can be explicitly requested by passing a
/// value of this type to the `Scene.commands(_:)` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct ToolbarCommands : Commands {

    /// A new value describing the built-in toolbar-related commands.
    public init()

    /// The composition of commands that comprise the command group.
    public var body: some Commands { get }

    /// The type of command group representing the body of this command group.
    public typealias Body = some Commands
}


/// An empty group of commands.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct EmptyCommands : Commands {

    /// Creates an empty group of commands.
    public init()

    /// The type of command group representing the body of this command group.
    public typealias Body = Never
}


/// Command groups describe additional groupings of controls to add to existing
/// command menus.
///
/// On macOS, command groups are realized as collections of menu items in a menu
/// bar menu. On iOS, iPadOS, and tvOS, SwiftUI creates key commands for each of
/// a group's commands that has a keyboard shortcut.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct CommandGroup<Content> : Commands where Content : View {

    /// The composition of commands that comprise the command group.
    public var body: some Commands { get }

    /// A value describing the addition of the given views to the beginning of
    /// the indicated group.
    public init(before group: CommandGroupPlacement, @ViewBuilder addition: () -> Content)

    /// A value describing the addition of the given views to the end of the
    /// indicated group.
    public init(after group: CommandGroupPlacement, @ViewBuilder addition: () -> Content)

    /// A value describing the complete replacement of the contents of the
    /// indicated group with the given views.
    public init(replacing group: CommandGroupPlacement, @ViewBuilder addition: () -> Content)

    /// The type of command group representing the body of this command group.
    public typealias Body = some Commands
}

/// Identifier types for standard locations that new command groups can be
/// placed relative to.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct CommandGroupPlacement {

    /// Standard placement for commands that provide information about the app,
    /// the terms of the user's license agreement, etc.
    ///
    /// Includes the following by default on macOS:
    /// * About App
    public static let appInfo: CommandGroupPlacement

    /// Standard placement for commands that expose app settings and
    /// preferences.
    ///
    /// Includes the following by default on macOS:
    /// * Preferences
    public static let appSettings: CommandGroupPlacement

    /// Standard placement for commands that expose services provided by other
    /// apps.
    ///
    /// Includes the following by default on macOS:
    /// * Services submenu (managed automatically)
    public static let systemServices: CommandGroupPlacement

    /// Standard placement for commands that control the visibility of running
    /// apps.
    ///
    /// Includes the following by default on macOS:
    /// * Hide App
    /// * Hide Others
    /// * Show All
    public static let appVisibility: CommandGroupPlacement

    /// Standard placement for commands that result in app termination.
    ///
    /// Includes the following by default on macOS:
    /// * Quit App
    public static let appTermination: CommandGroupPlacement

    /// Standard placement for commands that create and open different kinds of
    /// documents.
    ///
    /// Includes the following by default on macOS:
    /// * New
    /// * Open
    /// * Open Recent submenu (managed automatically)
    public static let newItem: CommandGroupPlacement

    /// Standard placement for commands that save open documents and close
    /// windows.
    ///
    /// Includes the following by default on macOS:
    /// * Close
    /// * Save
    /// * Save As/Duplicate
    /// * Revert to Saved
    public static let saveItem: CommandGroupPlacement

    /// Standard placement for commands that relate to importing and exporting
    /// data using formats that the app doesn't natively support.
    ///
    /// Empty by default on macOS.
    public static let importExport: CommandGroupPlacement

    /// Standard placement for commands related to printing app content.
    ///
    /// Includes the following by default on macOS:
    /// * Page Setup
    /// * Print
    public static let printItem: CommandGroupPlacement

    /// Standard placement for commands that control the Undo Manager.
    ///
    /// Includes the following by default on macOS:
    /// * Undo
    /// * Redo
    public static let undoRedo: CommandGroupPlacement

    /// Standard placement for commands that interact with the pasteboard and
    /// manipulate content that is currently selected in the app's view
    /// hierarchy.
    ///
    /// Includes the following by default on macOS:
    /// * Cut
    /// * Copy
    /// * Paste
    /// * Paste and Match Style
    /// * Delete
    /// * Select All
    public static let pasteboard: CommandGroupPlacement

    /// Standard placement for commands that manipulate and transform text
    /// selections.
    ///
    /// Includes the following by default on macOS:
    /// * Find submenu
    /// * Spelling and Grammar submenu
    /// * Substitutions submenu
    /// * Transformations submenu
    /// * Speech submenu
    public static let textEditing: CommandGroupPlacement

    /// Standard placement for commands that manipulate and transform the styles
    /// applied to text selections.
    ///
    /// Includes the following by default on macOS:
    /// * Font submenu
    /// * Text submenu
    public static let textFormatting: CommandGroupPlacement

    /// Standard placement for commands that manipulate the toolbar.
    ///
    /// Includes the following by default on macOS:
    /// * Show/Hide Toolbar
    /// * Customize Toolbar
    public static let toolbar: CommandGroupPlacement

    /// Standard placement for commands that control the app's sidebar and full
    /// screen modes.
    ///
    /// Includes the following by default on macOS:
    /// * Show/Hide Sidebar
    /// * Enter/Exit Full Screen
    public static let sidebar: CommandGroupPlacement

    /// Standard placement for commands that control the size of the window.
    ///
    /// Includes the following by default on macOS:
    /// * Minimize
    /// * Zoom
    public static let windowSize: CommandGroupPlacement

    /// Standard placement for commands that arrange all of an app's windows.
    ///
    /// Includes the following by default on macOS:
    /// * Bring All to Front
    public static let windowArrangement: CommandGroupPlacement

    /// Standard placement for commands that present documentation and helpful
    /// information to the user.
    ///
    /// Includes the following by default on macOS:
    /// * App Help
    public static let help: CommandGroupPlacement
}

/// Command menus are stand-alone, top-level containers for controls that
/// perform related, app-specific commands.
///
/// Command menus are realized as menu bar menus on macOS, inserted between the
/// built-in View and Window menus in order of declaration. On iOS, iPadOS, and
/// tvOS, SwiftUI creates key commands for each of a menu's commands that has a
/// keyboard shortcut.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct CommandMenu<Content> : Commands where Content : View {

    /// The composition of commands that comprise the command group.
    public var body: some Commands { get }

    /// Creates a new menu with a localized name for a collection of app-
    /// specific commands, inserted in the standard location for app menus
    /// (after the View menu, in order with other menus declared without an
    /// explicit location).
    public init(_ nameKey: LocalizedStringKey, @ViewBuilder content: () -> Content)

    /// Creates a new menu for a collection of app-specific commands, inserted
    /// in the standard location for app menus (after the View menu, in order
    /// with other menus declared without an explicit location).
    public init(_ name: Text, @ViewBuilder content: () -> Content)

    /// Creates a new menu for a collection of app-specific commands, inserted
    /// in the standard location for app menus (after the View menu, in order
    /// with other menus declared without an explicit location).
    public init<S>(_ name: S, @ViewBuilder content: () -> Content) where S : StringProtocol

    /// The type of command group representing the body of this command group.
    public typealias Body = some Commands
}


@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension Scene {

    /// Adds commands to the scene.
    ///
    /// Commands are realized in different ways on different platforms. On
    /// macOS, the main menu uses the available command menus and groups to
    /// organize its main menu items. Each menu is represented as a top-level
    /// menu bar menu, and each command group has a corresponding set of menu
    /// items in one of the top-level menus, delimited by separator menu items.
    ///
    /// On iPadOS, commands with keyboard shortcuts are exposed in the shortcut
    /// discoverability HUD that users see when they hold down the Command (⌘)
    /// key.
    public func commands<Content>(@CommandsBuilder content: () -> Content) -> some Scene where Content : Commands

}
