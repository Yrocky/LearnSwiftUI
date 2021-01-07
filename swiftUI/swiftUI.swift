import Combine
import CoreData
import CoreFoundation
import CoreGraphics
import Darwin
import DeveloperToolsSupport
import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers
import os.log
import os
import os.signpost



/// A type-erased view.
///
/// An `AnyView` allows changing the type of view used in a given view
/// hierarchy. Whenever the type of view used with an `AnyView` changes, the old
/// hierarchy is destroyed and a new hierarchy is created for the new type.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct AnyView : View {

    /// Create an instance that type-erases `view`.
    public init<V>(_ view: V) where V : View

    public init<V>(erasing view: V) where V : View

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum ContentSizeCategory : Hashable, CaseIterable {

    case extraSmall

    case small

    case medium

    case large

    case extraLarge

    case extraExtraLarge

    case extraExtraExtraLarge

    case accessibilityMedium

    case accessibilityLarge

    case accessibilityExtraLarge

    case accessibilityExtraExtraLarge

    case accessibilityExtraExtraExtraLarge

    /// A `Bool` value indicating whether the content size category is one that
    /// is associated with accessibility.
    @available(iOS 13.4, macOS 10.15.4, tvOS 13.4, watchOS 6.2, *)
    public var isAccessibilityCategory: Bool { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: ContentSizeCategory, b: ContentSizeCategory) -> Bool

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

    /// A type that can represent a collection of all values of this type.
    public typealias AllCases = [ContentSizeCategory]

    /// A collection of all values of this type.
    public static var allCases: [ContentSizeCategory] { get }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ContentSizeCategory {

    /// Returns a Boolean value indicating whether the value of the first argument is less than that of the second argument.
    public static func < (lhs: ContentSizeCategory, rhs: ContentSizeCategory) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument is less than or equal to that of the second argument.
    public static func <= (lhs: ContentSizeCategory, rhs: ContentSizeCategory) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument is greater than that of the second argument.
    public static func > (lhs: ContentSizeCategory, rhs: ContentSizeCategory) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument is greater than or equal to that of the second argument.
    public static func >= (lhs: ContentSizeCategory, rhs: ContentSizeCategory) -> Bool
}

extension ContentSizeCategory {

    /// Create a size category from its UIContentSizeCateogry equivalent.
    @available(iOS 14.0, tvOS 14.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public init?(_ uiSizeCategory: UIContentSizeCategory)
}


/// The mode of a view indicating whether the user can edit its content.
@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
public enum EditMode {

    /// The view content cannot be edited.
    case inactive

    /// The view is in a temporary edit mode.
    ///
    /// The definition of temporary might vary by platform or specific control.
    /// As an example, temporary edit mode may be engaged over the duration of a
    /// swipe gesture.
    case transient

    /// The view content can be edited.
    case active

    /// Indicates whether a view is being edited.
    public var isEditing: Bool { get }

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: EditMode, b: EditMode) -> Bool

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

@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension EditMode : Equatable {
}

@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension EditMode : Hashable {
}

/// A view type that compares itself against its previous value and prevents its
/// child updating if its new value is the same as its old value.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct EquatableView<Content> : View where Content : Equatable, Content : View {

    public var content: Content

    @inlinable public init(content: Content)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never
}

/// An indication whether a view is currently presented by another view.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PresentationMode {

    /// Indicates whether a view is currently presented.
    public var isPresented: Bool { get }

    /// Dismisses the view if it is currently presented.
    ///
    /// If `isPresented` is false, `dismiss()` is a no-op.
    public mutating func dismiss()
}

/// The reasons to apply a redaction to data displayed on screen.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct RedactionReasons : OptionSet {

    /// The raw value.
    public let rawValue: Int

    /// Creates a new set from a raw value.
    ///
    /// - Parameter rawValue: The raw value with which to create the
    ///   reasons for redaction.
    public init(rawValue: Int)

    /// Displayed data should appear as generic placeholders.
    ///
    /// Text and images will be automatically masked to appear as
    /// generic placeholders, though maintaining their original size and shape.
    /// Use this to create a placeholder UI without directly exposing
    /// placeholder data to users.
    public static let placeholder: RedactionReasons

    /// The element type of the option set.
    ///
    /// To inherit all the default implementations from the `OptionSet` protocol,
    /// the `Element` type must be `Self`, the default.
    public typealias Element = RedactionReasons

    /// The type of the elements of an array literal.
    public typealias ArrayLiteralElement = RedactionReasons

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = Int
}

/// A View created from a swift tuple of View values.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct TupleView<T> : View {

    public var value: T

    @inlinable public init(_ value: T)

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never
}

/// A type that represents part of your app's user interface and provides
/// modifiers that you use to configure views.
///
/// You create custom views by declaring types that conform to the ``View``
/// protocol. Implement the required ``View/body-swift.property`` computed
/// property to provide the content for your custom view.
///
///     struct MyView: View {
///         var body: some View {
///             Text("Hello, World!")
///         }
///     }
///
/// Assemble the view's body by combining one or more of the primitive views
/// provided by SwiftUI, like the ``Text`` instance in the example above, plus
/// other custom views that you define, into a hierarchy of views.
///
/// The ``View`` protocol provides a large set of modifiers, defined as protocol
/// methods with default implementations, that you use to position and configure
/// views in the layout of your app. Modifiers typically work by wrapping the
/// view instance on which you call them in another view with the specified
/// characteristics. For example, adding the ``View/opacity(_:)`` modifier to a
/// text view returns a new view with some amount of transparency:
///
///     Text("Hello, World!")
///         .opacity(0.5) // Display partially transparent text.
///
/// The effects of a modifier typically propagate to any child views that don't
/// explicitly override the modifier. For example, a ``VStack`` instance on its
/// own acts only to vertically stack other views, and has no text to display.
/// Therefore, a ``View/font(_:)`` modifier that you apply to the stack has no
/// effect on the stack itself. Yet the font modifier does apply to any of the
/// stack's child views, some of which might display text. On the other hand,
/// you can locally override the stack's modifier by adding another to a
/// specific child view:
///
///     VStack {
///         Text("Title")
///             .font(.headline) // Override the font of this one view.
///         Text("First body line.")
///         Text("Second body line.")
///     }
///     .font(.body) // Set a default for text in the stack.
///
/// You commonly chain modifiers, each wrapping the result of the previous one.
/// For example, you can wrap a text view in an invisible box with a given width
/// using the ``View/frame(width:height:alignment:)`` modifier to influence its
/// layout, and then use the ``View/border(_:width:)`` modifier to draw an
/// outline around that:
///
///     Text("Title")
///         .frame(width: 100)
///         .border(Color.gray)
///
/// The order in which you apply modifiers matters. For example, the border that
/// results from the above code outlines the full width of the frame.
///
/// ![A screenshot of a text view displaying the string "Title", outlined by a
/// gray rectangle that's wider than the string it encloses, leaving empty space
/// inside the rectangle on either side of the string. A caption reads, "Apply
/// the frame first."](SwiftUI-View-1.png)
///
/// If you instead apply the border first, it outlines the text view, which
/// never takes more space than it needs to render its contents.
///
///     Text("Title")
///         .border(Color.gray) // Apply the border first this time.
///         .frame(width: 100)
///
/// Wrapping that view in another invisible one with a fixed 100 point width
/// affects the layout of the composite view, but has no effect on the border.
///
/// ![A screenshot of a text view displaying the string "Title", outlined by a
/// gray rectangle that hugs the text. A caption reads, "Apply the border
/// first."](SwiftUI-View-2.png)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol View {

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    associatedtype Body : View

    /// The content and behavior of the view.
    @ViewBuilder var body: Self.Body { get }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
@available(macOS, unavailable)
extension View {

    /// Presents a modal view that covers as much of the screen as
    /// possible using the given item as a data source for the sheet's content.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the cover
    ///     modal view. When representing a non-nil item, the system uses
    ///     `content` to create a modal representation of the item.
    ///     If the identity of `item` changes, the system will dismiss a
    ///     currently-presented modal view and replace it by a new modal view.
    ///   - onDismiss: A closure executed when the modal view dismisses.
    ///   - content: A closure returning the content of the modal view.
    public func fullScreenCover<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View


    /// Presents a modal view that covers as much of the screen as
    /// possible when a given condition is true.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the modal view is presented.
    ///   - onDismiss: A closure executed when the modal view dismisses.
    ///   - content: A closure returning the content of the modal view.
    public func fullScreenCover<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View

}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Provides a closure that vends the drag representation to be used for a
    /// particular data element.
    @inlinable public func itemProvider(_ action: (() -> NSItemProvider?)?) -> some View

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View where Self : Equatable {

    /// Prevents the view from updating its child view when its new value is the
    /// same as its old value.
    @inlinable public func equatable() -> EquatableView<Self>
}


@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Presents a system interface for allowing the user to import an existing
    /// file.
    ///
    /// In order for the interface to appear, `isPresented` must be `true`. When
    /// the operation is finished, `isPresented` will be set to `false` before
    /// `onCompletion` is called. If the user cancels the operation,
    /// `isPresented` will be set to `false` and `onCompletion` will not be
    /// called.
    ///
    /// - Note: Changing `allowedContentTypes` while the file importer is
    ///   presented will have no immediate effect, however will apply the next
    ///   time it is presented.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - allowedContentTypes: The list of supported content types which can
    ///     be imported.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileImporter(isPresented: Binding<Bool>, allowedContentTypes: [UTType], onCompletion: @escaping (Result<URL, Error>) -> Void) -> some View


    /// Presents a system interface for allowing the user to import multiple
    /// files.
    ///
    /// In order for the interface to appear, `isPresented` must be `true`. When
    /// the operation is finished, `isPresented` will be set to `false` before
    /// `onCompletion` is called. If the user cancels the operation,
    /// `isPresented` will be set to `false` and `onCompletion` will not be
    /// called.
    ///
    /// - Note: Changing `allowedContentTypes` or `allowsMultipleSelection`
    ///   while the file importer is presented will have no immediate effect,
    ///   however will apply the next time it is presented.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - allowedContentTypes: The list of supported content types which can
    ///     be imported.
    ///   - allowsMultipleSelection: Whether the importer allows the user to
    ///     select more than one file to import.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileImporter(isPresented: Binding<Bool>, allowedContentTypes: [UTType], allowsMultipleSelection: Bool, onCompletion: @escaping (Result<[URL], Error>) -> Void) -> some View

}
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {

    /// Adds a reason to apply a redaction to this view hierarchy.
    ///
    /// Adding a redaction is an additive process: any redaction
    /// provided will be added to the reasons provided by the parent.
    public func redacted(reason: RedactionReasons) -> some View


    /// Removes any reason to apply a redaction to this view hierarchy.
    public func unredacted() -> some View

}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets this view's color scheme.
    ///
    /// Use `colorScheme(_:)` to set the color scheme for the view to which you
    /// apply it and any subviews. If you want to set the color scheme for all
    /// views in the presentation, use ``View/preferredColorScheme(_:)``
    /// instead.
    ///
    /// - Parameter colorScheme: The color scheme for this view.
    ///
    /// - Returns: A view that sets this view's color scheme.
    @available(iOS, introduced: 13.0, deprecated: 100000.0, renamed: "preferredColorScheme(_:)")
    @available(macOS, introduced: 10.15, deprecated: 100000.0, renamed: "preferredColorScheme(_:)")
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, renamed: "preferredColorScheme(_:)")
    @available(watchOS, introduced: 6.0, deprecated: 100000.0, renamed: "preferredColorScheme(_:)")
    @inlinable public func colorScheme(_ colorScheme: ColorScheme) -> some View


    /// Scales images within the view according to one of the relative sizes
    /// available including small, medium, and large images sizes.
    ///
    /// The example below shows the relative scaling effect. The system renders
    /// the image at a relative size based on the available space and
    /// configuration options of the image it is scaling.
    ///
    ///     VStack {
    ///         HStack {
    ///             Image(systemName: "heart.fill")
    ///                 .imageScale(.small)
    ///             Text("Small")
    ///         }
    ///         HStack {
    ///             Image(systemName: "heart.fill")
    ///                 .imageScale(.medium)
    ///             Text("Medium")
    ///         }
    ///
    ///         HStack {
    ///             Image(systemName: "heart.fill")
    ///                 .imageScale(.large)
    ///             Text("Large")
    ///         }
    ///     }
    ///
    /// ![A view showing small, medium, and large hearts rendered at a size
    /// relative to the available space.](SwiftUI-View-imageScale.png)
    ///
    /// - Parameter scale: One of the relative sizes provided by the image scale
    ///   enumeration.
    @available(macOS 11.0, *)
    @inlinable public func imageScale(_ scale: Image.Scale) -> some View


    /// Sets the default font for text in this view.
    ///
    /// Use `font(_:)` to apply a specific font to all of the text in a view.
    ///
    /// The example below shows the effects of applying fonts to individual
    /// views and to view hierarchies. Font information flows down the view
    /// hierarchy as part of the environment, and remains in effect unless
    /// overridden at the level of an individual view or view container.
    ///
    /// Here, the outermost ``VStack`` applies a 16-point system font as a
    /// default font to views contained in that ``VStack``. Inside that stack,
    /// the example applies a ``Font/largeTitle`` font to just the first text
    /// view; this explicitly overrides the default. The remaining stack and the
    /// views contained with it continue to use the 16-point system font set by
    /// their containing view:
    ///
    ///     VStack {
    ///         Text("Font applied to a text view.")
    ///             .font(.largeTitle)
    ///
    ///         VStack {
    ///             Text("These 2 text views have the same font")
    ///             Text("applied to their parent hierarchy")
    ///         }
    ///     }
    ///     .font(.system(size: 16, weight: .light, design: .default))
    ///
    /// ![A screenshot showing the application fonts to an individual text field
    /// and view hierarchy.](SwiftUI-view-font.png)
    ///
    /// - Parameter font: The default font to use in this view.
    ///
    /// - Returns: A view with the default font set to the value you supply.
    @inlinable public func font(_ font: Font?) -> some View

}

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Presents a popover using the given item as a data source for the
    /// popover's content.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the popover.
    ///     When representing a non-`nil` item, the system uses `content` to
    ///     create a popover representation of the item.
    ///     If the identity changes, the system dismisses a
    ///     currently-presented popover and replace it by a new popover.
    ///   - attachmentAnchor: The positioning anchor which defines where the
    ///     popover is attached.
    ///   - arrowEdge: The edge of the `attachmentAnchor` where the popover's
    ///     arrow is located.
    ///   - content: A closure returning the content of the popover.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func popover<Item, Content>(item: Binding<Item?>, attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds), arrowEdge: Edge = .top, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View


    /// Presents a popover when a given condition is true.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the popover is presented.
    ///   - attachmentAnchor: The positioning anchor which defines where the
    ///     popover is attached.
    ///   - arrowEdge: The edge of the `attachmentAnchor` where the popover's
    ///     arrow is located.
    ///   - content: A closure returning the content of the popover.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func popover<Content>(isPresented: Binding<Bool>, attachmentAnchor: PopoverAttachmentAnchor = .rect(.bounds), arrowEdge: Edge = .top, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View

}

@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Adds an action to perform when the user moves the pointer over or away
    /// from the view's frame.
    ///
    /// Calling this method defines a region for detecting pointer movement with
    /// the size and position of this view.
    ///
    /// - Parameter action: The action to perform whenever the pointer enters or
    ///   exits this view's frame. If the pointer is in the view's frame, the
    ///   `action` closure passes `true` as a parameter; otherwise, `false`.
    ///
    /// - Returns: A view that triggers `action` when the pointer enters or
    ///   exits this view's frame.
    @inlinable public func onHover(perform action: @escaping (Bool) -> Void) -> some View

}
extension View {

    /// Sets the keyboard type for this view.
    ///
    /// Use `keyboardType(_:)` to specify the keyboard type to use for text
    /// entry. A number of different keyboard types are available to meet
    /// specialized input needs, such as entering email addresses or phone
    /// numbers.
    ///
    /// The example below presents a ``TextField`` to input an email address.
    /// Setting the text field's keyboard type to `.emailAddress` ensures the
    /// user can only enter correctly formatted email addresses.
    ///
    ///     TextField("someone@example.com", text: $emailAddress)
    ///         .keyboardType(.emailAddress)
    ///
    /// There are several different kinds of specialized keyboard types
    /// available though the
    /// <doc://com.apple.documentation/documentation/UIKit/UIKeyboardType> enumeration. To
    /// specify the default system keyboard type, use `.default`.
    ///
    /// ![A screenshot showing the use of a specialized keyboard type with a
    /// text field.](SwiftUI-View-keyboardType.png)
    ///
    /// - Parameter type: One of the keyboard types defined in the
    /// <doc://com.apple.documentation/documentation/UIKit/UIKeyboardType> enumeration.
    @available(iOS 13.0, tvOS 13.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public func keyboardType(_ type: UIKeyboardType) -> some View

}

extension View {

    /// Sets whether to apply auto-capitalization to this view.
    ///
    /// Use `autocapitalization(_:)` when you need to automatically capitalize
    /// words, sentences, or other text like proper nouns.
    ///
    /// In example below, as the user enters text each word is automatically
    /// capitalized:
    ///
    ///     TextField("Last, First", text: $fullName)
    ///         .autocapitalization(UITextAutocapitalizationType.words)
    ///
    /// The <doc://com.apple.documentation/documentation/UIKit/UITextAutocapitalizationType>
    /// enumeration defines the available capitalization modes. The default is
    /// <doc://com.apple.documentation/documentation/UIKit/UITextAutocapitalizationType/sentences>.
    ///
    /// - Parameter style: One of the autocapitalization modes defined in the
    /// <doc://com.apple.documentation/documentation/UIKit/UITextAutocapitalizationType>
    /// enumeration.
    @available(iOS 13.0, tvOS 13.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public func autocapitalization(_ style: UITextAutocapitalizationType) -> some View

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Defines a keyboard shortcut and assigns it to the modified control.
    ///
    /// Pressing the control's shortcut while the control is anywhere in the
    /// frontmost window or scene, or anywhere in the macOS main menu, is
    /// equivalent to direct interaction with the control to perform its primary
    /// action.
    ///
    /// The target of a keyboard shortcut is resolved in a leading-to-trailing,
    /// depth-first traversal of one or more view hierarchies. On macOS, the
    /// system looks in the key window first, then the main window, and then the
    /// command groups; on other platforms, the system looks in the active
    /// scene, and then the command groups.
    ///
    /// If multiple controls are associated with the same shortcut, the first
    /// one found is used.
    public func keyboardShortcut(_ key: KeyEquivalent, modifiers: EventModifiers = .command) -> some View


    /// Assigns a keyboard shortcut to the modified control.
    ///
    /// Pressing the control's shortcut while the control is anywhere in the
    /// frontmost window or scene, or anywhere in the macOS main menu, is
    /// equivalent to direct interaction with the control to perform its primary
    /// action.
    ///
    /// The target of a keyboard shortcut is resolved in a leading-to-trailing
    /// traversal of one or more view hierarchies. On macOS, the system looks in
    /// the key window first, then the main window, and then the command groups;
    /// on other platforms, the system looks in the active scene, and then the
    /// command groups.
    ///
    /// If multiple controls are associated with the same shortcut, the first
    /// one found is used.
    public func keyboardShortcut(_ shortcut: KeyboardShortcut) -> some View

}

extension View {

    /// Modifies this view by injecting a value that you provide for use by
    /// other views whose state depends on the focused view hierarchy.
    ///
    /// - Parameters:
    ///   - keyPath: The key path to associate `value` with when adding
    ///     it to the existing table of exported focus values.
    ///   - value: The focus value to export.
    /// - Returns: A modified representation of this view.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public func focusedValue<Value>(_ keyPath: WritableKeyPath<FocusedValues, Value?>, _ value: Value) -> some View

}
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {

    /// Adds a modifier for this view that fires an action when a specific
    /// value changes.
    ///
    /// You can use `onChange` to trigger a side effect as the result of a
    /// value changing, such as an `Environment` key or a `Binding`.
    ///
    /// `onChange` is called on the main thread. Avoid performing long-running
    /// tasks on the main thread. If you need to perform a long-running task in
    /// response to `value` changing, you should dispatch to a background queue.
    ///
    /// The new value is passed into the closure. The previous value may be
    /// captured by the closure to compare it to the new value. For example, in
    /// the following code example, `PlayerView` passes both the old and new
    /// values to the model.
    ///
    ///     struct PlayerView : View {
    ///         var episode: Episode
    ///         @State private var playState: PlayState = .paused
    ///
    ///         var body: some View {
    ///             VStack {
    ///                 Text(episode.title)
    ///                 Text(episode.showTitle)
    ///                 PlayButton(playState: $playState)
    ///             }
    ///             .onChange(of: playState) { [playState] newState in
    ///                 model.playStateDidChange(from: playState, to: newState)
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - value: The value to check against when determining whether
    ///     to run the closure.
    ///   - action: A closure to run when the value changes.
    ///   - newValue: The new value that failed the comparison check.
    ///
    /// - Returns: A view that fires an action when the specified value changes.
    @inlinable public func onChange<V>(of value: V, perform action: @escaping (V) -> Void) -> some View where V : Equatable

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Presents a system interface for allowing the user to move an existing
    /// file to a new location.
    ///
    /// In order for the interface to appear, both `isPresented` must be `true`
    /// and `file` must not be `nil`. When the operation is finished,
    /// `isPresented` will be set to `false` before `onCompletion` is called. If
    /// the user cancels the operation, `isPresented` will be set to `false` and
    /// `onCompletion` will not be called.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - file: The `URL` of the file to be moved.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     has succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileMover(isPresented: Binding<Bool>, file: URL?, onCompletion: @escaping (Result<URL, Error>) -> Void) -> some View


    /// Presents a system interface for allowing the user to move a collection
    /// of existing files to a new location.
    ///
    /// In order for the interface to appear, both `isPresented` must be `true`
    /// and `files` must not be empty. When the operation is finished,
    /// `isPresented` will be set to `false` before `onCompletion` is called. If
    /// the user cancels the operation, `isPresented` will be set to `false` and
    /// `onCompletion` will not be called.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - files: A collection of `URL`s for the files to be moved.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     has succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileMover<C>(isPresented: Binding<Bool>, files: C, onCompletion: @escaping (Result<[URL], Error>) -> Void) -> some View where C : Collection, C.Element == URL

}


@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Specifies a modifier indicating the Scene this View
    /// is in can handle matching incoming External Events.
    ///
    /// If no modifier is set in any Views within a Scene, the behavior
    /// is platform dependent. On macOS, a new Scene will be created to
    /// use for the External Event. On iOS, the system will choose an
    /// existing Scene to use.
    ///
    /// On platforms that only allow a single Window/Scene, this method is
    /// ignored, and incoming External Events are always routed to the
    /// existing single Scene.
    ///
    /// - Parameter preferring: A Set of Strings that are checked to see
    /// if they are contained in the targetContentIdenfifier to see if
    /// the Scene this View is in prefers to handle the Exernal Event.
    /// The empty Set and empty Strings never match. The String value
    /// "*" always matches. The String comparisons are case/diacritic
    /// insensitive
    ///
    /// - Parameter allowing: A Set of Strings that are checked to see
    /// if they are contained in the targetContentIdenfifier to see if
    /// the Scene this View is in allows handling the External Event.
    /// The empty Set and empty Strings never match. The String value
    /// "*" always matches.
    public func handlesExternalEvents(preferring: Set<String>, allowing: Set<String>) -> some View

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension View {

    /// Adds help text to a view using a localized string that you provide.
    ///
    /// Adding help to a view configures the view's accessibility hint and
    /// its tooltip ("help tag") on macOS.
    ///
    /// For more information on using help tags, see [Help]
    /// (https://developer.apple.com/design/human-interface-guidelines/macos/user-interaction/help/)
    /// in the macOS Human Interface Guidelines.
    ///
    ///     Button(action: composeMessage) {
    ///         Image(systemName: "square.and.pencil")
    ///     }
    ///     .help("Compose a new message")
    ///
    /// - Parameter textKey: The key for the localized text to use as help.
    public func help(_ textKey: LocalizedStringKey) -> some View


    /// Adds help text to a view using a text view that you provide.
    ///
    /// Adding help to a view configures the view's accessibility hint and
    /// its tooltip ("help tag") on macOS.
    ///
    /// For more information on using help tags, see [Help]
    /// (https://developer.apple.com/design/human-interface-guidelines/macos/user-interaction/help/)
    /// in the macOS Human Interface Guidelines.
    ///
    ///     Slider("Opacity", value: $selectedShape.opacity)
    ///         .help(Text("Adjust the opacity of the selected \(selectedShape.name)"))
    ///
    /// - Parameter text: The Text view to use as help.
    public func help(_ text: Text) -> some View


    /// Adds help text to a view using a string that you provide.
    ///
    /// Adding help to a view configures the view's accessibility hint and
    /// its tooltip ("help tag") on macOS.
    ///
    /// For more information on using help tags, see [Help]
    /// (https://developer.apple.com/design/human-interface-guidelines/macos/user-interaction/help/)
    /// in the macOS Human Interface Guidelines.
    ///
    ///     Image(systemName: "pin.circle")
    ///         .foregroundColor(pointOfInterest.tintColor)
    ///         .help(pointOfInterest.name)
    ///
    /// - Parameter text: The text to use as help.
    public func help<S>(_ text: S) -> some View where S : StringProtocol

}

extension NSDirectionalEdgeInsets {

    /// Create edge insets from the equivalent EdgeInsets.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, *)
    @available(watchOS, unavailable)
    public init(_ edgeInsets: EdgeInsets)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Never {

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = Never

    /// The content and behavior of the view.
    public var body: Never { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension CGPoint {

    public func applying(_ m: ProjectionTransform) -> CGPoint
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Never : Gesture {

    /// The type representing the gesture's value.
    public typealias Value = Never
}

/// Extends `T?` to conform to `Gesture` type if `T` also conforms to
/// `Gesture`. A nil value is mapped to an empty (i.e. failing)
/// gesture.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Optional : Gesture where Wrapped : Gesture {

    /// The type representing the gesture's value.
    public typealias Value = Wrapped.Value
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension NSUserActivity {

    /// Error types when getting/setting typed payload
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public enum TypedPayloadError : Error {

        /// UserInfo is empty or invalid
        case invalidContent

        /// Content failed to encode into a valid Dictionary
        case encodingError

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: NSUserActivity.TypedPayloadError, b: NSUserActivity.TypedPayloadError) -> Bool

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

    /// Given a Codable Swift type, return an instance decoded from the
    /// NSUserActivity's userInfo dictionary
    ///
    /// - Parameter type: the instance type to be decoded from userInfo
    /// - Returns: the type safe instance or raises if it can't be decoded
    public func typedPayload<T>(_ type: T.Type) throws -> T where T : Decodable, T : Encodable

    /// Given an instance of a Codable Swift type, encode it into the
    /// NSUserActivity's userInfo dictionary
    ///
    /// - Parameter payload: the instance to be converted to userInfo
    public func setTypedPayload<T>(_ payload: T) throws where T : Decodable, T : Encodable
}

extension Never : Scene {
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension Never : WidgetConfiguration {
}

extension Never : ToolbarContent, CustomizableToolbarContent {
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Optional : View where Wrapped : View {

    /// The type of gesture representing the body of `Self`.
    public typealias Body = Never
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Never : View {
}

extension RangeReplaceableCollection where Self : MutableCollection {

    /// Removes all the elements at the specified offsets from the collection.
    ///
    /// - Complexity: O(*n*) where *n* is the length of the collection.
    public mutating func remove(atOffsets offsets: IndexSet)
}

extension MutableCollection {

    /// Moves all the elements at the specified offsets to the specified
    /// destination offset, preserving ordering.
    ///
    /// - Complexity: O(*n* log *n*), where *n* is the length of the collection.
    public mutating func move(fromOffsets source: IndexSet, toOffset destination: Int)
}

extension UIColor {

    @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    @available(macOS, unavailable)
    public convenience init(_ color: Color)
}

extension UIUserInterfaceStyle {

    /// Creates a user interface style from its ColorScheme equivalent.
    @available(iOS 14.0, tvOS 14.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ colorScheme: ColorScheme?)
}

extension UIAccessibilityContrast {

    /// Create a contrast from its ColorSchemeContrast equivalent.
    @available(iOS 14.0, tvOS 14.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ colorSchemeContrast: ColorSchemeContrast?)
}

extension UIContentSizeCategory {

    /// Create a size category from its ContentSizeCategory equivalent.
    @available(iOS 14.0, tvOS 14.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ sizeCategory: ContentSizeCategory?)
}

extension UITraitEnvironmentLayoutDirection {

    /// Create a direction from its LayoutDirection equivalent.
    @available(iOS 14.0, tvOS 14.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ layoutDirection: LayoutDirection)
}

extension UILegibilityWeight {

    /// Creates a legibility weight from its LegibilityWeight equivalent.
    @available(iOS 14.0, tvOS 14.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ legibilityWeight: LegibilityWeight?)
}

extension UIUserInterfaceSizeClass {

    /// Create a size class from its UserInterfaceSizeClass equivalent.
    @available(iOS 14.0, *)
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ sizeClass: UserInterfaceSizeClass?)
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension CGPoint : Animatable {

    /// The type defining the data to animate.
    public typealias AnimatableData = AnimatablePair<CGFloat, CGFloat>

    /// The data to animate.
    public var animatableData: CGPoint.AnimatableData
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension CGSize : Animatable {

    /// The type defining the data to animate.
    public typealias AnimatableData = AnimatablePair<CGFloat, CGFloat>

    /// The data to animate.
    public var animatableData: CGSize.AnimatableData
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension CGRect : Animatable {

    /// The type defining the data to animate.
    public typealias AnimatableData = AnimatablePair<CGPoint.AnimatableData, CGSize.AnimatableData>

    /// The data to animate.
    public var animatableData: CGRect.AnimatableData
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension Never : Commands {
}


