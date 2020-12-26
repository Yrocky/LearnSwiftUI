//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A container for grouping controls used for data entry, such as in settings
/// or inspectors.
///
/// SwiftUI renders forms in a manner appropriate for the platform. For example,
/// on iOS, forms appear as grouped lists. Use ``Section`` to group different
/// parts of a form's content.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Form<Content> : View where Content : View {

    public init(@ViewBuilder content: () -> Content)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}
