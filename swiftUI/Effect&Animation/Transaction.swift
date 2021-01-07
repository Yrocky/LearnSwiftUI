//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation

/// The context of the current state-processing update.
///
/// Use a transaction to pass an animation between views in a view hierarchy.
///
/// The root transaction for a state change comes from the binding that changed,
/// plus any global values set by calling ``withTransaction(_:_:)`` or
/// ``withAnimation(_:_:)``.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Transaction {

    /// Creates a transaction.
    @inlinable public init()
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Transaction {

    /// Creates a transaction and assigns its animation property.
    ///
    /// - Parameter animation: The animation to perform when the current state
    ///   changes.
    public init(animation: Animation?)

    /// The animation, if any, associated with the current state change.
    public var animation: Animation?

    /// A Boolean value that indicates whether views should disable animations.
    ///
    /// This value is `true` during the initial phase of a two-part transition
    /// update, to prevent ``View/animation(_:)`` from inserting new animations
    /// into the transaction.
    public var disablesAnimations: Bool
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Transaction {

    /// A Boolean value that indicates whether the transaction originated from
    /// an action that produces a sequence of values.
    ///
    /// This value is `true` if a continuous action created the transaction, and
    /// is `false` otherwise. Continuous actions include things like dragging a
    /// slider or pressing and holding a stepper, as opposed to tapping a
    /// button.
    public var isContinuous: Bool
}


/// A type-erased transition.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct AnyTransition {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    public static func offset(_ offset: CGSize) -> AnyTransition

    public static func offset(x: CGFloat = 0, y: CGFloat = 0) -> AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    public static var scale: AnyTransition { get }

    public static func scale(scale: CGFloat, anchor: UnitPoint = .center) -> AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// A transition from transparent to opaque on insertion, and from opaque to
    /// transparent on removal.
    public static let opacity: AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// A transition that inserts by moving in from the leading edge, and
    /// removes by moving out towards the trailing edge.
    ///
    /// - SeeAlso: `AnyTransition.move(edge:)`
    public static var slide: AnyTransition { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// Combines this transition with another, returning a new transition that
    /// is the result of both transitions being applied.
    public func combined(with other: AnyTransition) -> AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// Returns a transition defined between an active modifier and an identity
    /// modifier.
    public static func modifier<E>(active: E, identity: E) -> AnyTransition where E : ViewModifier
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// Attaches an animation to this transition.
    public func animation(_ animation: Animation?) -> AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// A transition that returns the input view, unmodified, as the output
    /// view.
    public static let identity: AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// Returns a transition that moves the view away, towards the specified
    /// edge of the view.
    public static func move(edge: Edge) -> AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension AnyTransition {

    /// Provides a composite transition that uses a different transition for
    /// insertion versus removal.
    public static func asymmetric(insertion: AnyTransition, removal: AnyTransition) -> AnyTransition
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Applies the given transaction mutation function to all transactions used
    /// within the view.
    ///
    /// Use this modifier on leaf views rather than container views. The
    /// transformation applies to all child views within this view; calling
    /// `transaction(_:)` on a container view can lead to unbounded scope.
    ///
    /// - Parameter transform: The transformation to apply to transactions
    ///   within this view.
    ///
    /// - Returns: A view that wraps this view and applies `transformation` to
    ///   all transactions used within the view.
    @inlinable public func transaction(_ transform: @escaping (inout Transaction) -> Void) -> some View

}

/// Executes a closure with the specified transaction and returns the result.
///
/// - Parameters:
///   - transaction : An instance of a transaction, set as the thread's current
///     transaction.
///   - body: A closure to execute.
///
/// - Returns: The result of executing the closure with the specified
///   transaction.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public func withTransaction<Result>(_ transaction: Transaction, _ body: () throws -> Result) rethrows -> Result



@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Associates a transition with the view.
    @inlinable public func transition(_ t: AnyTransition) -> some View

}
