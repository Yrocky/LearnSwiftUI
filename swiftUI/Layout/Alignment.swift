//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation



/// Types used to identify alignment guides.
///
/// Types conforming to `AlignmentID` have a corresponding alignment guide
/// value, typically declared as a static constant property of
/// ``HorizontalAlignment`` or ``VerticalAlignment``.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol AlignmentID {

    /// The value of the corresponding guide in the given context when not
    /// otherwise set in that context.
    static func defaultValue(in context: ViewDimensions) -> CGFloat
}


/// An alignment position along the horizontal axis.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct HorizontalAlignment : Equatable {

    /// Creates an instance with the given identifier.
    ///
    /// Each instance needs a unique identifier.
    ///
    /// - Parameter id: An identifier that uniquely identifies the horizontal
    ///   alignment.
    public init(_ id: AlignmentID.Type)

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: HorizontalAlignment, b: HorizontalAlignment) -> Bool
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension HorizontalAlignment {

    /// A guide marking the leading edge of the view.
    public static let leading: HorizontalAlignment

    /// A guide marking the horizontal center of the view.
    public static let center: HorizontalAlignment

    /// A guide marking the trailing edge of the view.
    public static let trailing: HorizontalAlignment
}



/// An alignment position along the horizontal axis.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct VerticalAlignment : Equatable {

    /// Creates an instance with the given identifier.
    ///
    /// Each instance needs a unique identifier.
    ///
    /// - Parameter id: An identifier that uniquely identifies the vertical
    ///   alignment.
    public init(_ id: AlignmentID.Type)

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: VerticalAlignment, b: VerticalAlignment) -> Bool
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension VerticalAlignment {

    /// A guide marking the top edge of the view.
    public static let top: VerticalAlignment

    /// A guide marking the vertical center of the view.
    public static let center: VerticalAlignment

    /// A guide marking the bottom edge of the view.
    public static let bottom: VerticalAlignment

    /// A guide marking the topmost text baseline view.
    public static let firstTextBaseline: VerticalAlignment

    /// A guide marking the bottom-most text baseline in a view.
    public static let lastTextBaseline: VerticalAlignment
}


/// An alignment in both axes.
///
/// The following table shows the various alignment guides next to each other.
///
/// ![A table showing the various alignment guides next to each
/// other.](SwiftUI-Alignment-table.png)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct Alignment : Equatable {

    /// The alignment on the horizontal axis.
    public var horizontal: HorizontalAlignment

    /// The alignment on the vertical axis.
    public var vertical: VerticalAlignment

    /// Creates an instance with the given horizontal and vertical alignments.
    ///
    /// - Parameters:
    ///   - horizontal: The alignment on the horizontal axis.
    ///   - vertical: The alignment on the vertical axis.
    @inlinable public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment)

    /// A guide marking the center of the view.
    public static let center: Alignment

    /// A guide marking the leading edge of the view.
    public static let leading: Alignment

    /// A guide marking the trailing edge of the view.
    public static let trailing: Alignment

    /// A guide marking the top edge of the view.
    public static let top: Alignment

    /// A guide marking the bottom edge of the view.
    public static let bottom: Alignment

    /// A guide marking the top and leading edges of the view.
    public static let topLeading: Alignment

    /// A guide marking the top and trailing edges of the view.
    public static let topTrailing: Alignment

    /// A guide marking the bottom and leading edges of the view.
    public static let bottomLeading: Alignment

    /// A guide marking the bottom and trailing edges of the view.
    public static let bottomTrailing: Alignment

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: Alignment, b: Alignment) -> Bool
}



@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the view's horizontal alignment.
    ///
    /// Use `alignmentGuide(_:computeValue:)` to calculate specific offsets
    /// to reposition views in relationship to one another. You can return a
    /// constant or can use the ``ViewDimensions`` argument to the closure to
    /// calculate a return value.
    ///
    /// In the example below, the ``HStack`` is offset by a constant of 50
    /// points to the right of center:
    ///
    ///     VStack {
    ///         Text("Today's Weather")
    ///             .font(.title)
    ///             .border(Color.gray)
    ///         HStack {
    ///             Text("🌧")
    ///             Text("Rain & Thunderstorms")
    ///             Text("⛈")
    ///         }
    ///         .alignmentGuide(HorizontalAlignment.center) { _ in  50 }
    ///         .border(Color.gray)
    ///     }
    ///     .border(Color.gray)
    ///
    /// Changing the alignment of one view may have effects on surrounding
    /// views. Here the offset values inside a stack and its contained views is
    /// the difference of their absolute offsets.
    ///
    /// ![A view showing the two emoji offset from a text element using a
    /// horizontal alignment guide.](SwiftUI-View-HAlignmentGuide.png)
    ///
    /// - Parameters:
    ///   - g: A ``HorizontalAlignment`` value at which to a base the offset.
    ///   - computeValue: A closure that returns the offset value to apply to
    ///     this view.
    ///
    /// - Returns: A view modified with respect to its horizontal alignment
    ///   according to the computation performed in the method's closure.
    @inlinable public func alignmentGuide(_ g: HorizontalAlignment, computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View


    /// Sets the view's vertical alignment.
    ///
    /// Use `alignmentGuide(_:computeValue:)` to calculate specific offsets
    /// to reposition views in relationship to one another. You can return a
    /// constant or can use the ``ViewDimensions`` argument to the closure to
    /// calculate a return value.
    ///
    /// In the example below, the weather emoji are offset 20 points from the
    /// vertical center of the ``HStack``.
    ///
    ///     VStack {
    ///         Text("Today's Weather")
    ///             .font(.title)
    ///             .border(Color.gray)
    ///
    ///         HStack {
    ///             Text("🌧")
    ///                 .alignmentGuide(VerticalAlignment.center) { _ in -20 }
    ///             Text("Rain & Thunderstorms")
    ///                 .border(Color.gray)
    ///             Text("⛈")
    ///                 .alignmentGuide(VerticalAlignment.center) { _ in 20 }
    ///                 .border(Color.gray)
    ///         }
    ///     }
    ///
    /// Changing the alignment of one view may have effects on surrounding
    /// views. Here the offset values inside a stack and its contained views is
    /// the difference of their absolute offsets.
    ///
    /// ![A view showing the two emoji offset from a text element using a
    /// vertical alignment guide.](SwiftUI-View-VAlignmentGuide.png)
    ///
    /// - Parameters:
    ///   - g: A ``VerticalAlignment`` value at which to a base the offset.
    ///   - computeValue: A closure that returns the offset value to apply to
    ///     this view.
    ///
    /// - Returns: A view modified with respect to its vertical alignment
    ///   according to the computation performed in the method's closure.
    @inlinable public func alignmentGuide(_ g: VerticalAlignment, computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View

}
