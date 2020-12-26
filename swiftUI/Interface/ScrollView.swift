//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A scrollable view.
///
/// The scroll view displays its content within the scrollable content region.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ScrollView<Content> : View where Content : View {

    /// The scroll view's content.
    public var content: Content

    /// The scrollable axes of the scroll view.
    ///
    /// The default value is ``Axis/vertical``.
    public var axes: Axis.Set

    /// A value that indicates whether the scroll view displays the scrollable
    /// component of the content offset, in a way that's suitable for the
    /// platform.
    ///
    /// The default is `true`.
    public var showsIndicators: Bool

    /// Creates a new instance that's scrollable in the direction of the given
    /// axis and can show indicators while scrolling.
    ///
    /// - Parameters:
    ///   - axes: The scroll view's scrollable axis. The default axis is the
    ///     vertical axis.
    ///   - showsIndicators: A Boolean value that indicates whether the scroll
    ///     view displays the scrollable component of the content offset, in a way
    ///     suitable for the platform. The default value for this parameter is
    ///     `true`.
    ///   - content: The view builder that creates the scrollable view.
    public init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, @ViewBuilder content: () -> Content)

    /// The content and behavior of the scroll view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

/// A proxy value allowing the scrollable views within a view hierarchy
/// to be scrolled programmatically.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ScrollViewProxy {

    /// Scans all scroll views contained by the proxy for the first
    /// with a child view with identifier `id`, and then scrolls to
    /// that view.
    ///
    /// If `anchor` is nil the container of the identified view will be
    /// scrolled the minimum amount to make the identified view wholly
    /// visible.
    ///
    /// If `anchor` is non-nil it defines the points in the identified
    /// view and the scroll view that will be aligned, e.g. `.top`
    /// aligns the top of the identified view to the top of the scroll
    /// view, `.bottom` aligns the bottom of the identified view to the
    /// bottom of the scroll view, and so on.
    ///
    public func scrollTo<ID>(_ id: ID, anchor: UnitPoint? = nil) where ID : Hashable
}

/// A view whose child is defined as a function of a `ScrollViewProxy`
/// targeting the scrollable views within the child.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@frozen public struct ScrollViewReader<Content> : View where Content : View {

    public var content: (ScrollViewProxy) -> Content

    /// Initializes with the closure `content`. The proxy passed to the
    /// closure may NOT be messaged while `content` is executing (this
    /// will cause a runtime error) but only from actions created
    /// within `content` such as gesture handlers or the `onChange()`
    /// function.
    @inlinable public init(@ViewBuilder content: @escaping (ScrollViewProxy) -> Content)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}
