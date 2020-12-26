//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A view for presenting a stack of views representing a visible path in a
/// navigation hierarchy.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
public struct NavigationView<Content> : View where Content : View {

    public init(@ViewBuilder content: () -> Content)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never
}

/// A specification for the appearance and interaction of a `NavigationView`.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
public protocol NavigationViewStyle {
}


/// A navigation view style represented by a view stack that only shows a
/// single top view at a time.
@available(iOS 13.0, tvOS 13.0, watchOS 7.0, *)
@available(macOS, unavailable)
public struct StackNavigationViewStyle : NavigationViewStyle {

    public init()
}

/// The default navigation view style.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
public struct DefaultNavigationViewStyle : NavigationViewStyle {

    public init()
}


/// A navigation view style represented by a primary view stack that
/// navigates to a detail view.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
@available(watchOS, unavailable)
public struct DoubleColumnNavigationViewStyle : NavigationViewStyle {

    public init()
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
extension View {

    /// Sets the style for navigation views within this view.
    @available(watchOS 7.0, *)
    public func navigationViewStyle<S>(_ style: S) -> some View where S : NavigationViewStyle

}


@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(macOS, unavailable)
extension View {

    /// Hides the navigation bar for this view.
    ///
    /// Use `navigationBarHidden(_:)` to hide the navigation bar. This modifier
    /// only takes effect when this view is inside of and visible within a
    /// ``NavigationView``.
    ///
    /// - Parameter hidden: A Boolean value that indicates whether to hide the
    ///   navigation bar.
    @available(macOS, unavailable)
    public func navigationBarHidden(_ hidden: Bool) -> some View


    /// Sets the title in the navigation bar for this view.
    ///
    /// Use `navigationBarTitle(_:)` to set the title of the navigation bar.
    /// This modifier only takes effect when this view is inside of and visible
    /// within a ``NavigationView``.
    ///
    /// The example below shows setting the title of the navigation bar using a
    /// ``Text`` view:
    ///
    ///     struct FlavorView: View {
    ///         let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip",
    ///                      "Pistachio"]
    ///         var body: some View {
    ///             NavigationView {
    ///                 List(items, id: \.self) {
    ///                     Text($0)
    ///                 }
    ///                 .navigationBarTitle(Text("Today's Flavors"))
    ///             }
    ///         }
    ///     }
    ///
    /// ![A screenshot showing the title of a navigation bar configured using a
    /// text view.](SwiftUI-navigationBarTitle-Text.png)
    ///
    /// - Parameter title: A description of this view to display in the
    ///   navigation bar.
    @available(iOS, introduced: 13.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    @available(macOS, unavailable)
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    @available(watchOS, introduced: 6.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    public func navigationBarTitle(_ title: Text) -> some View


    /// Sets the title of this view's navigation bar with a localized string.
    ///
    /// Use `navigationBarTitle(_:)` to set the title of the navigation bar
    /// using a ``LocalizedStringKey`` that will be used to search for a
    /// matching localized string in the application's localizable strings
    /// assets.
    ///
    /// This modifier only takes effect when this view is inside of and visible
    /// within a ``NavigationView``.
    ///
    /// In the example below, a string constant is used to access a
    /// ``LocalizedStringKey`` that will be resolved at run time to provide a
    /// title for the navigation bar. If the localization key cannot be
    /// resolved, the text of the key name will be used as the title text.
    ///
    ///     struct FlavorView: View {
    ///         let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip",
    ///                      "Pistachio"]
    ///         var body: some View {
    ///             NavigationView {
    ///                 List(items, id: \.self) {
    ///                     Text($0)
    ///                 }
    ///                 .navigationBarTitle("Today's Flavors")
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameter titleKey: A key to a localized description of this view to
    ///   display in the navigation bar.
    @available(iOS, introduced: 13.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    @available(macOS, unavailable)
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    @available(watchOS, introduced: 6.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    public func navigationBarTitle(_ titleKey: LocalizedStringKey) -> some View


    /// Sets the title of this view's navigation bar with a string.
    ///
    /// Use `navigationBarTitle(_:)` to set the title of the navigation bar
    /// using a `String`. This modifier only takes effect when this view is
    /// inside of and visible within a ``NavigationView``.
    ///
    /// In the example below, text for the navigation bar title is provided
    /// using a string:
    ///
    ///     struct FlavorView: View {
    ///         let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip",
    ///                      "Pistachio"]
    ///         let text = "Today's Flavors"
    ///         var body: some View {
    ///             NavigationView {
    ///                 List(items, id: \.self) {
    ///                     Text($0)
    ///                 }
    ///                 .navigationBarTitle(text)
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameter title: A title for this view to display in the navigation
    ///   bar.
    @available(iOS, introduced: 13.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    @available(macOS, unavailable)
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    @available(watchOS, introduced: 6.0, deprecated: 100000.0, renamed: "navigationTitle(_:)")
    public func navigationBarTitle<S>(_ title: S) -> some View where S : StringProtocol


    /// Sets the title and display mode in the navigation bar for this view.
    ///
    /// Use `navigationBarTitle(_:displayMode:)` to set the title of the
    /// navigation bar for this view and specify a display mode for the title
    /// from one of the ``NavigationBarItem/TitleDisplayMode`` styles. This
    /// modifier only takes effect when this view is inside of and visible
    /// within a ``NavigationView``.
    ///
    /// In the example below, text for the navigation bar title is provided
    /// using a ``Text`` view. The navigation bar title's
    /// ``NavigationBarItem/TitleDisplayMode`` is set to `.inline` which places
    /// the navigation bar title in the bounds of the navigation bar.
    ///
    ///     struct FlavorView: View {
    ///        let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip",
    ///                     "Pistachio"]
    ///        var body: some View {
    ///             NavigationView {
    ///                  List(items, id: \.self) {
    ///                      Text($0)
    ///                  }
    ///                 .navigationBarTitle(Text("Today's Flavors", displayMode: .inline)
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - title: A title for this view to display in the navigation bar.
    ///   - displayMode: The style to use for displaying the navigation bar title.
    @available(iOS, introduced: 13.0, deprecated: 100000.0, message: "Use navigationTitle(_:) with navigationBarTitleDisplayMode(_:)")
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func navigationBarTitle(_ title: Text, displayMode: NavigationBarItem.TitleDisplayMode) -> some View


    /// Sets the title and display mode in the navigation bar for this view.
    ///
    /// Use `navigationBarTitle(_:displayMode:)` to set the title of the
    /// navigation bar for this view and specify a display mode for the title
    /// from one of the ``NavigationBarItem/TitleDisplayMode`` styles. This
    /// modifier only takes effect when this view is inside of and visible
    /// within a ``NavigationView``.
    ///
    /// In the example below, text for the navigation bar title is provided
    /// using a string. The navigation bar title's
    /// ``NavigationBarItem/TitleDisplayMode`` is set to `.inline` which places
    /// the navigation bar title in the bounds of the navigation bar.
    ///
    ///     struct FlavorView: View {
    ///         let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip",
    ///                      "Pistachio"]
    ///         var body: some View {
    ///             NavigationView {
    ///                  List(items, id: \.self) {
    ///                      Text($0)
    ///                  }
    ///                 .navigationBarTitle("Today's Flavors", displayMode: .inline)
    ///             }
    ///         }
    ///     }
    ///
    /// If the `titleKey` can't be found, the title uses the text of the key
    /// name instead.
    ///
    /// - Parameters:
    ///   - titleKey: A key to a localized description of this view to display
    ///     in the navigation bar.
    ///   - displayMode: The style to use for displaying the navigation bar
    ///     title.
    @available(iOS, introduced: 13.0, deprecated: 100000.0, message: "Use navigationTitle(_:) with navigationBarTitleDisplayMode(_:)")
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func navigationBarTitle(_ titleKey: LocalizedStringKey, displayMode: NavigationBarItem.TitleDisplayMode) -> some View


    /// Sets the title and display mode in the navigation bar for this view.
    ///
    /// Use `navigationBarTitle(_:, displayMode)` to set the title of the
    /// navigation bar for this view and specify a display mode for the
    /// title from one of the `NavigationBarItem.Title.DisplayMode`
    /// styles. This modifier only takes effect when this view is inside of and
    /// visible within a `NavigationView`.
    ///
    /// In the example below, `navigationBarTitle(_:, displayMode)` uses a
    /// string to provide a title for the navigation bar. Setting the title's
    /// `displaymode` to `.inline` places the navigation bar title within the
    /// bounds of the navigation bar.
    ///
    /// In the example below, text for the navigation bar title is provided using
    /// a string. The navigation bar title's `displayMode` is set to
    /// `.inline` which places the navigation bar title in the bounds of the
    /// navigation bar.
    ///
    ///     struct FlavorView: View {
    ///         let items = ["Chocolate", "Vanilla", "Strawberry", "Mint Chip",
    ///                      "Pistachio"]
    ///         let title = "Today's Flavors"
    ///         var body: some View {
    ///             NavigationView {
    ///                  List(items, id: \.self) {
    ///                      Text($0)
    ///                  }
    ///                 .navigationBarTitle(title, displayMode: .inline)
    ///             }
    ///         }
    ///     }
    ///
    /// ![A screenshot of a navigation bar, showing the title within the bounds
    ///  of the navigation bar]
    /// (SwiftUI-navigationBarTitle-stringProtocol.png)
    ///
    /// - Parameters:
    ///   - title: A title for this view to display in the navigation bar.
    ///   - displayMode: The way to display the title.
    @available(iOS, introduced: 14.0, deprecated: 100000.0, message: "Use navigationTitle(_:) with navigationBarTitleDisplayMode(_:)")
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func navigationBarTitle<S>(_ title: S, displayMode: NavigationBarItem.TitleDisplayMode) -> some View where S : StringProtocol


    /// Hides the navigation bar back button for the view.
    ///
    /// Use `navigationBarBackButtonHidden(_:)` to hide the back button for this
    /// view.
    ///
    /// This modifier only takes effect when this view is inside of and visible
    /// within a ``NavigationView``.
    ///
    /// - Parameter hidesBackButton: A Boolean value that indicates whether to
    ///   hide the back button.
    @available(macOS, unavailable)
    public func navigationBarBackButtonHidden(_ hidesBackButton: Bool) -> some View

}


@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {

    /// Configures the view's title for purposes of navigation.
    ///
    /// A view's navigation title is used to visually display
    /// the current navigation state of an interface.
    /// On iOS and watchOS, when a view is navigated to inside
    /// of a navigation view, that view's title is displayed
    /// in the navigation bar. On iPadOS, the primary destination's
    /// navigation title is reflected as the window's title in the
    /// App Switcher. Similarly on macOS, the primary destination's title
    /// is used as the window title in the titlebar, Windows menu
    /// and Mission Control.
    ///
    /// - Parameter title: The title to display.
    public func navigationTitle(_ title: Text) -> some View


    /// Configures the view's title for purposes of navigation,
    /// using a localized string.
    ///
    /// A view's navigation title is used to visually display
    /// the current navigation state of an interface.
    /// On iOS and watchOS, when a view is navigated to inside
    /// of a navigation view, that view's title is displayed
    /// in the navigation bar. On iPadOS, the primary destination's
    /// navigation title is reflected as the window's title in the
    /// App Switcher. Similarly on macOS, the primary destination's title
    /// is used as the window title in the titlebar, Windows menu
    /// and Mission Control.
    ///
    /// - Parameter titleKey: The key to a localized string to display.
    public func navigationTitle(_ titleKey: LocalizedStringKey) -> some View


    /// Configures the view's title for purposes of navigation, using a string.
    ///
    /// A view's navigation title is used to visually display
    /// the current navigation state of an interface.
    /// On iOS and watchOS, when a view is navigated to inside
    /// of a navigation view, that view's title is displayed
    /// in the navigation bar. On iPadOS, the primary destination's
    /// navigation title is reflected as the window's title in the
    /// App Switcher. Similarly on macOS, the primary destination's title
    /// is used as the window title in the titlebar, Windows menu
    /// and Mission Control.
    ///
    /// - Parameter title: The string to display.
    public func navigationTitle<S>(_ title: S) -> some View where S : StringProtocol

}
