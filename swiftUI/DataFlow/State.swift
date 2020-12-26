//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A property wrapper type that can read and write a value managed by SwiftUI.
///
/// SwiftUI manages the storage of any property you declare as a state. When the
/// state value changes, the view invalidates its appearance and recomputes the
/// body. Use the state as the single source of truth for a given view.
///
/// A ``State`` instance isn't the value itself; it's a means of reading and
/// writing the value. To access a state's underlying value, use its variable
/// name, which returns the ``State/wrappedValue`` property value.
///
/// You should only access a state property from inside the view's body, or from
/// methods called by it. For this reason, declare your state properties as
/// private, to prevent clients of your view from accessing them. It is safe to
/// mutate state properties from any thread.
///
/// To pass a state property to another view in the view hierarchy, use the
/// variable name with the `$` prefix operator. This retrieves a binding of the
/// state property from its ``State/projectedValue`` property. For example, in
/// the following code example `PlayerView` passes its state property
/// `isPlaying` to `PlayButton` using `$isPlaying`:
///
///     struct PlayerView: View {
///         var episode: Episode
///         @State private var isPlaying: Bool = false
///
///         var body: some View {
///             VStack {
///                 Text(episode.title)
///                 Text(episode.showTitle)
///                 PlayButton(isPlaying: $isPlaying)
///             }
///         }
///     }
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen @propertyWrapper public struct State<Value> : DynamicProperty {

    /// Creates the state with an initial wrapped value.
    ///
    /// You don't call this initializer directly. Instead, declare a property
    /// with the `@State` attribute, and provide an initial value; for example,
    /// `@State private var isPlaying: Bool = false`.
    ///
    /// - Parameter wrappedValue: An initial wrappedValue for a state.
    public init(wrappedValue value: Value)

    /// Creates the state with an initial value.
    ///
    /// - Parameter value: An initial value of the state.
    public init(initialValue value: Value)

    /// The underlying value referenced by the state variable.
    ///
    /// This property provides primary access to the value's data. However, you
    /// don't access `wrappedValue` directly. Instead, you use the property
    /// variable created with the `@State` attribute. For example, in the
    /// following code example the button's actions toggles the value of
    /// `showingProfile`, which toggles `wrappedValue`:
    ///
    ///     @State private var showingProfile = false
    ///
    ///     var profileButton: some View {
    ///         Button(action: { self.showingProfile.toggle() }) {
    ///             Image(systemName: "person.crop.circle")
    ///                 .imageScale(.large)
    ///                 .accessibilityLabel(Text("User Profile"))
    ///                 .padding()
    ///         }
    ///     }
    ///
    /// When a mutable binding value changes, the new value is immediately
    /// available. However, updates to a view displaying the value happens
    /// asynchronously, so the view may not show the change immediately.
    public var wrappedValue: Value { get nonmutating set }

    /// A binding to the state value.
    ///
    /// Use the projected value to pass a binding value down a view hierarchy.
    /// To get the `projectedValue`, prefix the property variable with `$`. For
    /// example, in the following code example `PlayerView` projects a binding
    /// of the state property `isPlaying` to the `PlayButton` view using
    /// `$isPlaying`.
    ///
    ///     struct PlayerView: View {
    ///         var episode: Episode
    ///         @State private var isPlaying: Bool = false
    ///
    ///         var body: some View {
    ///             VStack {
    ///                 Text(episode.title)
    ///                 Text(episode.showTitle)
    ///                 PlayButton(isPlaying: $isPlaying)
    ///             }
    ///         }
    ///     }
    public var projectedValue: Binding<Value> { get }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension State where Value : ExpressibleByNilLiteral {

    /// Creates a state without an initial value.
    @inlinable public init()
}

/// A property wrapper type that instantiates an observable object.
///
/// Create a state object in a ``SwiftUI/View``, ``SwiftUI/App``, or
/// ``SwiftUI/Scene`` by applying the `@StateObject` attribute to a property
/// declaration and providing an initial value that conforms to the
/// <doc://com.apple.documentation/documentation/Combine/ObservableObject>
/// protocol:
///
///     @StateObject var model = DataModel()
///
/// SwiftUI creates a new instance of the object only once for each instance of
/// the structure that declares the object. When published properties of the
/// observable object change, SwiftUI updates the parts of any view that depend
/// on those properties:
///
///     Text(model.title) // Updates the view any time `title` changes.
///
/// You can pass the state object into a property that has the
/// ``SwiftUI/ObservedObject`` attribute. You can alternatively add the object
/// to the Environment of a view hierarchy by applying the
/// ``SwiftUI/View/environmentObject(_:)`` modifier:
///
///     ContentView()
///         .environmentObject(model)
///
/// If you create an environment object as shown in the code above, you can
/// read the object inside `ContentView` or any of its descendants
/// using the ``SwiftUI/EnvironmentObject`` attribute:
///
///     @EnvironmentObject var model: DataModel
///
/// Get a ``SwiftUI/Binding`` to one of the state object's properties using the
/// `$` operator. Use a binding when you want to create a two-way connection to
/// one of the object's properties. For example, you can let a
/// ``SwiftUI/Toggle`` control a Boolean value called `isEnabled` stored in the
/// model:
///
///     Toggle("Enabled", isOn: $model.isEnabled)
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
@frozen @propertyWrapper public struct StateObject<ObjectType> : DynamicProperty where ObjectType : ObservableObject {

    /// Creates a new state object with an initial wrapped value.
    ///
    /// You don’t call this initializer directly. Instead, declare a property
    /// with the `@StateObject` attribute in a ``SwiftUI/View``,
    /// ``SwiftUI/App``, or ``SwiftUI/Scene``, and provide an initial value:
    ///
    ///     struct MyView: View {
    ///         @StateObject var model = DataModel()
    ///
    ///         // ...
    ///     }
    ///
    /// SwiftUI creates only one instance of the state object for each
    /// container instance that you declare. In the code above, SwiftUI
    /// creates `model` only the first time it initializes a particular instance
    /// of `MyView`. On the other hand, each different instance of `MyView`
    /// receives a distinct copy of the data model.
    ///
    /// - Parameter thunk: An initial value for the state object.
    @inlinable public init(wrappedValue thunk: @autoclosure @escaping () -> ObjectType)

    /// The underlying value referenced by the state object.
    ///
    /// The wrapped value property provides primary access to the value's data.
    /// However, you don't access `wrappedValue` directly. Instead, use the
    /// property variable created with the `@StateObject` attribute:
    ///
    ///     @StateObject var contact = Contact()
    ///
    ///     var body: some View {
    ///         Text(contact.name) // Accesses contact's wrapped value.
    ///     }
    ///
    /// When you change a property of the wrapped value, you can access the new
    /// value immediately. However, SwiftUI updates views displaying the value
    /// asynchronously, so the user interface might not update immediately.
    public var wrappedValue: ObjectType { get }

    /// A projection of the state object that creates bindings to its
    /// properties.
    ///
    /// Use the projected value to pass a binding value down a view hierarchy.
    /// To get the projected value, prefix the property variable with `$`. For
    /// example, you can get a binding to a model's `isEnabled` Boolean so that
    /// a ``SwiftUI/Toggle`` view can control the value:
    ///
    ///     struct MyView: View {
    ///         @StateObject var model = DataModel()
    ///
    ///         var body: some View {
    ///             Toggle("Enabled", isOn: $model.isEnabled)
    ///         }
    ///     }
    public var projectedValue: ObservedObject<ObjectType>.Wrapper { get }
}
