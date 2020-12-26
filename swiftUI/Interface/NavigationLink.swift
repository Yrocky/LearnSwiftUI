//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A view that controls a navigation presentation.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct NavigationLink<Label, Destination> : View where Label : View, Destination : View {

    /// Creates an instance that presents `destination`.
    public init(destination: Destination, @ViewBuilder label: () -> Label)

    /// Creates an instance that presents `destination` when active.
    public init(destination: Destination, isActive: Binding<Bool>, @ViewBuilder label: () -> Label)

    /// Creates an instance that presents `destination` when `selection` is set
    /// to `tag`.
    public init<V>(destination: Destination, tag: V, selection: Binding<V?>, @ViewBuilder label: () -> Label) where V : Hashable

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension NavigationLink where Label == Text {

    /// Creates an instance that presents `destination`, with a `Text` label
    /// generated from a title string.
    public init(_ titleKey: LocalizedStringKey, destination: Destination)

    /// Creates an instance that presents `destination`, with a `Text` label
    /// generated from a title string.
    public init<S>(_ title: S, destination: Destination) where S : StringProtocol

    /// Creates an instance that presents `destination` when active, with a
    /// `Text` label generated from a title string.
    public init(_ titleKey: LocalizedStringKey, destination: Destination, isActive: Binding<Bool>)

    /// Creates an instance that presents `destination` when active, with a
    /// `Text` label generated from a title string.
    public init<S>(_ title: S, destination: Destination, isActive: Binding<Bool>) where S : StringProtocol

    /// Creates an instance that presents `destination` when `selection` is set
    /// to `tag`, with a `Text` label generated from a title string.
    public init<V>(_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) where V : Hashable

    /// Creates an instance that presents `destination` when `selection` is set
    /// to `tag`, with a `Text` label generated from a title string.
    public init<S, V>(_ title: S, destination: Destination, tag: V, selection: Binding<V?>) where S : StringProtocol, V : Hashable
}

@available(iOS 13.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension NavigationLink {

    /// Sets whether or not the `NavigationLink` should present its destination
    /// as the "detail" component of the containing `NavigationView`.
    ///
    /// If not set, defaults to `true`.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func isDetailLink(_ isDetailLink: Bool) -> some View

}
