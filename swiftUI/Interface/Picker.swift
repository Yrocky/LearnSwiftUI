//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation



/// A control for selecting from a set of mutually exclusive values.
///
/// You create a picker by providing a selection binding, a label, and the
/// content for the picker to display. Set the `selection` parameter to a bound
/// property that provides the value to display as the current selection. Set
/// the label to a view that visually describes the purpose of selecting content
/// in the picker, and then provide the content for the picker to display.
///
/// For example, consider the following enumeration of ice cream flavors:
///
///     enum Flavor: String, CaseIterable, Identifiable {
///         case chocolate
///         case vanilla
///         case strawberry
///
///         var id: String { self.rawValue }
///     }
///
/// You can create a picker to select among these values by providing ``Text``
/// views in the picker initializer's content. You can optionally provide a
/// string as the first parameter; if you do, the picker creates a ``Text``
/// label using this string:
///
///     @State private var selectedFlavor = Flavor.chocolate
///
///     Picker("Flavor", selection: $selectedFlavor) {
///         Text("Chocolate").tag(Flavor.chocolate)
///         Text("Vanilla").tag(Flavor.vanilla)
///         Text("Strawberry").tag(Flavor.strawberry)
///     }
///     Text("Selected flavor: \(selectedFlavor.rawValue)")
///
/// You append a tag to each text view so that the type of each selection
/// matches the type of the bound state variable.
///
/// ### Iterating Over a Picker’s Options
///
/// To provide selection values for the `Picker` without explicitly listing
/// each option, you can create the picker with a ``ForEach`` construct, like
/// this:
///
///     Picker("Flavor", selection: $selectedFlavor) {
///         ForEach(Flavor.allCases) { flavor in
///             Text(flavor.rawValue.capitalized)
///         }
///     }
///
/// In this case, ``ForEach`` automatically assigns a tag to the selection
/// views, using each option's `id`, which it can do because `Flavor` conforms
/// to the <doc://com.apple.documentation/documentation/Swift/Identifiable>
/// protocol.
///
/// On the other hand, if the selection type doesn't match the input to the
/// ``ForEach``, you need to provide an explicit tag. The following example
/// shows a picker that's bound to a `Topping` type, even though the options
/// are all `Flavor` instances. Each option uses ``View/tag(_:)`` to associate
/// a topping with the flavor it displays.
///
///     enum Topping: String, CaseIterable, Identifiable {
///         case nuts
///         case cookies
///         case blueberries
///
///         var id: String { self.rawValue }
///     }
///     extension Flavor {
///         var suggestedTopping: Topping {
///             switch self {
///             case .chocolate: return .nuts
///             case .vanilla: return .cookies
///             case .strawberry: return .blueberries
///             }
///         }
///     }
///     @State var suggestedTopping: Topping = .cookies
///
///     Picker("Suggest a topping for:", selection: $suggestedTopping) {
///         ForEach(Flavor.allCases) { flavor in
///             Text(flavor.rawValue.capitalized)
///                 .tag(flavor.suggestedTopping)
///         }
///     }
///     Text("suggestedTopping: \(suggestedTopping.rawValue)")
///
/// ### Styling Pickers
///
/// You can customize the appearance and interaction of pickers by creating
/// styles that conform to the ``PickerStyle`` protocol. You create your own style
/// or use one of the styles provided by SwiftUI, like ``SegmentedPickerStyle``
/// or ``PopUpButtonPickerStyle``.
///
/// To set a specific style for all picker instances within a view, use the
/// ``View/pickerStyle(_:)`` modifier. The following example adds a second binding
/// type, `Topping`, and applies the ``SegmentedPickerStyle`` to two pickers:
///
///     @State private var selectedFlavor = Flavor.chocolate
///     @State private var selectedTopping = Topping.nuts
///
///     VStack {
///         Picker("Flavor", selection: $selectedFlavor) {
///             ForEach(Flavor.allCases) { flavor in
///                 Text(flavor.rawValue.capitalized)
///             }
///         }
///         Picker("Topping", selection: $selectedTopping) {
///             ForEach(Topping.allCases) { flavor in
///                 Text(flavor.rawValue.capitalized)
///             }
///         }
///
///         Text("Selected flavor: \(selectedFlavor.rawValue)")
///         Text("Selected toppping: \(selectedTopping.rawValue)")
///     }
///     .pickerStyle(SegmentedPickerStyle())
///
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Picker<Label, SelectionValue, Content> : View where Label : View, SelectionValue : Hashable, Content : View {

    /// Creates a picker that displays a custom label.
    ///
    /// - Parameters:
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - label: A view that describes the purpose of selecting an option.
    ///     - content: A view that contains the set of options.
    public init(selection: Binding<SelectionValue>, label: Label, @ViewBuilder content: () -> Content)

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Picker where Label == Text {

    /// Creates a picker that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///     - titleKey: A localized string key that describes the purpose of
    ///       selecting an option.
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - content: A view that contains the set of options.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// localized key similar to ``Text/init(_:tableName:bundle:comment:)``. See
    /// ``Text`` for more information about localizing strings.
    ///
    /// To initialize a picker with a string variable, use
    /// ``init(_:selection:content:)-5njtq`` instead.
    public init(_ titleKey: LocalizedStringKey, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content)

    /// Creates a picker that generates its label from a string.
    ///
    /// - Parameters:
    ///     - title: A string that describes the purpose of selecting an option.
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - content: A view that contains the set of options.
    ///
    /// This initializer creates a ``Text`` view on your behalf, and treats the
    /// title similar to ``Text/init(_:)-9d1g4``. See ``Text`` for more
    /// information about localizing strings.
    ///
    /// To initialize a picker with a localized string key, use
    /// ``init(_:selection:content:)-6lwfn`` instead.
    public init<S>(_ title: S, selection: Binding<SelectionValue>, @ViewBuilder content: () -> Content) where S : StringProtocol
}

/// A type that specifies the appearance and interaction of all pickers within
/// a view hierarchy.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol PickerStyle {
}


/// The default picker style, based on the picker's context.
///
/// How a picker using the default picker style appears largely depends on the
/// platform and the view type in which it appears. For example, in a standard
/// view, the default picker styles by platform are:
///
/// * On iOS and watchOS the default is a wheel.
/// * On macOS, the default is a pop-up button.
/// * On tvOS, the default is a segmented control.
///
/// The default picker style may also take into account other factors — like
/// whether the picker appears in a container view — when setting the appearance
/// of a picker.
///
/// You can override a picker’s style. To apply the default style to a picker,
/// or to a view that contains pickers, use the ``View/pickerStyle(_:)`` modifier.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct DefaultPickerStyle : PickerStyle {

    /// Creates a default picker style.
    public init()
}

/// A `PickerStyle` where each option is displayed inline with
/// other views in the current container.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct InlinePickerStyle : PickerStyle {

    /// Creates an inline picker style.
    public init()
}

/// A picker style that presents the options as a menu when the user presses a
/// button, or as a submenu when nested within a larger menu.
///
/// Use this style when there are more than five options. Consider using
/// ``InlinePickerStyle`` when there are fewer than five options.
///
/// The button itself indicates the selected option. You can include additional
/// controls in the set of options, such as a button to customize the list of
/// options.
///
/// To apply this style to a picker, or to a view that contains pickers, use the
/// ``View/pickerStyle(_:)`` modifier.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct MenuPickerStyle : PickerStyle {

    /// Creates a menu picker style.
    public init()
}

/// A picker style that presents the options in a scrollable wheel that shows
/// the selected option and a few neighboring options.
///
/// Because most options aren't visible, organize them in a predictable order,
/// such as alphabetically.
///
/// To apply this style to a picker, or to a view that contains pickers, use the
/// ``View/pickerStyle(_:)`` modifier.
@available(iOS 13.0, watchOS 6.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
public struct WheelPickerStyle : PickerStyle {

    /// Sets the picker style to display an item wheel from which the user makes
    /// a selection.
    public init()
}

/// A picker style that presents the options in a segmented control.
///
/// To apply this style to a picker, or to a view that contains pickers, use the
/// ``View/pickerStyle(_:)`` modifier.
///
/// > Note: The segmented picker style supports ``Text`` and ``Image`` segments only.
/// Any other view results in a visible, but empty, segment.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
@available(watchOS, unavailable)
public struct SegmentedPickerStyle : PickerStyle {

    /// Creates a segmented picker style.
    public init()
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the style for pickers within this view.
    public func pickerStyle<S>(_ style: S) -> some View where S : PickerStyle

}
