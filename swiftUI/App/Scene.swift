//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A part of an app's user interface with a life cycle managed by the
/// system.
///
/// You create an ``SwiftUI/App`` by combining one or more instances
/// that conform to the `Scene` protocol in the app's
/// ``SwiftUI/App/body-swift.property``. You can use the primitive scenes that
/// SwiftUI provides, like ``SwiftUI/WindowGroup``, along with custom scenes
/// that you compose from other scenes. To create a custom scene, declare a
/// type that conforms to the `Scene` protocol. Implement the required
/// ``SwiftUI/Scene/body-swift.property`` computed property and provide the
/// content for your custom scene:
///
///     struct MyScene: Scene {
///         var body: some Scene {
///             WindowGroup {
///                 MyRootView()
///             }
///         }
///     }
///
/// A scene acts as a container for a view hierarchy that you want to display
/// to the user. The system decides when and how to present the view hierarchy
/// in the user interface in a way that's platform-appropriate and dependent
/// on the current state of the app. For example, for the window group shown
/// above, the system lets the user create or remove windows that contain
/// `MyRootView` on platforms like macOS and iPadOS. On other platforms, the
/// same view hierarchy might consume the entire display when active.
///
/// Read the ``SwiftUI/EnvironmentValues/scenePhase`` environment
/// value from within a scene or one of its views to check whether a scene is
/// active or in some other state. You can create a property that contains the
/// scene phase, which is one of the values in the ``SwiftUI/ScenePhase``
/// enumeration, using the ``SwiftUI/Environment`` attribute:
///
///     struct MyScene: Scene {
///         @Environment(\.scenePhase) private var scenePhase
///
///         // ...
///     }
///
/// The `Scene` protocol provides scene modifiers, defined as protocol methods
/// with default implementations, that you use to configure a scene. For
/// example, you can use the ``SwiftUI/Scene/onChange(of:perform:)`` modifier to
/// trigger an action when a value changes. The following code empties a cache
/// when all of the scenes in the window group have moved to the background:
///
///     struct MyScene: Scene {
///         @Environment(\.scenePhase) private var scenePhase
///         @StateObject private var cache = DataCache()
///
///         var body: some Scene {
///             WindowGroup {
///                 MyRootView()
///             }
///             .onChange(of: scenePhase) { newScenePhase in
///                 if newScenePhase == .background {
///                     cache.empty()
///                 }
///             }
///         }
///     }
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol Scene {

    /// The type of scene that represents the body of this scene.
    ///
    /// When you create a custom scene, Swift infers this type from your
    /// implementation of the required ``SwiftUI/Scene/body-swift.property``
    /// property.
    associatedtype Body : Scene

    /// The content and behavior of the scene.
    ///
    /// For any scene that you create, provide a computed `body` property that
    /// defines the scene as a composition of other scenes. You can assemble a
    /// scene from primitive scenes that SwiftUI provides, as well as other
    /// scenes that you've defined.
    ///
    /// Swift infers the scene's ``SwiftUI/Scene/Body-swift.associatedtype``
    /// associated type based on the contents of the `body` property.
    @SceneBuilder var body: Self.Body { get }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension Scene {

    /// Adds an action to perform when the given value changes.
    ///
    /// Use this modifier to trigger a side effect when a value changes, like
    /// the value associated with an ``SwiftUI/Environment`` key or a
    /// ``SwiftUI/Binding``. For example, you can clear a cache when you notice
    /// that a scene moves to the background:
    ///
    ///     struct MyScene: Scene {
    ///         @Environment(\.scenePhase) private var scenePhase
    ///         @StateObject private var cache = DataCache()
    ///
    ///         var body: some Scene {
    ///             WindowGroup {
    ///                 MyRootView()
    ///             }
    ///             .onChange(of: scenePhase) { newScenePhase in
    ///                 if newScenePhase == .background {
    ///                     cache.empty()
    ///                 }
    ///             }
    ///         }
    ///     }
    ///
    /// The system calls the `action` closure on the main thread, so avoid
    /// long-running tasks in the closure. If you need to perform such tasks,
    /// dispatch to a background queue:
    ///
    ///     .onChange(of: scenePhase) { newScenePhase in
    ///         if newScenePhase == .background {
    ///             DispatchQueue.global(qos: .background).async {
    ///                 // ...
    ///             }
    ///         }
    ///     }
    ///
    /// The system passes the new value into the closure. If you need the old
    /// value, capture it in the closure.
    ///
    /// - Parameters:
    ///   - value: The value to check when determining whether to run the
    ///     closure. The value must conform to the
    ///     <doc://com.apple.documentation/documentation/Swift/Equatable>
    ///     protocol.
    ///   - action: A closure to run when the value changes. The closure
    ///     provides a single `newValue` parameter that indicates the changed
    ///     value.
    ///
    /// - Returns: A scene that triggers an action in response to a change.
    @inlinable public func onChange<V>(of value: V, perform action: @escaping (V) -> Void) -> some Scene where V : Equatable

}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension Scene {

    /// Specifies a modifier to indicate if this Scene can be used
    /// when creating a new Scene for the received External Event.
    ///
    /// This modifier is only supported for WindowGroup Scene types.
    ///
    /// For DocumentGroups, the received External Event must have a URL
    /// for the DocumentGroup to be considered. (Either via openURL, or
    /// the webPageURL property of an NSUserActivity). The UTI for the URL
    /// is implicitly matched against the DocumentGroup's supported types.
    ///
    /// If the modifier evaluates to true, an instance of the
    /// Scene will be used.
    ///
    /// If the modifier evaluates to false, on macOS the Scene
    /// will not be used even if no other Scenes are available.
    /// This case is considered an error. On iOS, the first Scene
    /// specified in the body property for the App will be used.
    ///
    /// If no modifier is set, the Scene will be used if all
    /// other WindowGroups with a modifier evaluate to false.
    ///
    /// On platforms that only allow a single Window/Scene, this method is
    /// ignored.
    ///
    /// - Parameter matching: A Set of Strings that are checked to see
    /// if they are contained in the targetContentIdenfifier. The empty Set
    /// and empty Strings never match. The String value "*" always matches.
    public func handlesExternalEvents(matching conditions: Set<String>) -> some Scene

}

/// A function builder for composing a collection of scenes into a single
/// composite scene.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@_functionBuilder public struct SceneBuilder {

    /// Passes a single scene written as a child scene through unmodified.
    public static func buildBlock<Content>(_ content: Content) -> Content where Content : Scene
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> some Scene where C0 : Scene, C1 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene, C3 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene, C3 : Scene, C4 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene, C3 : Scene, C4 : Scene, C5 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene, C3 : Scene, C4 : Scene, C5 : Scene, C6 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene, C3 : Scene, C4 : Scene, C5 : Scene, C6 : Scene, C7 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene, C3 : Scene, C4 : Scene, C5 : Scene, C6 : Scene, C7 : Scene, C8 : Scene

}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneBuilder {

    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> some Scene where C0 : Scene, C1 : Scene, C2 : Scene, C3 : Scene, C4 : Scene, C5 : Scene, C6 : Scene, C7 : Scene, C8 : Scene, C9 : Scene

}

/// An indication of a scene's operational state.
///
/// The system moves your app's ``Scene`` instances through phases that reflect
/// a scene's operational state. You can trigger actions when the phase changes.
/// Read the current phase by observing the ``EnvironmentValues/scenePhase``
/// value in the ``Environment``:
///
///     @Environment(\.scenePhase) private var scenePhase
///
/// How you interpret the value depends on where it's read from.
/// If you read the phase from inside a ``View`` instance, you obtain a value
/// that reflects the phase of the scene that contains the view. The following
/// example uses the ``SwiftUI/View/onChange(of:perform:)`` method to enable
/// a timer whenever the enclosing scene enters the ``ScenePhase/active`` phase
/// and disable the timer when entering any other phase:
///
///     struct MyView: View {
///         @ObservedObject var model: DataModel
///         @Environment(\.scenePhase) private var scenePhase
///
///         var body: some View {
///             TimerView()
///                 .onChange(of: scenePhase) { phase in
///                     model.isTimerRunning = (phase == .active)
///                 }
///         }
///     }
///
/// If you read the phase from within an ``App`` instance, you obtain an
/// aggregate value that reflects the phases of all the scenes in your app. The
/// app reports a value of ``ScenePhase/active`` if any scene is active, or a
/// value of ``ScenePhase/inactive`` when no scenes are active. This includes
/// multiple scene instances created from a single scene declaration; for
/// example, from a ``WindowGroup``. When an app enters the
/// ``ScenePhase/background`` phase, expect the app to terminate soon after.
/// You can use that opportunity to free any resources:
///
///     @main
///     struct MyApp: App {
///         @Environment(\.scenePhase) private var scenePhase
///
///         var body: some Scene {
///             WindowGroup {
///                 MyRootView()
///             }
///             .onChange(of: scenePhase) { phase in
///                 if phase == .background {
///                     // Perform cleanup when all scenes within
///                     // MyApp go to the background.
///                 }
///             }
///         }
///     }
///
/// If you read the phase from within a custom ``Scene`` instance, the value
/// similarly reflects an aggregation of all the scenes that make up the custom
/// scene:
///
///     struct MyScene: Scene {
///         @Environment(\.scenePhase) private var scenePhase
///
///         var body: some Scene {
///             WindowGroup {
///                 MyRootView()
///             }
///             .onChange(of: scenePhase) { phase in
///                 if phase == .background {
///                     // Perform cleanup when all scenes within
///                     // MyScene go to the background.
///                 }
///             }
///         }
///     }
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public enum ScenePhase : Comparable {

    /// The scene isn't currently visible in the UI.
    ///
    /// Do as little as possible in a scene that's in the `background` phase.
    /// The `background` phase can precede termination, so do any cleanup work
    /// immediately upon entering this state. For example, close any open files
    /// and network connections. However, a scene can also return to the
    /// the ``ScenePhase/active`` phase from the background.
    ///
    /// Expect an app that enters the `background` phase to terminate.
    case background

    /// The scene is in the foreground but should pause its work.
    ///
    /// A scene in this phase doesn't receive events and should pause
    /// timers and free any unnecessary resources. The scene might be completely
    /// hidden in the user interface or otherwise unavailable to the user.
    /// In macOS, scenes only pass through this phase temporarily on their way
    /// to the ``ScenePhase/background`` phase.
    ///
    /// An app or custom scene in this phase contains no scene instances in the
    /// ``ScenePhase/active`` phase.
    case inactive

    /// The scene is in the foreground and interactive.
    ///
    /// An active scene isn't necessarily front-most. For example, a macOS
    /// window might be active even if it doesn't currently have focus.
    /// Nevertheless, all scenes should operate normally in this phase.
    ///
    /// An app or custom scene in this phase contains at least one active scene
    /// instance.
    case active

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: ScenePhase, b: ScenePhase) -> Bool

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

    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func < (a: ScenePhase, b: ScenePhase) -> Bool
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ScenePhase : Hashable {
}

/// A property wrapper type that reads and writes to persisted, per-scene
/// storage.
///
/// You use `SceneStorage` when you need automatic state restoration of the
/// value.  `SceneStorage` works very similar to `State`, except its initial
/// value is restored by the system if it was previously saved, and the value is·
/// shared with other `SceneStorage` variables in the same scene.
///
/// The system manages the saving and restoring of `SceneStorage` on your
/// behalf. The underlying data that backs `SceneStorage` is not available to
/// you, so you must access it via the `SceneStorage` property wrapper. The
/// system makes no guarantees as to when and how often the data will be
/// persisted.
///
/// Each `Scene` has its own notion of `SceneStorage`, so data is not shared
/// between scenes.
///
/// Ensure that the data you use with `SceneStorage` is lightweight. Data of a
/// large size, such as model data, should not be stored in `SceneStorage`, as
/// poor performance may result.
///
/// If the `Scene` is explictly destroyed (e.g. the switcher snapshot is
/// destroyed on iPadOS or the window is closed on macOS), the data is also
/// destroyed. Do not use `SceneStorage` with sensitive data.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@frozen @propertyWrapper public struct SceneStorage<Value> : DynamicProperty {

    /// The underlying value referenced by the state variable.
    ///
    /// This works identically to `State.wrappedValue`.
    ///
    /// - SeeAlso: State.wrappedValue
    public var wrappedValue: Value { get nonmutating set }

    /// A binding to the state value.
    ///
    /// This works identically to `State.projectedValue`.
    ///
    /// - SeeAlso: State.projectedValue
    public var projectedValue: Binding<Value> { get }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneStorage {

    /// Creates a property that can save and restore a boolean.
    ///
    /// - Parameter wrappedValue: The default value if a boolean is not
    ///   available for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value == Bool

    /// Creates a property that can save and restore an integer.
    ///
    /// - Parameter wrappedValue: The default value if an integer is not
    ///   available for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value == Int

    /// Creates a property that can save and restore a double.
    ///
    /// - Parameter wrappedValue: The default value if a double is not available
    ///   for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value == Double

    /// Creates a property that can save and restore a string.
    ///
    /// - Parameter wrappedValue: The default value if a string is not available
    ///   for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value == String

    /// Creates a property that can save and restore a URL.
    ///
    /// - Parameter wrappedValue: The default value if a URL is not available
    ///   for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value == URL

    /// Creates a property that can save and restore data.
    ///
    /// Avoid storing large data blobs, such as image data, as it can negatively
    /// affect performance of your app.
    ///
    /// - Parameter wrappedValue: The default value if data is not available
    ///   for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value == Data

    /// Creates a property that can save and restore an integer, transforming it
    /// to a `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///    enum MyEnum: Int {
    ///        case a
    ///        case b
    ///        case c
    ///    }
    ///    struct MyView: View {
    ///        @SceneStorage("MyEnumValue") private var value = MyEnum.a
    ///        var body: some View { ... }
    ///    }
    ///
    /// - Parameter wrappedValue: The default value if an integer value is not
    ///   available for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value : RawRepresentable, Value.RawValue == Int

    /// Creates a property that can save and restore a string, transforming it
    /// to a `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///    enum MyEnum: String {
    ///        case a
    ///        case b
    ///        case c
    ///    }
    ///    struct MyView: View {
    ///        @SceneStorage("MyEnumValue") private var value = MyEnum.a
    ///        var body: some View { ... }
    ///    }
    ///
    /// - Parameter wrappedValue: The default value if a String value is not
    ///   available for the given key.
    /// - Parameter key: a key used to save and restore the value.
    public init(wrappedValue: Value, _ key: String) where Value : RawRepresentable, Value.RawValue == String
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension SceneStorage where Value : ExpressibleByNilLiteral {

    /// Creates a property that can save and restore an Optional boolean.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// - Parameter key: a key used to save and restore the value.
    public init(_ key: String) where Value == Bool?

    /// Creates a property that can save and restore an Optional integer.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// - Parameter key: a key used to save and restore the value.
    public init(_ key: String) where Value == Int?

    /// Creates a property that can save and restore an Optional double.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// - Parameter key: a key used to save and restore the value.
    public init(_ key: String) where Value == Double?

    /// Creates a property that can save and restore an Optional string.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// - Parameter key: a key used to save and restore the value.
    public init(_ key: String) where Value == String?

    /// Creates a property that can save and restore an Optional URL.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// - Parameter key: a key used to save and restore the value.
    public init(_ key: String) where Value == URL?

    /// Creates a property that can save and restore an Optional data.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// - Parameter key: a key used to save and restore the value.
    public init(_ key: String) where Value == Data?
}
