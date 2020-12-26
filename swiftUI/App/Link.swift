//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation

/// A control for navigating to a URL.
///
/// You create a link by providing a destination URL and a title. The title
/// tells the user the purpose of the link, which can be either a string, or a
/// title key that returns a localized string used to construct a label
/// displayed to the user in your app's UI. The example below creates a link to
/// `example.com` and displays the title string you provide as a
/// link-styled view in your app:
///
///     Link("View Our Terms of Service",
///           destination: URL(string: "https://www.example.com/TOS.html")!)
///
/// When a user taps or clicks a `Link`, where the URL opens depends on the
/// contents of the URL. For example, a Universal Link will open in the
/// associated app, if possible, but otherwise in the user's default web
/// browser.
///
/// As with other views, you can style links using standard view modifiers
/// depending on the view type of the link's label. For example, a ``Text``
/// label could be modified with a custom ``View/font(_:)`` or
/// ``View/foregroundColor(_:)`` to customize the appearance of the link in
/// your app's UI.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct Link<Label> : View where Label : View {

    /// Creates a control, consisting of a URL and a label, used to navigate
    /// to the given URL.
    ///
    /// - Parameters:
    ///     - destination: The URL for the link.
    ///     - label: A view that describes the destination of URL.
    public init(destination: URL, @ViewBuilder label: () -> Label)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Link where Label == Text {

    /// Creates a control, consisting of a URL and a title key, used to
    /// navigate to a URL.
    ///
    /// Use ``Link`` to create a control that your app uses to navigate to a
    /// URL that you provide. The example below creates a link to
    /// `example.com` and uses `Visit Example Co` as the title key to
    /// generate a link-styled view in your app:
    ///
    ///     Link("Visit Example Co",
    ///           destination: URL(string: "https://www.example.com/")!)
    ///
    /// - Parameters:
    ///     - titleKey: The key for the localized title that describes the
    ///       purpose of this link.
    ///     - destination: The URL for the link.
    public init(_ titleKey: LocalizedStringKey, destination: URL)

    /// Creates a control, consisting of a URL and a title string, used to
    /// navigate to a URL.
    ///
    /// Use ``Link`` to create a control that your app uses to navigate to a
    /// URL that you provide. The example below creates a link to
    /// `example.com` and displays the title string you provide as a
    /// link-styled view in your app:
    ///
    ///     func marketingLink(_ callToAction: String) -> Link {
    ///         Link(callToAction,
    ///             destination: URL(string: "https://www.example.com/")!)
    ///     }
    ///
    /// - Parameters:
    ///     - title: A text string used as the title for describing the
    ///       underlying `destination` URL.
    ///     - destination: The URL for the link.
    public init<S>(_ title: S, destination: URL) where S : StringProtocol
}


@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {

    /// Advertises a user activity type.
    ///
    /// You can use `userActivity(_:isActive:_:)` to start, stop, or modify the
    /// advertisement of a specific type of user activity.
    ///
    /// The scope of the activity applies only to the scene or window the
    /// view is in.
    ///
    /// - Parameters:
    ///   - activityType: The type of activity to advertise.
    ///   - isActive: When `false`, avoids advertising the activity. Defaults
    ///     to `true`.
    ///   - update: A function that modifies the passed-in activity for
    ///     advertisement.
    public func userActivity(_ activityType: String, isActive: Bool = true, _ update: @escaping (NSUserActivity) -> ()) -> some View


    /// Advertises a user activity type.
    ///
    /// The scope of the activity applies only to the scene or window the
    /// view is in.
    ///
    /// - Parameters:
    ///   - activityType: The type of activity to advertise.
    ///   - element: If the element is `nil`, the handler will not be
    ///     associated with the activity (and if there are no handlers, no
    ///     activity is advertised). The method passes the non-`nil` element to
    ///     the handler as a convenience so the handlers don't all need to
    ///     implement an early exit with
    ///     `guard element = element else { return }`.
    ///    - update: A function that modifies the passed-in activity for
    ///    advertisement.
    public func userActivity<P>(_ activityType: String, element: P?, _ update: @escaping (P, NSUserActivity) -> ()) -> some View


    /// Registers a handler to invoke when the view receives the specified
    /// activity type for the scene or window the view is in.
    ///
    /// - Parameters:
    ///   - activityType: The type of activity to handle.
    ///   - action: A function to call that takes a
    ///     <doc://com.apple.documentation/documentation/Foundation/NSUserActivity>
    ///     object as its parameter
    ///     when delivering the activity to the scene or window the view is in.
    public func onContinueUserActivity(_ activityType: String, perform action: @escaping (NSUserActivity) -> ()) -> some View


    /// Registers a handler to invoke when the view receives a url for the
    /// scene or window the view is in.
    ///
    /// > Note: This method handles the reception of Universal Links,
    ///   rather than a
    ///   <doc://com.apple.documentation/documentation/Foundation/NSUserActivity>.
    ///
    /// - Parameter action: A function that takes a
    ///  <doc://com.apple.documentation/documentation/Foundation/URL>
    ///  object as its parameter when delivering the URL to the scene or window
    ///  the view is in.
    public func onOpenURL(perform action: @escaping (URL) -> ()) -> some View

}
