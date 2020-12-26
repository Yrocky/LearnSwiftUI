//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation

/// A view that subscribes to a publisher with an action.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct SubscriptionView<PublisherType, Content> : View where PublisherType : Publisher, Content : View, PublisherType.Failure == Never {

    /// The content view.
    public var content: Content

    /// The `Publisher` that is being subscribed.
    public var publisher: PublisherType

    /// The `Action` executed when `publisher` emits an event.
    public var action: (PublisherType.Output) -> Void

    @inlinable public init(content: Content, publisher: PublisherType, action: @escaping (PublisherType.Output) -> Void)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never
}
