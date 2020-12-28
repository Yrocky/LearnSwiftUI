//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A property wrapper that reads a value from a view's environment.
///
/// Use the `Environment` property wrapper to read a value
/// stored in a view's environment. Indicate the value to read using an
/// ``EnvironmentValues`` key path in the property declaration. For example, you
/// can create a property that reads the color scheme of the current
/// view using the key path of the ``EnvironmentValues/colorScheme``
/// property:
///
///     @Environment(\.colorScheme) var colorScheme: ColorScheme
///
/// You can condition a view's content on the associated value, which
/// you read from the declared property's ``wrappedValue``. As with any property
/// wrapper, you access the wrapped value by directly referring to the property:
///
///     if colorScheme == .dark { // Checks the wrapped value.
///         DarkContent()
///     } else {
///         LightContent()
///     }
///
/// If the value changes, SwiftUI updates any parts of your view that depend on
/// the value. For example, that might happen in the above example if the user
/// changes the Appearance settings.
///
/// You can use this property wrapper to read --- but not set --- an environment
/// value. SwiftUI updates some environment values automatically based on system
/// settings and provides reasonable defaults for others. You can override some
/// of these, as well as set custom environment values that you define,
/// using the ``View/environment(_:_:)`` view modifier.
///
/// For the complete list of environment values provided by SwiftUI, see the
/// properties of the ``EnvironmentValues`` structure. For information about
/// creating custom environment values, see the ``EnvironmentKey`` protocol.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen @propertyWrapper 
public struct Environment<Value> : DynamicProperty {

    /// Creates an environment property to read the specified key path.
    ///
    /// Don’t call this initializer directly. Instead, declare a property
    /// with the ``Environment`` property wrapper, and provide the key path of
    /// the environment value that the property should reflect:
    ///
    ///     struct MyView: View {
    ///         @Environment(\.colorScheme) var colorScheme: ColorScheme
    ///
    ///         // ...
    ///     }
    ///
    /// SwiftUI automatically updates any parts of `MyView` that depend on
    /// the property when the associated environment value changes.
    /// You can't modify the environment value using a property like this.
    /// Instead, use the ``View/environment(_:_:)`` view modifier on a view to
    /// set a value for a view hierarchy.
    ///
    /// - Parameter keyPath: A key path to a specific resulting value.
    @inlinable public init(_ keyPath: KeyPath<EnvironmentValues, Value>)

    /// The current value of the environment property.
    ///
    /// The wrapped value property provides primary access to the value's data.
    /// However, you don't access `wrappedValue` directly. Instead, you read the
    /// property variable created with the ``Environment`` property wrapper:
    ///
    ///     @Environment(\.colorScheme) var colorScheme: ColorScheme
    ///
    ///     var body: some View {
    ///         if colorScheme == .dark {
    ///             DarkContent()
    ///         } else {
    ///             LightContent()
    ///         }
    ///     }
    ///
    @inlinable public var wrappedValue: Value { get }
}

/// A key for accessing values in the environment.
///
/// You can create custom environment values by extending the
/// ``EnvironmentValues`` structure with new properties.
/// First declare a new environment key type and specify a value for the
/// required ``defaultValue`` property:
///
///     private struct MyEnvironmentKey: EnvironmentKey {
///         static let defaultValue: String = "Default value"
///     }
///
/// The Swift compiler automatically infers the associated ``Value`` type as the
/// type you specify for the default value. Then use the key to define a new
/// environment value property:
///
///     extension EnvironmentValues {
///         var myCustomValue: String {
///             get { self[MyEnvironmentKey.self] }
///             set { self[MyEnvironmentKey.self] = newValue }
///         }
///     }
///
/// Clients of your environment value never use the key directly.
/// Instead, they use the key path of your custom environment value property.
/// To set the environment value for a view and all its subviews, add the
/// ``View/environment(_:_:)`` view modifier to that view:
///
///     MyView()
///         .environment(\.myCustomValue, "Another string")
///
/// As a convenience, you can also define a dedicated view modifier to
/// apply this environment value:
///
///     extension View {
///         func myCustomValue(_ myCustomValue: String) -> some View {
///             environment(\.myCustomValue, myCustomValue)
///         }
///     }
///
/// This improves clarity at the call site:
///
///     MyView()
///         .myCustomValue("Another string")
///
/// To read the value from inside `MyView` or one of its descendants, use the
/// ``Environment`` property wrapper:
///
///     struct MyView: View {
///         @Environment(\.myCustomValue) var customValue: String
///
///         var body: some View {
///             Text(customValue) // Displays "Another value".
///         }
///     }
///
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol EnvironmentKey {

    /// The associated type representing the type of the environment key's
    /// value.
    associatedtype Value

    /// The default value for the environment key.
    static var defaultValue: Self.Value { get }
}

/// A property wrapper type for an observable object supplied by a parent or
/// ancestor view.
///
/// An environment object invalidates the current view whenever the observable
/// object changes. If you declare a property as an environment object, be sure
/// to set a corresponding model object on an ancestor view by calling its
/// ``View/environmentObject(_:)`` modifier.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen @propertyWrapper 
public struct EnvironmentObject<ObjectType> : DynamicProperty where ObjectType : ObservableObject {

    /// A wrapper of the underlying environment object that can create bindings
    /// to its properties using dynamic member lookup.
    @dynamicMemberLookup @frozen public struct Wrapper {

        /// Returns a binding to the resulting value of a given key path.
        ///
        /// - Parameter keyPath: A key path to a specific resulting value.
        ///
        /// - Returns: A new binding.
        public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<ObjectType, Subject>) -> Binding<Subject> { get }
    }

    /// The underlying value referenced by the environment object.
    ///
    /// This property provides primary access to the value's data. However, you
    /// don't access `wrappedValue` directly. Instead, you use the property
    /// variable created with the ``EnvironmentObject`` attribute.
    ///
    /// When a mutable value changes, the new value is immediately available.
    /// However, a view displaying the value is updated asynchronously and may
    /// not show the new value immediately.
    @inlinable public var wrappedValue: ObjectType { get }

    /// A projection of the environment object that creates bindings to its
    /// properties using dynamic member lookup.
    ///
    /// Use the projected value to pass an environment object down a view
    /// hierarchy.
    public var projectedValue: EnvironmentObject<ObjectType>.Wrapper { get }

    /// Creates an environment object.
    public init()
}

/// A collection of environment values propagated through a view hierarchy.
///
/// SwiftUI exposes a collection of values to your app's views in an
/// `EnvironmentValues` structure. To read a value from the structure,
/// declare a property using the ``Environment`` property wrapper and
/// specify the value's key path. For example, you can read the current locale:
///
///     @Environment(\.locale) var locale: Locale
///
/// Use the property you declare to dynamically control a view's layout.
/// SwiftUI automatically sets or updates many environment values, like
/// ``EnvironmentValues/pixelLength``, ``EnvironmentValues/scenePhase``, or
/// ``EnvironmentValues/locale``, based on device characteristics, system state,
/// or user settings. For others, like ``EnvironmentValues/lineLimit``, SwiftUI
/// provides a reasonable default value.
///
/// You can set or override some values using the ``View/environment(_:_:)``
/// view modifier:
///
///     MyView()
///         .environment(\.lineLimit, 2)
///
/// The value that you set affects the environment for the view that you modify
/// --- including its descendants in the view hierarchy --- but only up to the
/// point where you apply a different environment modifier.
///
/// SwiftUI provides dedicated view modifiers for setting some values, which
/// typically makes your code easier to read. For example, rather than setting
/// the ``EnvironmentValues/lineLimit`` value directly, as in the previous
/// example, you should instead use the ``View/lineLimit(_:)`` modifier:
///
///     MyView()
///         .lineLimit(2)
///
/// In some cases, using a dedicated view modifier provides additional
/// functionality. For example, you must use the
/// ``View/preferredColorScheme(_:)`` modifier rather than setting
/// ``EnvironmentValues/colorScheme`` directly to ensure that the new
/// value propagates up to the presenting container when presenting a view
/// like a popover:
///
///     MyView()
///         .popover(isPresented: $isPopped) {
///             PopoverContent()
///                 .preferredColorScheme(.dark)
///         }
///
/// Create custom environment values by defining a type that
/// conforms to the ``EnvironmentKey`` protocol, and then extending the
/// environment values structure with a new property. Use your key to get and
/// set the value, and provide a dedicated modifier for clients to use when
/// setting the value:
///
///     private struct MyEnvironmentKey: EnvironmentKey {
///         static let defaultValue: String = "Default value"
///     }
///
///     extension EnvironmentValues {
///         var myCustomValue: String {
///             get { self[MyEnvironmentKey.self] }
///             set { self[MyEnvironmentKey.self] = newValue }
///         }
///     }
///
///     extension View {
///         func myCustomValue(_ myCustomValue: String) -> some View {
///             environment(\.myCustomValue, myCustomValue)
///         }
///     }
///
/// Clients of your value then access the value in the usual way, reading it
/// with the ``Environment`` property wrapper, and setting it with the
/// `myCustomValue` view modifier.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct EnvironmentValues : CustomStringConvertible {

    /// Creates an environment values instance.
    ///
    /// You don't typically create an instance of ``EnvironmentValues``
    /// directly. Doing so would provide access only to default values that
    /// don't update based on system settings or device characteristics.
    /// Instead, you rely on an environment values' instance
    /// that SwiftUI manages for you when you use the ``Environment``
    /// property wrapper and the ``View/environment(_:_:)`` view modifier.
    public init()

    /// Accesses the environment value associated with a custom key.
    ///
    /// Create custom environment values by defining a key
    /// that conforms to the ``EnvironmentKey`` protocol, and then using that
    /// key with the subscript operator of the ``EnvironmentValues`` structure
    /// to get and set a value for that key:
    ///
    ///     private struct MyEnvironmentKey: EnvironmentKey {
    ///         static let defaultValue: String = "Default value"
    ///     }
    ///
    ///     extension EnvironmentValues {
    ///         var myCustomValue: String {
    ///             get { self[MyEnvironmentKey.self] }
    ///             set { self[MyEnvironmentKey.self] = newValue }
    ///         }
    ///     }
    ///
    /// You use custom environment values the same way you use system-provided
    /// values, setting a value with the ``View/environment(_:_:)`` view
    /// modifier, and reading values with the ``Environment`` property wrapper.
    /// You can also provide a dedicated view modifier as a convenience for
    /// setting the value:
    ///
    ///     extension View {
    ///         func myCustomValue(_ myCustomValue: String) -> some View {
    ///             environment(\.myCustomValue, myCustomValue)
    ///         }
    ///     }
    ///
    public subscript<K>(key: K.Type) -> K.Value where K : EnvironmentKey

    /// A string that represents the contents of the environment values
    /// instance.
    public var description: String { get }
}

extension EnvironmentValues {

    /// A Boolean value that determines whether the view hierarchy has
    /// auto-correction enabled.
    ///
    /// When the value is `nil`, SwiftUI uses the system default. The default
    /// value is `nil`.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
    @available(watchOS, unavailable)
    public var disableAutocorrection: Bool?
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// The preferred size of the content.
    ///
    /// The default value is ``ContentSizeCategory/large``.
    public var sizeCategory: ContentSizeCategory
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    public var managedObjectContext: NSManagedObjectContext
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// The undo manager used to register a view's undo operations.
    ///
    /// This value is `nil` when the environment represents a context that
    /// doesn't support undo and redo operations. You can skip registration of
    /// an undo operation when this value is `nil`.
    public var undoManager: UndoManager? { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// The layout direction associated with the current environment.
    ///
    /// Use this value to determine whether the environment uses a left-to-right
    /// or right-to-left orientation.
    public var layoutDirection: LayoutDirection
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension EnvironmentValues {

    /// The current redaction reasons applied to the view hierarchy.
    public var redactionReasons: RedactionReasons
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension EnvironmentValues {

    /// The current phase of the scene.
    ///
    /// The system sets this value to provide an indication of the
    /// operational state of a scene or collection of scenes. The exact
    /// meaning depends on where you access the value. For more information,
    /// see ``ScenePhase``.
    public var scenePhase: ScenePhase
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// The default minimum height of a row in a list.
    public var defaultMinListRowHeight: CGFloat

    /// The default minimum height of a header in a list.
    ///
    /// When this value is `nil`, the system chooses the appropriate height. The
    /// default is `nil`.
    public var defaultMinListHeaderHeight: CGFloat?
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// A Boolean value that indicates whether the view associated with this
    /// environment allows user interaction.
    ///
    /// The default value is `true`.
    public var isEnabled: Bool
}

extension EnvironmentValues {

    /// Returns whether the nearest focusable ancestor has focus.
    ///
    /// If there is no focusable ancestor, the value is `false`.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public var isFocused: Bool { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// The default font of this environment.
    public var font: Font?

    /// The display scale of this environment.
    public var displayScale: CGFloat

    /// The image scale for this environment.
    @available(macOS 11.0, *)
    public var imageScale: Image.Scale

    /// The size of a pixel on the screen.
    ///
    /// This value is equal to `1` divided by
    /// ``EnvironmentValues/displayScale``.
    public var pixelLength: CGFloat { get }

    /// The font weight to apply to text.
    ///
    /// This value reflects the value of the Bold Text display setting found in
    /// the Accessibility settings.
    public var legibilityWeight: LegibilityWeight?

    /// The current locale that views should use.
    public var locale: Locale

    /// The current calendar that views should use when handling dates.
    public var calendar: Calendar

    /// The current time zone that views should use when handling dates.
    public var timeZone: TimeZone

    /// The color scheme of this environment.
    ///
    /// When writing custom drawing code that depends on the current color
    /// scheme, you should also consider the
    /// ``EnvironmentValues/colorSchemeContrast`` property. You can specify
    /// images and colors in asset catalogs according to either the
    /// ``ColorScheme/light`` or ``ColorScheme/dark`` color scheme, as well as
    /// standard or increased contrast. The correct image or color displays
    /// automatically for the current environment.
    ///
    /// You only need to check `colorScheme` and
    /// ``EnvironmentValues/colorSchemeContrast`` for custom drawing if the
    /// differences go beyond images and colors.
    ///
    /// Setting the `colorScheme` environment value directly is an advanced use
    /// case, as it changes the color scheme of the contained views but *not* of
    /// the container. Instead, consider using the
    /// ``View/preferredColorScheme(_:)`` modifier, which propagates to the
    /// presentation containing the view.
    public var colorScheme: ColorScheme

    /// The contrast associated with the color scheme of this environment.
    public var colorSchemeContrast: ColorSchemeContrast { get }
}

@available(iOS 13.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension EnvironmentValues {

    /// The horizontal size class of this environment.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public var horizontalSizeClass: UserInterfaceSizeClass?

    /// The vertical size class of this environment.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public var verticalSizeClass: UserInterfaceSizeClass?
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension EnvironmentValues {

    /// Opens a URL using the appropriate system service.
    public var openURL: OpenURLAction { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// A value that indicates how text instance aligns its lines when the
    /// content wraps or contains newlines.
    ///
    /// Use alignment parameters on a parent view to align ``Text`` with respect
    /// to its parent. Because the horizontal bounds of ``TextField`` never
    /// exceed its graphical extent, this value has little to no effect on
    /// single-line text.
    public var multilineTextAlignment: TextAlignment

    /// A value that indicates how the layout truncates the last line of text to
    /// fit into the available space.
    ///
    /// The default value is ``Text/TruncationMode/tail``.
    public var truncationMode: Text.TruncationMode

    /// The distance in points between the bottom of one line fragment and the
    /// top of the next.
    ///
    /// This value is always nonnegative.
    public var lineSpacing: CGFloat

    /// A Boolean value that indicates whether inter-character spacing should
    /// tighten to fit the text into the available space.
    ///
    /// The default value is `false`.
    public var allowsTightening: Bool

    /// The maximum number of lines that text can occupy in a view.
    ///
    /// The maximum number of lines is `1` if the value is less than `1`. If the
    /// value is `nil`, the text uses as many lines as required. The default is
    /// `nil`.
    public var lineLimit: Int?

    /// The minimum permissible proportion to shrink the font size to fit
    /// the text into the available space.
    ///
    /// In the example below, a label with a `minimumScaleFactor` of `0.5`
    /// draws its text in a font size as small as half of the actual font if
    /// needed to fit into the space next to the text input field:
    ///
    ///     HStack {
    ///         Text("This is a very long label:")
    ///             .lineLimit(1)
    ///             .minimumScaleFactor(0.5)
    ///         TextField("My Long Text Field", text: $myTextField)
    ///             .frame(width: 250, height: 50, alignment: .center)
    ///     }
    ///
    /// ![A screenshot showing the effects of setting the minimumScaleFactor on
    ///   the text in a view](SwiftUI-view-minimumScaleFactor.png)
    ///
    /// You can set the minimum scale factor to any value greater than `0` and
    /// less than or equal to `1`. The default value is `1`.
    ///
    /// SwiftUI uses this value to shrink text that doesn't fit in a view when
    /// it's okay to shrink the text. For example, a label with a
    /// `minimumScaleFactor` of `0.5` draws its text in a font size as small as
    /// half the actual font if needed.
    public var minimumScaleFactor: CGFloat

    /// A stylistic override to transform the case of `Text` when displayed,
    /// using the environment's locale.
    ///
    /// The default value is `nil`, displaying the `Text` without any case
    /// changes.
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    public var textCase: Text.Case?
}

@available(iOS 13.0, tvOS 13.0, *)
@available(macOS, unavailable)
@available(watchOS, unavailable)
extension EnvironmentValues {

    /// The mode indicating whether the user can edit the contents of a view
    /// associated with this environment.
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    public var editMode: Binding<EditMode>?
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension EnvironmentValues {

    /// A binding to the current presentation mode of the view associated with
    /// this environment.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public var presentationMode: Binding<PresentationMode> { get }
}

/// A modifier that must resolve to a concrete modifier in an environment before
/// use.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol EnvironmentalModifier : ViewModifier where Self.Body == Never {

    /// The type of modifier to use after being resolved.
    associatedtype ResolvedModifier : ViewModifier

    /// Resolve to a concrete modifier in the given `environment`.
    func resolve(in environment: EnvironmentValues) -> Self.ResolvedModifier
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Transforms the environment value of the specified key path with the
    /// given function.
    @inlinable public func transformEnvironment<V>(_ keyPath: WritableKeyPath<EnvironmentValues, V>, transform: @escaping (inout V) -> Void) -> some View

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the environment value of the specified key path to the given value.
    ///
    /// Use this modifier to set one of the writable properties of the
    /// ``EnvironmentValues`` structure, including custom values that you
    /// create. For example, you can set the value associated with the
    /// ``EnvironmentValues/truncationMode`` key:
    ///
    ///     MyView()
    ///         .environment(\.truncationMode, .head)
    ///
    /// You then read the value inside `MyView` or one of its descendants
    /// using the ``Environment`` property wrapper:
    ///
    ///     struct MyView: View {
    ///         @Environment(\.truncationMode) var truncationMode: Text.TruncationMode
    ///
    ///         var body: some View { ... }
    ///     }
    ///
    /// SwiftUI provides dedicated view modifiers for setting most
    /// environment values, like the ``View/truncationMode(_:)``
    /// modifier which sets the ``EnvironmentValues/truncationMode`` value:
    ///
    ///     MyView()
    ///         .truncationMode(.head)
    ///
    /// Prefer the dedicated modifier when available, and offer your own when
    /// defining custom environment values, as described in
    /// ``EnvironmentKey``.
    ///
    /// The ``View/environment(_:_:)`` modifier affects the given view,
    /// as well as that view's descendant views. It has no effect
    /// outside the view hierarchy on which you call it.
    ///
    /// - Parameters:
    ///   - keyPath: A key path that indicates the property of the
    ///     ``EnvironmentValues`` structure to update.
    ///   - value: The new value to set for the item specified by `keyPath`.
    ///
    /// - Returns: A view that has the given value set in its environment.
    @inlinable public func environment<V>(_ keyPath: WritableKeyPath<EnvironmentValues, V>, _ value: V) -> some View

}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Supplies an `ObservableObject` to a view subhierachy.
    ///
    /// The object can be read by any child by using `EnvironmentObject`.
    ///
    /// - Parameter object: the object to store and make available to
    ///     the view's subhiearchy.
    @inlinable public func environmentObject<T>(_ object: T) -> some View where T : ObservableObject

}
