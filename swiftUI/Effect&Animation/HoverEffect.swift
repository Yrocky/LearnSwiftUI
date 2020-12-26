//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// An effect applied when the pointer hovers over a view.
@available(iOS 13.4, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct HoverEffect {

    /// An effect  that attempts to determine the effect automatically.
    /// This is the default effect.
    public static let automatic: HoverEffect

    /// An effect  that morphs the pointer into a platter behind the view
    /// and shows a light source indicating position.
    public static let highlight: HoverEffect

    /// An effect that slides the pointer under the view and disappears as the
    /// view scales up and gains a shadow.
    public static let lift: HoverEffect
}
