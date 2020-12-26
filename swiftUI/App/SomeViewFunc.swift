//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Binds a view's identity to the given proxy value.
    ///
    /// When the proxy value specified by the `id` parameter changes, the
    /// identity of the view — for example, its state — is reset.
    @inlinable public func id<ID>(_ id: ID) -> some View where ID : Hashable

}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the unique tag value of this view.
    ///
    /// Use `tag(_:)` to differentiate between a number of views for the purpose
    /// of selecting controls like pickers and lists. Tag values can be of any
    /// type that conforms to the <doc://com.apple.documentation/documentation/Swift/Hashable>
    /// protocol.
    ///
    /// In the example below, the ``ForEach`` loop in the ``Picker`` view
    /// builder iterates over the `Flavor` enumeration. It extracts the text raw
    /// value of each enumeration element for use as the row item label and uses
    /// the enumeration item itself as input to the `tag(_:)` modifier.
    /// The tag identifier can be any value that conforms to the
    /// <doc://com.apple.documentation/documentation/Swift/Hashable> protocol:
    ///
    ///     struct FlavorPicker: View {
    ///         enum Flavor: String, CaseIterable, Identifiable {
    ///             var id: String { self.rawValue }
    ///             case vanilla, chocolate, strawberry
    ///         }
    ///
    ///         @State private var selectedFlavor: Flavor? = nil
    ///         var body: some View {
    ///             Picker("Flavor", selection: $selectedFlavor) {
    ///                 ForEach(Flavor.allCases) {
    ///                     Text($0.rawValue).tag($0)
    ///                 }
    ///             }
    ///         }
    ///     }
    ///
    /// - SeeAlso: `List`, `Picker`, `Hashable`
    /// - Parameter tag: A <doc://com.apple.documentation/documentation/Swift/Hashable> value
    ///   to use as the view's tag.
    ///
    /// - Returns: A view with the specified tag set.
    @inlinable public func tag<V>(_ tag: V) -> some View where V : Hashable

}



@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Hides this view.
    ///
    /// Hidden views are invisible and can't receive or respond to interactions.
    ///
    /// - Returns: A hidden view.
    @inlinable public func hidden() -> some View

}

extension View {

    /// Hides the labels of any controls contained within this view.
    ///
    /// Use `labelsHidden()` when it would not be appropriate to show a
    /// label near controls in the context of your user interface.
    ///
    /// Although the labels are not visually laid out alongside the controls,
    /// the control's label text is still often required, because it is used
    /// for other purposes including accessibility. This example shows two
    /// controls where the first control’s label is hidden.
    ///
    /// In the example below, one of the toggles has its label hidden:
    ///
    ///     VStack {
    ///         Toggle(isOn: $toggle1) {
    ///             Text("Toggle1")
    ///         }
    ///         .labelsHidden()
    ///
    ///         Toggle(isOn: $toggle2) {
    ///             Text("Toggle2")
    ///         }
    ///     }
    ///
    /// ![A screenshot showing a view with two toggle controls where one label
    ///   is visible and the other label is hidden.](SwiftUI-Vew-labelsHidden.png)
    ///
    /// > Note: This modifier does not work for all labels. It applies to
    ///   labels that are external/separate from the rest of the control's
    ///   interface like `Toggle`, but not to controls like a bordered button
    ///   where the label is inside the button's border.
    public func labelsHidden() -> some View

}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Adds a condition for whether the view's view hierarchy is deletable.
    @inlinable public func deleteDisabled(_ isDisabled: Bool) -> some View

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Adds a condition for whether the view's view hierarchy is movable.
    @inlinable public func moveDisabled(_ isDisabled: Bool) -> some View

}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Adds a condition that controls whether users can interact with this
    /// view.
    ///
    /// The higher views in a view hierarchy can override the value you set on
    /// this view. In the following example, the button isn't interactive
    /// because the outer `disabled(_:)` modifier overrides the inner one:
    ///
    ///     HStack {
    ///         Button(Text("Press")) {}
    ///         .disabled(false)
    ///     }
    ///     .disabled(true)
    ///
    /// - Parameter disabled: A Boolean value that determines whether users can
    ///   interact with this view.
    ///
    /// - Returns: A view that controls whether users can interact with this
    ///   view.
    @inlinable public func disabled(_ disabled: Bool) -> some View

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Adds an action to perform when this view detects data emitted by the
    /// given publisher.
    ///
    /// - Parameters:
    ///   - publisher: The publisher to subscribe to.
    ///   - action: The action to perform when an event is emitted by
    ///     `publisher`. The event emitted by publisher is passed as a
    ///     parameter to `action`.
    ///
    /// - Returns: A view that triggers `action` when `publisher` emits an
    ///   event.
    @inlinable public func onReceive<P>(_ publisher: P, perform action: @escaping (P.Output) -> Void) -> some View where P : Publisher, P.Failure == Never

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Configures whether this view participates in hit test operations.
    @inlinable public func allowsHitTesting(_ enabled: Bool) -> some View

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Adds an action to perform when this view appears.
    ///
    /// - Parameter action: The action to perform. If `action` is `nil`, the
    ///   call has no effect.
    ///
    /// - Returns: A view that triggers `action` when this view appears.
    @inlinable public func onAppear(perform action: (() -> Void)? = nil) -> some View


    /// Adds an action to perform when this view disappears.
    ///
    /// - Parameter action: The action to perform. If `action` is `nil`, the
    ///   call has no effect.
    ///
    /// - Returns: A view that triggers `action` when this view disappears.
    @inlinable public func onDisappear(perform action: (() -> Void)? = nil) -> some View

}


extension View {

    /// Sets whether to disable autocorrection for this view.
    ///
    /// Use `disableAutocorrection(_:)` when the effect of autocorrection would
    /// make it more difficult for the user to input information. The entry of
    /// proper names and street addresses are examples where autocorrection can
    /// negatively affect the user's ability complete a data entry task.
    ///
    /// In the example below configures a ``TextField`` with the `.default`
    /// keyboard. Disabling autocorrection allows the user to enter arbitrary
    /// text without the autocorrection system offering suggestions or
    /// attempting to override their input.
    ///
    ///     TextField("1234 Main St.", text: $address)
    ///         .keyboardType(.default)
    ///         .disableAutocorrection(true)
    ///
    /// - Parameter enabled: A Boolean value that indicates whether
    ///   autocorrection is disabled for this view.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
    @available(watchOS, unavailable)
    public func disableAutocorrection(_ disable: Bool?) -> some View

}

@available(iOS 13.0, watchOS 6.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
extension View {

    /// Sets the visibility of the status bar.
    ///
    /// Use `statusBar(hidden:)` to show or hide the status bar.
    ///
    /// - Parameter hidden: A Boolean value that indicates whether to hide the
    ///   status bar.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func statusBar(hidden: Bool) -> some View

}
