//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A control for selecting an absolute date.
///
/// It can be configured to only display specific components of the date, but
/// still results in picking a complete `Date` instance.
@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DatePicker<Label> : View where Label : View {

    public typealias Components = DatePickerComponents

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DatePicker {

    /// Creates an instance that selects a `Date` with an unbounded range.
    ///
    /// - Parameters:
    ///   - selection: The date value being displayed and selected.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    ///   - label: A view that describes the use of the date.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(selection: Binding<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date], @ViewBuilder label: () -> Label)

    /// Creates an instance that selects a `Date` in a closed range.
    ///
    /// - Parameters:
    ///   - selection: The date value being displayed and selected.
    ///   - range: The inclusive range of selectable dates.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    ///   - label: A view that describes the use of the date.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(selection: Binding<Date>, in range: ClosedRange<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date], @ViewBuilder label: () -> Label)

    /// Creates an instance that selects a `Date` on or after some start date.
    ///
    /// - Parameters:
    ///   - selection: The date value being displayed and selected.
    ///   - range: The open range from some selectable start date.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    ///   - label: A view that describes the use of the date.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(selection: Binding<Date>, in range: PartialRangeFrom<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date], @ViewBuilder label: () -> Label)

    /// Creates an instance that selects a `Date` on or before some end date.
    ///
    /// - Parameters:
    ///   - selection: The date value being displayed and selected.
    ///   - range: The open range before some selectable end date.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    ///   - label: A view that describes the use of the date.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(selection: Binding<Date>, in range: PartialRangeThrough<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date], @ViewBuilder label: () -> Label)
}

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DatePicker where Label == Text {

    /// Creates an instance that selects a `Date` with an unbounded range.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of `self`, describing
    ///     its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ titleKey: LocalizedStringKey, selection: Binding<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date])

    /// Creates an instance that selects a `Date` in a closed range.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of `self`, describing
    ///     its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - range: The inclusive range of selectable dates.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ titleKey: LocalizedStringKey, selection: Binding<Date>, in range: ClosedRange<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date])

    /// Creates an instance that selects a `Date` on or after some start date.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of `self`, describing
    ///     its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - range: The open range from some selectable start date.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ titleKey: LocalizedStringKey, selection: Binding<Date>, in range: PartialRangeFrom<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date])

    /// Creates an instance that selects a `Date` on or before some end date.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of `self`, describing
    ///     its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - range: The open range before some selectable end date.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init(_ titleKey: LocalizedStringKey, selection: Binding<Date>, in range: PartialRangeThrough<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date])

    /// Creates an instance that selects a `Date` within the given range.
    ///
    /// - Parameters:
    ///   - title: The title of `self`, describing its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init<S>(_ title: S, selection: Binding<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date]) where S : StringProtocol

    /// Creates an instance that selects a `Date` in a closed range.
    ///
    /// - Parameters:
    ///   - title: The title of `self`, describing its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - range: The inclusive range of selectable dates.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init<S>(_ title: S, selection: Binding<Date>, in range: ClosedRange<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date]) where S : StringProtocol

    /// Creates an instance that selects a `Date` on or after some start date.
    ///
    /// - Parameters:
    ///   - title: The title of `self`, describing its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - range: The open range from some selectable start date.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init<S>(_ title: S, selection: Binding<Date>, in range: PartialRangeFrom<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date]) where S : StringProtocol

    /// Creates an instance that selects a `Date` on or before some end date.
    ///
    /// - Parameters:
    ///   - title: The title of `self`, describing its purpose.
    ///   - selection: The date value being displayed and selected.
    ///   - range: The open range before some selectable end date.
    ///   - displayedComponents: The date components that user is able to
    ///     view and edit. Defaults to `[.hourAndMinute, .date]`.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public init<S>(_ title: S, selection: Binding<Date>, in range: PartialRangeThrough<Date>, displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date]) where S : StringProtocol
}

@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DatePickerComponents : OptionSet {

    /// The corresponding value of the raw type.
    ///
    /// A new instance initialized with `rawValue` will be equivalent to this
    /// instance. For example:
    ///
    ///     enum PaperSize: String {
    ///         case A4, A5, Letter, Legal
    ///     }
    ///
    ///     let selectedSize = PaperSize.Letter
    ///     print(selectedSize.rawValue)
    ///     // Prints "Letter"
    ///
    ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
    ///     // Prints "true"
    public let rawValue: UInt

    /// Creates a new option set from the given raw value.
    ///
    /// This initializer always succeeds, even if the value passed as `rawValue`
    /// exceeds the static properties declared as part of the option set. This
    /// example creates an instance of `ShippingOptions` with a raw value beyond
    /// the highest element, with a bit mask that effectively contains all the
    /// declared static members.
    ///
    ///     let extraOptions = ShippingOptions(rawValue: 255)
    ///     print(extraOptions.isStrictSuperset(of: .all))
    ///     // Prints "true"
    ///
    /// - Parameter rawValue: The raw value of the option set to create. Each bit
    ///   of `rawValue` potentially represents an element of the option set,
    ///   though raw values may include bits that are not defined as distinct
    ///   values of the `OptionSet` type.
    public init(rawValue: UInt)

    /// Displays hour and minute components based on the locale
    public static let hourAndMinute: DatePickerComponents

    /// Displays day, month, and year based on the locale
    public static let date: DatePickerComponents

    /// The element type of the option set.
    ///
    /// To inherit all the default implementations from the `OptionSet` protocol,
    /// the `Element` type must be `Self`, the default.
    public typealias Element = DatePickerComponents

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = UInt

    /// The type of the elements of an array literal.
    public typealias ArrayLiteralElement = DatePickerComponents
}

/// A specification for the appearance and interaction of a `DatePicker`.
@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol DatePickerStyle {
}

/// The default `DatePicker` style.
@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DefaultDatePickerStyle : DatePickerStyle {

    public init()
}

/// A system style of `DatePicker` that displays an interactive calendar or
/// clock.
///
/// This style is useful when wanting to allow browsing through days in a
/// calendar, or when the look of a clock face is appropriate.
@available(iOS 14.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct GraphicalDatePickerStyle : DatePickerStyle {

    public init()
}


/// A system style of date picker that displays each component as columns
/// in a scrollable wheel.
@available(iOS 13.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct WheelDatePickerStyle : DatePickerStyle {

    public init()
}


/// A system style that displays the components in a compact, textual format.
///
/// This style is useful when space is constrained and users expect to
/// make specific date and time selections. Some variants may include rich
/// editing controls in a popup.
@available(iOS 14.0, macCatalyst 13.4, macOS 10.15.4, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct CompactDatePickerStyle : DatePickerStyle {

    public init()
}



@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Sets the style for date pickers within this view.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func datePickerStyle<S>(_ style: S) -> some View where S : DatePickerStyle

}
