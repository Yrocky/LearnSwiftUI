//
//  Layout.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A storage type for an action sheet presentation.
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@available(macOS, unavailable)
public struct ActionSheet {

    /// Creates an action sheet with the provided buttons.
    public init(title: Text, message: Text? = nil, buttons: [ActionSheet.Button] = [.cancel()])

    /// A button representing an operation of an action sheet presentation.
    public typealias Button = Alert.Button
}

/// A representation for an alert presentation.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct Alert {

    /// Creates an alert with one button.
    public init(title: Text, message: Text? = nil, dismissButton: Alert.Button? = nil)

    /// Creates an alert with two buttons.
    ///
    /// The system determines the visual ordering of the buttons.
    public init(title: Text, message: Text? = nil, primaryButton: Alert.Button, secondaryButton: Alert.Button)

    /// A button representing an operation of an alert presentation.
    public struct Button {

        /// Creates an `Alert.Button` with the default style.
        public static func `default`(_ label: Text, action: (() -> Void)? = {}) -> Alert.Button

        /// Creates an `Alert.Button` that indicates cancellation of some
        /// operation.
        public static func cancel(_ label: Text, action: (() -> Void)? = {}) -> Alert.Button

        /// An alert button that indicates cancellation.
        ///
        /// The system automatically chooses the label of the button for the
        /// appropriate locale.
        public static func cancel(_ action: (() -> Void)? = {}) -> Alert.Button

        /// Creates an `Alert.Button` with a style indicating destruction of
        /// some data.
        public static func destructive(_ label: Text, action: (() -> Void)? = {}) -> Alert.Button
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Presents an alert to the user.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the alert.
    ///     When representing a non-`nil` item, the system uses `content` to
    ///     create an alert representation of the item.
    ///     If the identity changes, the system dismisses a
    ///     currently-presented alert and replace it by a new alert.
    ///   - content: A closure returning the alert to present.
    public func alert<Item>(item: Binding<Item?>, content: (Item) -> Alert) -> some View where Item : Identifiable


    /// Presents an alert to the user.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the alert should be shown.
    ///   - content: A closure returning the alert to present.
    public func alert(isPresented: Binding<Bool>, content: () -> Alert) -> some View

}


extension View {

    /// Presents an action sheet using the given item as a data source for the
    /// sheet's content.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the action
    ///     sheet. When representing a non-`nil` item, the system uses
    ///     `content` to create an action sheet representation of the item.
    ///     If the identity changes, the system dismisses a currently-presented
    ///     action sheet and replace it with a new one.
    ///   - content: A closure returning the action sheet to present.
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    @available(macOS, unavailable)
    public func actionSheet<T>(item: Binding<T?>, content: (T) -> ActionSheet) -> some View where T : Identifiable


    /// Presents an action sheet when a given condition is true.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the action sheet should be
    ///     shown.
    ///   - content: A closure returning the `ActionSheet` to present.
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    @available(macOS, unavailable)
    public func actionSheet(isPresented: Binding<Bool>, content: () -> ActionSheet) -> some View

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Presents a sheet using the given item as a data source
    /// for the sheet's content.
    ///
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the sheet.
    ///     When representing a non-`nil` item, the system uses `content` to
    ///     create a sheet representation of the item.
    ///     If the identity changes, the system dismisses a
    ///     currently-presented sheet and replaces it with a new sheet.
    ///   - onDismiss: A closure executed when the sheet dismisses.
    ///   - content: A closure returning the content of the sheet.
    public func sheet<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View


    /// Presents a sheet when a given condition is true.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the sheet is presented.
    ///   - onDismiss: A closure executed when the sheet dismisses.
    ///   - content: A closure returning the content of the sheet.
    public func sheet<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View

}
