//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// Defines the implementation of all `IndexView` instances within a view
/// hierarchy.
///
/// To configure the current `IndexViewStyle` for a view hierarchy, use the
/// `.indexViewStyle()` modifier.
@available(iOS 14.0, tvOS 14.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
public protocol IndexViewStyle {
}


@available(iOS 14.0, tvOS 14.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Sets the style for the index view within the current environment.
    ///
    /// - Parameter style: The style to apply to this view.
    public func indexViewStyle<S>(_ style: S) -> some View where S : IndexViewStyle

}

/// An index view style that places a page index view over its content.
@available(iOS 14.0, tvOS 14.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
public struct PageIndexViewStyle : IndexViewStyle {

    /// The background style for the page index view.
    public struct BackgroundDisplayMode {

        /// Background will use the default for the platform.
        public static let automatic: PageIndexViewStyle.BackgroundDisplayMode

        /// Background is only shown while the index view is interacted with.
        public static let interactive: PageIndexViewStyle.BackgroundDisplayMode

        /// Background is always displayed behind the page index view.
        public static let always: PageIndexViewStyle.BackgroundDisplayMode

        /// Background is never displayed behind the page index view.
        public static let never: PageIndexViewStyle.BackgroundDisplayMode
    }

    /// Creates a page index view style.
    ///
    /// - Parameter backgroundDisplayMode: The display mode of the background of any
    /// page index views receiving this style
    public init(backgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .automatic)
}

