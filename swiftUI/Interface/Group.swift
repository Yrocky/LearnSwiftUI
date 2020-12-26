//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// An affordance for grouping view content.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Group<Content> {

    /// The type of content representing the body of this toolbar content.
    public typealias Body = Never
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Group : ToolbarContent where Content : ToolbarContent {

    public init(@ToolbarContentBuilder content: () -> Content)
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Group : CustomizableToolbarContent where Content : CustomizableToolbarContent {

    public init(@ToolbarContentBuilder content: () -> Content)
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Group : Scene where Content : Scene {

    @inlinable public init(@SceneBuilder content: () -> Content)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Group : View where Content : View {

    @inlinable public init(@ViewBuilder content: () -> Content)
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension Group : Commands where Content : Commands {

    @inlinable public init(@CommandsBuilder content: () -> Content)
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Composites this view's contents into an offscreen image before final
    /// display.
    ///
    /// The `drawingGroup(opaque:colorMode:)` modifier flattens a subtree of
    /// views into a single view before rendering it.
    ///
    /// In the example below, the contents of the view are composited to a
    /// single bitmap; the bitmap is then displayed in place of the view:
    ///
    ///     VStack {
    ///         ZStack {
    ///             Text("DrawingGroup")
    ///                 .foregroundColor(.black)
    ///                 .padding(20)
    ///                 .background(Color.red)
    ///             Text("DrawingGroup")
    ///                 .blur(radius: 2)
    ///         }
    ///         .font(.largeTitle)
    ///         .compositingGroup()
    ///         .opacity(1.0)
    ///     }
    ///      .background(Color.white)
    ///      .drawingGroup()
    ///
    /// > Note: Views backed by native platform views may not render into the
    ///   image. Instead, they log a warning and display a placeholder image to
    ///   highlight the error.
    ///
    /// ![A screenshot showing the effects on several stacks configured as a
    /// drawing group.](SwiftUI-View-drawingGroup.png)
    ///
    /// - Parameters:
    ///   - opaque: A Boolean value that indicates whether the image is opaque.
    ///     The default is `false`; if set to `true`, the alpha channel of the
    ///     image must be `1`.
    ///   - colorMode: One of the working color space and storage formats
    ///     defined in ``ColorRenderingMode``. The default is
    ///     ``ColorRenderingMode/nonLinear``.
    ///
    /// - Returns: A view that composites this view's contents into an offscreen
    ///   image before display.
    public func drawingGroup(opaque: Bool = false, colorMode: ColorRenderingMode = .nonLinear) -> some View

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Wraps this view in a compositing group.
    ///
    /// A compositing group makes compositing effects in this view's ancestor
    /// views, such as opacity and the blend mode, take effect before this view
    /// is rendered.
    ///
    /// Use `compositingGroup()` to apply effects to a parent view before
    /// applying effects to this view.
    ///
    /// In the example below the `compositingGroup()` modifier separates the
    /// application of effects into stages. It applies the ``View/opacity(_:)``
    /// effect to the VStack before the `blur(radius:)` effect is applied to the
    /// views inside the enclosed ``ZStack``. This limits the scope of the
    /// opacity change to the outermost view.
    ///
    ///     VStack {
    ///         ZStack {
    ///             Text("CompositingGroup")
    ///                 .foregroundColor(.black)
    ///                 .padding(20)
    ///                 .background(Color.red)
    ///             Text("CompositingGroup")
    ///                 .blur(radius: 2)
    ///         }
    ///         .font(.largeTitle)
    ///         .compositingGroup()
    ///         .opacity(0.9)
    ///     }
    ///
    /// ![A view showing the effect of the compositingGroup modifier in applying
    /// compositing effects to parent views before child views are
    /// rendered.](SwiftUI-View-compositingGroup.png)
    ///
    /// - Returns: A view that wraps this view in a compositing group.
    @inlinable public func compositingGroup() -> some View

}

/// The working color space for color-compositing operations.
///
/// Each color space guarantees to preserve a particular range of color values.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum ColorRenderingMode {

    /// The non-linear sRGB working color space, with color component values
    /// outside the range `[0, 1]` producing undefined results.
    ///
    /// This color space is gamma corrected.
    case nonLinear

    /// The linear sRGB working color space, with color component values outside
    /// the range `[0, 1]` producing undefined results.
    ///
    /// This color space isn't gamma corrected.
    case linear

    /// The linear sRGB working color space, with color component values outside
    /// the range `[0, 1]` preserved.
    ///
    /// This color space isn't gamma corrected.
    case extendedLinear

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: ColorRenderingMode, b: ColorRenderingMode) -> Bool

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    public func hash(into hasher: inout Hasher)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension ColorRenderingMode : Equatable {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension ColorRenderingMode : Hashable {
}
