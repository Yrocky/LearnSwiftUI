//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A control that displays an editable text interface.
///
/// You can customize the appearance and interaction of a text field using a
/// ``TextFieldStyle`` instance. The system resolves this configuration at
/// runtime. Each platform provides a default style that reflects the platform
/// style, but you can provide a new style that redefines all text field
/// instances within a particular environment.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct TextField<Label> : View where Label : View {

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension TextField where Label == Text {

    /// Creates a text field with a text label generated from a localized title
    /// string.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of the text field,
    ///     describing its purpose.
    ///   - text: The text to be displayed and edited.
    ///   - onEditingChanged: An action thats called when the user
    ///     begins editing `text` and after the user finishes editing `text`.
    ///     The closure recieves a Boolean indicating whether the text field is
    ///     currently being edited.
    ///   - onCommit: An action to perform when the user performs an action
    ///     (for example, when the user hits the return key) while the text
    ///     field has focus.
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {})

    /// Creates a text field with a text label generated from a title string.
    ///
    /// - Parameters:
    ///   - title: The title of the text view, describing its purpose.
    ///   - text: The text to be displayed and edited.
    ///   - onEditingChanged: An action thats called when the user
    ///     begins editing `text` and after the user finishes editing `text`.
    ///     The closure recieves a Boolean indicating whether the text field is
    ///     currently being edited.
    ///   - onCommit: An action to perform when the user performs an action
    ///     (for example, when the user hits the return key) while the text
    ///     field has focus.
    public init<S>(_ title: S, text: Binding<String>, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) where S : StringProtocol

    /// Create an instance which binds over an arbitrary type, `T`.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of the text field,
    ///     describing its purpose.
    ///   - value: The underlying value to be edited.
    ///   - formatter: A formatter to use when converting between the
    ///     string the user edits and the underlying value of type `T`.
    ///     In the event that `formatter` is unable to perform the conversion,
    ///     `binding.value` isn't modified.
    ///   - onEditingChanged: An action thats called when the user
    ///     begins editing `text` and after the user finishes editing `text`.
    ///     The closure recieves a Boolean indicating whether the text field is
    ///     currently being edited.
    ///   - onCommit: An action to perform when the user performs an action
    ///     (for example, when the user hits the return key) while the text
    ///     field has focus.
    public init<T>(_ titleKey: LocalizedStringKey, value: Binding<T>, formatter: Formatter, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {})

    /// Create an instance which binds over an arbitrary type, `T`.
    ///
    /// - Parameters:
    ///   - title: The title of the text field, describing its purpose.
    ///   - value: The underlying value to be edited.
    ///   - formatter: A formatter to use when converting between the
    ///     string the user edits and the underlying value of type `T`.
    ///     In the event that `formatter` is unable to perform the conversion,
    ///     `binding.value` isn't modified.
    ///   - onEditingChanged: An action thats called when the user
    ///     begins editing `text` and after the user finishes editing `text`.
    ///     The closure recieves a Boolean indicating whether the text field is
    ///     currently being edited.
    ///   - onCommit: An action to perform when the user performs an action
    ///     (for example, when the user hits the return key) while the text
    ///     field has focus.
    public init<S, T>(_ title: S, value: Binding<T>, formatter: Formatter, onEditingChanged: @escaping (Bool) -> Void = { _ in }, onCommit: @escaping () -> Void = {}) where S : StringProtocol
}

/// A specification for the appearance and interaction of a text field.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol TextFieldStyle {
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct DefaultTextFieldStyle : TextFieldStyle {

    public init()
}

/// A text field style with no decoration.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct PlainTextFieldStyle : TextFieldStyle {

    public init()
}


/// A text field style with a system-defined rounded border.
@available(iOS 13.0, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct RoundedBorderTextFieldStyle : TextFieldStyle {

    public init()
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {

    /// Sets the style for text fields within this view.
    public func textFieldStyle<S>(_ style: S) -> some View where S : TextFieldStyle

}


extension View {

    /// Sets the text content type for this view, which the system uses to
    /// offer suggestions while the user enters text on an iOS or tvOS device.
    ///
    /// Use `textContentType(_:)` to set the content type for this view.
    ///
    /// This example configures the `TextField` for the entry of email
    /// addresses:
    ///
    ///     TextField("billjames2@icloud.com", text: $emailAddress)
    ///         .textContentType(.emailAddress)
    ///     }
    ///
    /// - Parameter textContentType: One of the content types available in the
    ///   `UITextContentType` enumeration that identify the semantic meaning
    ///     expected for a text-entry area. These include support for email
    ///     addresses, location names, URLs, and telephone numbers to name
    ///     just a few.
    @available(iOS 13.0, tvOS 13.0, *)
    @available(macOS, unavailable)
    @available(watchOS, unavailable)
    @inlinable public func textContentType(_ textContentType: UITextContentType?) -> some View

}

