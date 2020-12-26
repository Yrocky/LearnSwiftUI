//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A stylized view with an optional label that is associated with a logical
/// grouping of content.
@available(iOS 14.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct GroupBox<Label, Content> : View where Label : View, Content : View {

    public init(label: Label, @ViewBuilder content: () -> Content)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 14.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension GroupBox where Label == GroupBoxStyleConfiguration.Label, Content == GroupBoxStyleConfiguration.Content {

    /// Creates an instance representing the configuration of a `GroupBoxStyle`.
    public init(_ configuration: GroupBoxStyleConfiguration)
}

@available(iOS 14.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension GroupBox where Label == EmptyView {

    public init(@ViewBuilder content: () -> Content)
}

/// Defines the implementation of all `GroupBox` instances within a view
/// hierarchy.
///
/// To configure the current `GroupBoxStyle` for a view hiearchy, use the
/// `.groupBoxStyle()` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol GroupBoxStyle {

    /// A `View` representing the body of a `GroupBox`.
    associatedtype Body : View

    /// Creates a `View` representing the body of a `GroupBox`.
    ///
    /// - Parameter configuration: The properties of the group box instance being
    ///   created.
    ///
    /// This method will be called for each instance of `GroupBox` created within
    /// a view hierarchy where this style is the current `GroupBoxStyle`.
    func makeBody(configuration: Self.Configuration) -> Self.Body

    /// The properties of a `GroupBox` instance being created.
    typealias Configuration = GroupBoxStyleConfiguration
}

/// The properties of a `GroupBox` instance being created.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct GroupBoxStyleConfiguration {

    /// A type-erased label of a `GroupBox`.
    public struct Label : View {

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public typealias Body = Never
    }

    /// A type-erased content of a `GroupBox`.
    public struct Content : View {

        /// The type of view representing the body of this view.
        ///
        /// When you create a custom view, Swift infers this type from your
        /// implementation of the required `body` property.
        public typealias Body = Never
    }

    /// A view that describes the `GroupBox`.
    public let label: GroupBoxStyleConfiguration.Label

    /// A view that represents the content of the `GroupBox`.
    public let content: GroupBoxStyleConfiguration.Content
}


/// The default `GroupBoxStyle`.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DefaultGroupBoxStyle : GroupBoxStyle {

    public init()

    /// Creates a `View` representing the body of a `GroupBox`.
    ///
    /// - Parameter configuration: The properties of the group box instance being
    ///   created.
    ///
    /// This method will be called for each instance of `GroupBox` created within
    /// a view hierarchy where this style is the current `GroupBoxStyle`.
    public func makeBody(configuration: DefaultGroupBoxStyle.Configuration) -> some View


    /// A `View` representing the body of a `GroupBox`.
    public typealias Body = some View
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Sets the style for group boxes within this view.
    ///
    /// - Parameter style: The style to apply to boxes within this view.
    public func groupBoxStyle<S>(_ style: S) -> some View where S : GroupBoxStyle

}
