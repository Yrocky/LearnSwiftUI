//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// Conforming types represent items that can be placed in various locations
/// in a toolbar.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol ToolbarContent {

    /// The type of content representing the body of this toolbar content.
    associatedtype Body : ToolbarContent

    /// The composition of content that comprise the toolbar content.
    @ToolbarContentBuilder var body: Self.Body { get }
}

/// Constructs a toolbar item set from multi-expression closures.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@_functionBuilder public struct ToolbarContentBuilder {

    public static func buildBlock<Content>(_ content: Content) -> some ToolbarContent where Content : ToolbarContent


    public static func buildBlock<Content>(_ content: Content) -> some CustomizableToolbarContent where Content : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent, C3 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent, C3 : ToolbarContent, C4 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent, C3 : ToolbarContent, C4 : ToolbarContent, C5 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent, C3 : ToolbarContent, C4 : ToolbarContent, C5 : ToolbarContent, C6 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent, C3 : ToolbarContent, C4 : ToolbarContent, C5 : ToolbarContent, C6 : ToolbarContent, C7 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent, C3 : ToolbarContent, C4 : ToolbarContent, C5 : ToolbarContent, C6 : ToolbarContent, C7 : ToolbarContent, C8 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some ToolbarContent where C0 : ToolbarContent, C1 : ToolbarContent, C2 : ToolbarContent, C3 : ToolbarContent, C4 : ToolbarContent, C5 : ToolbarContent, C6 : ToolbarContent, C7 : ToolbarContent, C8 : ToolbarContent, C9 : ToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent, C3 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent, C3 : CustomizableToolbarContent, C4 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent, C3 : CustomizableToolbarContent, C4 : CustomizableToolbarContent, C5 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent, C3 : CustomizableToolbarContent, C4 : CustomizableToolbarContent, C5 : CustomizableToolbarContent, C6 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent, C3 : CustomizableToolbarContent, C4 : CustomizableToolbarContent, C5 : CustomizableToolbarContent, C6 : CustomizableToolbarContent, C7 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent, C3 : CustomizableToolbarContent, C4 : CustomizableToolbarContent, C5 : CustomizableToolbarContent, C6 : CustomizableToolbarContent, C7 : CustomizableToolbarContent, C8 : CustomizableToolbarContent

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarContentBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some CustomizableToolbarContent where C0 : CustomizableToolbarContent, C1 : CustomizableToolbarContent, C2 : CustomizableToolbarContent, C3 : CustomizableToolbarContent, C4 : CustomizableToolbarContent, C5 : CustomizableToolbarContent, C6 : CustomizableToolbarContent, C7 : CustomizableToolbarContent, C8 : CustomizableToolbarContent, C9 : CustomizableToolbarContent

}

/// A model that represents an item which can be placed in the toolbar
/// or navigation bar.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ToolbarItem<ID, Content> : ToolbarContent where Content : View {

    /// The type of content representing the body of this toolbar content.
    public typealias Body = Never
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarItem where ID == Void {

    /// Creates a toolbar item with the specified placement and content.
    ///
    /// - Parameters:
    ///   - placement: Which section of the toolbar
    ///     the item should be placed in.
    ///   - content: The content of the item.
    public init(placement: ToolbarItemPlacement = .automatic, @ViewBuilder content: () -> Content)
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarItem : CustomizableToolbarContent where ID == String {

    /// Creates a toolbar item with the specified placement and content,
    /// which allows for user customization.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for this item.
    ///   - placement: Which section of the toolbar
    ///     the item should be placed in.
    ///   - showsByDefault: Whether the item appears by default in the toolbar,
    ///     or only shows if the user explicitly adds it via customization.
    ///   - content: The content of the item.
    public init(id: String, placement: ToolbarItemPlacement = .automatic, showsByDefault: Bool = true, @ViewBuilder content: () -> Content)
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ToolbarItem : Identifiable where ID : Hashable {

    /// The stable identity of the entity associated with this instance.
    public var id: ID { get }
}

/// A model that represents a group of `ToolbarItem`s which can be placed in
/// the toolbar or navigation bar.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ToolbarItemGroup<Content> : ToolbarContent where Content : View {

    /// Creates a toolbar item group with a specified placement and content.
    ///
    /// - Parameters:
    ///  - placement: Which section of the toolbar all of its vended
    ///    `ToolbarItem`s should be placed in.
    ///  - content: The content of the group. Each view specified in the
    ///    `ViewBuilder` will be given its own `ToolbarItem` in the toolbar.
    public init(placement: ToolbarItemPlacement = .automatic, @ViewBuilder content: () -> Content)

    /// The type of content representing the body of this toolbar content.
    public typealias Body = Never
}

/// A structure which defines the placement of a toolbar item.
///
/// There are two types of placements:
/// - Semantic placements, such as `.principal` and `.navigation`,
///   which denote the intent of the item being added.
///   SwiftUI will determine the appropriate placement for the item
///   based on this intent, as well as the current platform.
/// - Positional placements, such as `.navigationBarLeading`,
///   which denote a precise placement for the item,
///   usually for a particular platform.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ToolbarItemPlacement {

    /// The item is placed automatically, depending on many factors including
    /// the platform, size class, or presence of other items.
    ///
    /// On macOS and Mac Catalyst, items are placed in the current toolbar
    /// section in order of leading to trailing. On watchOS, only the first
    /// item will appear, pinned beneath the navigation bar.
    ///
    /// On iOS, iPadOS and tvOS, items are placed in the trailing position of
    /// the navigation bar.
    ///
    /// In compact horizontal size classes, both the leading and the trailing
    /// positions of the navigation bar are limited to a single item each.
    public static let automatic: ToolbarItemPlacement

    /// The item is placed in the principal item section.
    ///
    /// Principal actions receive prominent placement.
    /// As an example, the location field for a web browser would be
    /// considered a principal item.
    ///
    /// On macOS and Mac Catalyst, the principal item will be placed in the
    /// center of the toolbar.
    ///
    /// On iOS, iPadOS, and tvOS, the principal item will be placed in
    /// the center of the navigation bar. This item will take precendent over
    /// a title specified through `.navigationTitle()`.
    @available(watchOS, unavailable)
    public static let principal: ToolbarItemPlacement

    /// The item represents a navigation action.
    ///
    /// Navigation actions allow the user to move between contexts.
    /// For example, the forward and back buttons of a web browser
    /// are considered navigation actions.
    ///
    /// On macOS and Mac Catalyst, navigation items will be placed in the
    /// leading edge of the toolbar ahead of the inline title if that is
    /// present in the toolbar.
    ///
    /// On iOS, iPadOS, and tvOS, navigation items will appear in the leading
    /// edge of the navigation bar. If a system navigation item like a back
    /// button is present in a compact width, they will instead appear in
    /// the .primaryAction placement.
    @available(watchOS, unavailable)
    public static let navigation: ToolbarItemPlacement

    /// The item represents a primary action.
    ///
    /// A primary action is considered to be a more frequently used action
    /// for the current context. For example, a button which allows the user
    /// to compose a new message in a chat application.
    ///
    /// On macOS and Mac Catalyst, the primary action is considered to be the
    /// leading edge of the toolbar.
    ///
    /// On iOS, iPadOS and tvOS, the primary action is considered to be
    /// the trailing edge of the navigation bar.
    ///
    /// On watchOS, the primary action is placed beneath the navigation
    /// bar and revealed by scrolling.
    public static let primaryAction: ToolbarItemPlacement

    /// The item represents a change in status for the current context.
    ///
    /// Status items are informational in nature,
    /// and do not represent an action that can be taken by the user.
    /// For example, a message indicating the last time the server has been
    /// checked for new messages.
    ///
    /// On macOS and Mac Catalyst, status items will be placed in the center
    /// of the toolbar.
    ///
    /// On iOS and iPadOS, status items will be placed in the center of the
    /// bottom toolbar.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public static let status: ToolbarItemPlacement

    /// The item represents a confirmation action for a modal interface.
    ///
    /// Confirmation actions are used to receive user confirmation of a
    /// particular action. An example of a confirmation action would be
    /// an action with the label "Add" to add a new event to the calendar.
    ///
    /// On macOS and Mac Catalyst, confirmationAction items will be placed
    /// on the trailing edge in the trailing-most position of the sheet
    /// and gain the apps accent color as a background color.
    ///
    /// On iOS, iPadOS, and tvOS, confirmationAction items will be placed in
    /// the same location as a `.primaryAction` placement.
    ///
    /// On watchOS, confirmationAction items will be placed in the trailing
    /// edge of the navigation bar.
    public static let confirmationAction: ToolbarItemPlacement

    /// The item represents a cancellation action for a modal interface.
    ///
    /// Cancellation actions can be used to dismiss the modal interface
    /// without taking any action, usually via a 'Cancel' button.
    ///
    /// On macOS and Mac Catalyst, cancellationAction items will be placed
    /// on the trailing edge of the sheet but be placed before any
    /// confirmationAction items.
    ///
    /// On iOS, iPadOS, tvOS and watchOS, cancellationAction items will
    /// be placed on the leading edge of the navigation bar.
    public static let cancellationAction: ToolbarItemPlacement

    /// The item represents a destructive action for a modal interface.
    ///
    /// Destructive actions are used represent the opposite of a
    /// confirmational action. For example, a button labeled 'Don't Save',
    /// which declines to save the current document before quitting.
    ///
    /// On macOS and Mac Catalyst, destructiveAction items will be placed in
    /// the leading edge of the sheet and will be given a special appearance
    /// to caution against accidental use.
    ///
    /// On iOS, tvOS and watchOS, destructiveAction items will be placed in the
    /// trailing edge of the navigation bar.
    public static let destructiveAction: ToolbarItemPlacement

    /// The item is placed in the leading edge of the navigation bar. Applies
    /// to iOS, iPadOS, tvOS, and Mac Catalyst.
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public static let navigationBarLeading: ToolbarItemPlacement

    /// The item is placed in the trailing edge of the navigation bar. Applies
    /// to iOS, iPadOS, tvOS, and Mac Catalyst.
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public static let navigationBarTrailing: ToolbarItemPlacement

    /// The item is placed in the bottom toolbar. Applies to iOS, iPadOS, and
    /// Mac Catalyst.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public static let bottomBar: ToolbarItemPlacement
}

/// Conforming types represent items that can be placed in various locations
/// in a customizable toolbar.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol CustomizableToolbarContent : ToolbarContent where Self.Body : CustomizableToolbarContent {
}


@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {

    /// Populates the toolbar or navigation bar with items
    /// whose content is the specified views.
    ///
    /// - Parameter content: The views representing the content of the toolbar.
    public func toolbar<Content>(@ViewBuilder content: () -> Content) -> some View where Content : View


    /// Populates the toolbar or navigation bar with the specified items.
    ///
    /// - Parameter items: The items representing the content of the toolbar.
    public func toolbar<Content>(@ToolbarContentBuilder content: () -> Content) -> some View where Content : ToolbarContent


    /// Populates the toolbar or navigation bar with the specified items,
    /// allowing for user customization.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for this toolbar.
    ///   - content: The content representing the content of the toolbar.
    public func toolbar<Content>(id: String, @ToolbarContentBuilder content: () -> Content) -> some View where Content : CustomizableToolbarContent

}
