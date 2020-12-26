//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A control into which the user securely enters private text.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct SecureField<Label> : View where Label : View {

    /// The content and behavior of the view.
    public var body: some View { get }

    /// The type of view representing the body of this view.
    ///
    /// When you create a custom view, Swift infers this type from your
    /// implementation of the required `body` property.
    public typealias Body = some View
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SecureField where Label == Text {

    /// Creates an instance.
    ///
    /// - Parameters:
    ///   - titleKey: The key for the localized title of `self`, describing
    ///     its purpose.
    ///   - text: The text to be displayed and edited.
    ///   - onCommit: The action to perform when the user performs an action
    ///     (usually the return key) while the `SecureField` has focus.
    public init(_ titleKey: LocalizedStringKey, text: Binding<String>, onCommit: @escaping () -> Void = {})

    /// Creates an instance.
    ///
    /// - Parameters:
    ///   - title: The title of `self`, describing its purpose.
    ///   - text: The text to be displayed and edited.
    ///   - onCommit: The action to perform when the user performs an action
    ///     (usually the return key) while the `SecureField` has focus.
    public init<S>(_ title: S, text: Binding<String>, onCommit: @escaping () -> Void = {}) where S : StringProtocol
}
