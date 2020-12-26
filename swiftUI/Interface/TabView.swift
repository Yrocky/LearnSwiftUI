//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A view that switches between multiple child views using interactive user
/// interface elements.
///
/// To create a user interface with tabs, place views in a `TabView` and apply
/// the ``View/tabItem(_:)`` modifier to the contents of each tab. The following
/// creates a tab view with three tabs:
///
///     TabView {
///         Text("The First Tab")
///             .tabItem {
///                 Image(systemName: "1.square.fill")
///                 Text("First")
///             }
///         Text("Another Tab")
///             .tabItem {
///                 Image(systemName: "2.square.fill")
///                 Text("Second")
///             }
///         Text("The Last Tab")
///             .tabItem {
///                 Image(systemName: "3.square.fill")
///                 Text("Third")
///             }
///     }
///     .font(.headline)
///
/// Tab views only support tab items of type ``Text``, ``Image``, or an image
/// followed by text. Passing any other type of view results in a visible but
/// empty tab item.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
public struct TabView<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View {

    /// Creates an instance that selects from content associated with
    /// `Selection` values.
    public init(selection: Binding<SelectionValue>?, @ViewBuilder content: () -> Content)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
extension TabView where SelectionValue == Int {

    public init(@ViewBuilder content: () -> Content)
}


/// A specification for the appearance and interaction of a `TabView`.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol TabViewStyle {
}


/// The default `TabView` style.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
public struct DefaultTabViewStyle : TabViewStyle {

    public init()
}

/// A `TabViewStyle` that implements a paged scrolling `TabView`.
@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
@available(macOS, unavailable)
public struct PageTabViewStyle : TabViewStyle {

    /// A style for displaying the page index view
    public struct IndexDisplayMode {

        /// Displays an index view when there are more than one page
        public static let automatic: PageTabViewStyle.IndexDisplayMode

        /// Always display an index view regardless of page count
        @available(watchOS, unavailable)
        public static let always: PageTabViewStyle.IndexDisplayMode

        /// Never display an index view
        @available(watchOS, unavailable)
        public static let never: PageTabViewStyle.IndexDisplayMode
    }

    /// Creates a new `PageTabViewStyle` with an index display mode
    public init(indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic)
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
extension View {

    /// Sets the tab bar item associated with this view.
    ///
    /// Use `tabItem(_:)` to configure a view as a tab bar item in a
    /// ``TabView``. The example below adds two views as tabs in a ``TabView``:
    ///
    ///     struct View1: View {
    ///         var body: some View {
    ///             Text("View 1")
    ///         }
    ///     }
    ///
    ///     struct View2: View {
    ///         var body: some View {
    ///             Text("View 2")
    ///         }
    ///     }
    ///
    ///     struct TabItem: View {
    ///         var body: some View {
    ///             TabView {
    ///                 View1()
    ///                     .tabItem {
    ///                         Image(systemName: "list.dash")
    ///                         Text("Menu")
    ///                     }
    ///
    ///                 View2()
    ///                     .tabItem {
    ///                         Image(systemName: "square.and.pencil")
    ///                         Text("Order")
    ///                     }
    ///             }
    ///         }
    ///     }
    ///
    /// ![A screenshot of a two views configured as tab items in a tab
    /// view.](SwiftUI-View-tabItem.png)
    ///
    /// - Parameter label: The tab bar item to associate with this view.
    public func tabItem<V>(@ViewBuilder _ label: () -> V) -> some View where V : View

}


@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {

    /// Sets the style for the tab view within the the current environment.
    ///
    /// - Parameter style: The style to apply to this tab view.
    public func tabViewStyle<S>(_ style: S) -> some View where S : TabViewStyle

}
