//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation



/// An opaque value derived from an anchor source and a particular view.
///
/// You can convert the anchor to a `Value` in the coordinate space of a target
/// view by using a ``GeometryProxy`` to specify the target view.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Anchor<Value> {

    /// A type-erased geometry value that produces an anchored value of a given
    /// type.
    ///
    /// SwiftUI passes anchored geometry values around the view tree via
    /// preference keys. It then converts them back into the local coordinate
    /// space using a ``GeometryProxy`` value.
    @frozen public struct Source {
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Anchor.Source where Value == CGRect {

    /// Returns an anchor source rect defined by `r` in the current view.
    public static func rect(_ r: CGRect) -> Anchor<Value>.Source

    /// An anchor source rect defined as the entire bounding rect of the current
    /// view.
    public static var bounds: Anchor<CGRect>.Source { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Anchor.Source where Value == CGPoint {

    public static func point(_ p: CGPoint) -> Anchor<Value>.Source

    public static func unitPoint(_ p: UnitPoint) -> Anchor<Value>.Source

    public static var topLeading: Anchor<CGPoint>.Source { get }

    public static var top: Anchor<CGPoint>.Source { get }

    public static var topTrailing: Anchor<CGPoint>.Source { get }

    public static var leading: Anchor<CGPoint>.Source { get }

    public static var center: Anchor<CGPoint>.Source { get }

    public static var trailing: Anchor<CGPoint>.Source { get }

    public static var bottomLeading: Anchor<CGPoint>.Source { get }

    public static var bottom: Anchor<CGPoint>.Source { get }

    public static var bottomTrailing: Anchor<CGPoint>.Source { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Anchor.Source {

    public init<T>(_ array: [Anchor<T>.Source]) where Value == [T]
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Anchor.Source {

    public init<T>(_ anchor: Anchor<T>.Source?) where Value == T?
}


/// An attachment anchor for a popover.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum PopoverAttachmentAnchor {

    case rect(Anchor<CGRect>.Source)

    case point(UnitPoint)
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    @inlinable public func transformAnchorPreference<A, K>(key _: K.Type = K.self, value: Anchor<A>.Source, transform: @escaping (inout K.Value, Anchor<A>) -> Void) -> some View where K : PreferenceKey

}
