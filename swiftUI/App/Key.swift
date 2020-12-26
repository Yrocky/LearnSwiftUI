//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A set of key modifiers that you can add to a gesture.
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
@frozen public struct EventModifiers : OptionSet {

    /// The raw value.
    public let rawValue: Int

    /// Creates a new set from a raw value.
    ///
    /// - Parameter rawValue: The raw value with which to create the key
    ///   modifier.
    public init(rawValue: Int)

    /// The Caps Lock key.
    public static let capsLock: EventModifiers

    /// The Shift key.
    public static let shift: EventModifiers

    /// The Control key.
    public static let control: EventModifiers

    /// The Option key.
    public static let option: EventModifiers

    /// The Command key.
    public static let command: EventModifiers

    /// Any key on the numeric keypad.
    public static let numericPad: EventModifiers

    /// The Function key.
    public static let function: EventModifiers

    /// All possible modifier keys.
    public static let all: EventModifiers

    /// The raw type that can be used to represent all values of the conforming
    /// type.
    ///
    /// Every distinct value of the conforming type has a corresponding unique
    /// value of the `RawValue` type, but there may be values of the `RawValue`
    /// type that don't have a corresponding value of the conforming type.
    public typealias RawValue = Int

    /// The element type of the option set.
    ///
    /// To inherit all the default implementations from the `OptionSet` protocol,
    /// the `Element` type must be `Self`, the default.
    public typealias Element = EventModifiers

    /// The type of the elements of an array literal.
    public typealias ArrayLiteralElement = EventModifiers
}


/// Key equivalents consist of a letter, punctuation, or function key that can
/// be combined with an optional set of modifier keys to specify a keyboard
/// shortcut.
///
/// Key equivalents are used to establish keyboard shortcuts to app
/// functionality. Any key can be used as a key equivalent as long as pressing
/// it produces a single character value. Key equivalents are typically
/// initialized using a single-character string literal, with constants for
/// unprintable or hard-to-type values.
///
/// The modifier keys necessary to type a key equivalent are factored in to the
/// resulting keyboard shortcut. That is, a key equivalent whose raw value is
/// the capitalized string "A" corresponds with the keyboard shortcut
/// Command-Shift-A. The exact mapping may depend on the keyboard layout—for
/// example, a key equivalent whith the character value "}" produces a shortcut
/// equivalent to Command-Shift-] on ANSI keyboards, but would produce a
/// different shortcut for keyboard layouts where punctuation characters are in
/// different locations.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct KeyEquivalent {

    /// Up Arrow (U+F700)
    public static let upArrow: KeyEquivalent

    /// Down Arrow (U+F701)
    public static let downArrow: KeyEquivalent

    /// Left Arrow (U+F702)
    public static let leftArrow: KeyEquivalent

    /// Right Arrow (U+F703)
    public static let rightArrow: KeyEquivalent

    /// Escape (U+001B)
    public static let escape: KeyEquivalent

    /// Delete (U+0008)
    public static let delete: KeyEquivalent

    /// Delete Forward (U+F728)
    public static let deleteForward: KeyEquivalent

    /// Home (U+F729)
    public static let home: KeyEquivalent

    /// End (U+F72B)
    public static let end: KeyEquivalent

    /// Page Up (U+F72C)
    public static let pageUp: KeyEquivalent

    /// Page Down (U+F72D)
    public static let pageDown: KeyEquivalent

    /// Clear (U+F739)
    public static let clear: KeyEquivalent

    /// Tab (U+0009)
    public static let tab: KeyEquivalent

    /// Space (U+0020)
    public static let space: KeyEquivalent

    /// Return (U+000D)
    public static let `return`: KeyEquivalent

    /// The character value that the key equivalent represents.
    public var character: Character

    /// Creates a new key equivalent from the given character value.
    public init(_ character: Character)
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension KeyEquivalent : ExpressibleByExtendedGraphemeClusterLiteral {

    /// Creates an instance initialized to the given value.
    ///
    /// - Parameter value: The value of the new instance.
    public init(extendedGraphemeClusterLiteral: Character)

    /// A type that represents an extended grapheme cluster literal.
    ///
    /// Valid types for `ExtendedGraphemeClusterLiteralType` are `Character`,
    /// `String`, and `StaticString`.
    public typealias ExtendedGraphemeClusterLiteralType = Character

    /// A type that represents a Unicode scalar literal.
    ///
    /// Valid types for `UnicodeScalarLiteralType` are `Unicode.Scalar`,
    /// `Character`, `String`, and `StaticString`.
    public typealias UnicodeScalarLiteralType = Character
}

/// Keyboard shortcuts describe combinations of keys on a keyboard that the user
/// can press in order to activate a button or toggle.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct KeyboardShortcut {

    /// The standard keyboard shortcut for the default button, consisting of
    /// the Return (↩) key and no modifiers.
    ///
    /// On macOS, the default button is designated with special coloration. If
    /// more than one control is assigned this shortcut, only the first one is
    /// emphasized.
    public static let defaultAction: KeyboardShortcut

    /// The standard keyboard shortcut for cancelling the in-progress action
    /// or dismissing a prompt, consisting of the Escape (⎋) key and no
    /// modifiers.
    public static let cancelAction: KeyboardShortcut

    /// The key equivalent that the user presses in conjunction with any
    /// specified modifier keys to activate the shortcut.
    public var key: KeyEquivalent

    /// The modifier keys that the user presses in conjunction with a key
    /// equivalent to activate the shortcut.
    public var modifiers: EventModifiers

    /// Creates a new keyboard shortcut with the given key equivalent and set of
    /// modifier keys.
    public init(_ key: KeyEquivalent, modifiers: EventModifiers = .command)
}
