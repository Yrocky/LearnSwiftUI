/// Dumps the given object's contents using its mirror to the specified output
/// stream.
///
/// - Parameters:
///   - value: The value to output to the `target` stream.
///   - target: The stream to use for writing the contents of `value`.
///   - name: A label to use when writing the contents of `value`. When `nil`
///     is passed, the label is omitted. The default is `nil`.
///   - indent: The number of spaces to use as an indent for each line of the
///     output. The default is `0`.
///   - maxDepth: The maximum depth to descend when writing the contents of a
///     value that has nested components. The default is `Int.max`.
///   - maxItems: The maximum number of elements for which to write the full
///     contents. The default is `Int.max`.
/// - Returns: The instance passed as `value`.
public func dump<T, TargetStream>(_ value: T, to target: inout TargetStream, name: String? = nil, indent: Int = 0, maxDepth: Int = .max, maxItems: Int = .max) -> T where TargetStream : TextOutputStream

/// Dumps the given object's contents using its mirror to standard output.
///
/// - Parameters:
///   - value: The value to output to the `target` stream.
///   - name: A label to use when writing the contents of `value`. When `nil`
///     is passed, the label is omitted. The default is `nil`.
///   - indent: The number of spaces to use as an indent for each line of the
///     output. The default is `0`.
///   - maxDepth: The maximum depth to descend when writing the contents of a
///     value that has nested components. The default is `Int.max`.
///   - maxItems: The maximum number of elements for which to write the full
///     contents. The default is `Int.max`.
/// - Returns: The instance passed as `value`.
public func dump<T>(_ value: T, name: String? = nil, indent: Int = 0, maxDepth: Int = .max, maxItems: Int = .max) -> T

/// A unique identifier for a class instance or metatype.
///
/// In Swift, only class instances and metatypes have unique identities. There
/// is no notion of identity for structs, enums, functions, or tuples.
@frozen public struct ObjectIdentifier {

    /// Creates an instance that uniquely identifies the given class instance.
    ///
    /// The following example creates an example class `IntegerRef` and compares
    /// instances of the class using their object identifiers and the identical-to
    /// operator (`===`):
    ///
    ///     class IntegerRef {
    ///         let value: Int
    ///         init(_ value: Int) {
    ///             self.value = value
    ///         }
    ///     }
    ///
    ///     let x = IntegerRef(10)
    ///     let y = x
    ///
    ///     print(ObjectIdentifier(x) == ObjectIdentifier(y))
    ///     // Prints "true"
    ///     print(x === y)
    ///     // Prints "true"
    ///
    ///     let z = IntegerRef(10)
    ///     print(ObjectIdentifier(x) == ObjectIdentifier(z))
    ///     // Prints "false"
    ///     print(x === z)
    ///     // Prints "false"
    ///
    /// - Parameter x: An instance of a class.
    @inlinable public init(_ x: AnyObject)

    /// Creates an instance that uniquely identifies the given metatype.
    ///
    /// - Parameter: A metatype.
    @inlinable public init(_ x: Any.Type)

    /// Returns a closed range that contains both of its bounds.
    ///
    /// Use the closed range operator (`...`) to create a closed range of any type
    /// that conforms to the `Comparable` protocol. This example creates a
    /// `ClosedRange<Character>` from "a" up to, and including, "z".
    ///
    ///     let lowercase = "a"..."z"
    ///     print(lowercase.contains("z"))
    ///     // Prints "true"
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    public static func ... (minimum: ObjectIdentifier, maximum: ObjectIdentifier) -> ClosedRange<ObjectIdentifier>

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is greater than that of the second argument.
    ///
    /// This is the default implementation of the greater-than operator (`>`) for
    /// any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func > (lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is less than or equal to that of the second argument.
    ///
    /// This is the default implementation of the less-than-or-equal-to
    /// operator (`<=`) for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func <= (lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Bool

    /// Returns a Boolean value indicating whether the value of the first argument
    /// is greater than or equal to that of the second argument.
    ///
    /// This is the default implementation of the greater-than-or-equal-to operator
    /// (`>=`) for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    /// - Returns: `true` if `lhs` is greater than or equal to `rhs`; otherwise,
    ///   `false`.
    @inlinable public static func >= (lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Bool

    public static func != (lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Bool

    /// Returns a half-open range that contains its lower bound but not its upper
    /// bound.
    ///
    /// Use the half-open range operator (`..<`) to create a range of any type
    /// that conforms to the `Comparable` protocol. This example creates a
    /// `Range<Double>` from zero up to, but not including, 5.0.
    ///
    ///     let lessThanFive = 0.0..<5.0
    ///     print(lessThanFive.contains(3.14))  // Prints "true"
    ///     print(lessThanFive.contains(5.0))   // Prints "false"
    ///
    /// - Parameters:
    ///   - minimum: The lower bound for the range.
    ///   - maximum: The upper bound for the range.
    public static func ..< (minimum: ObjectIdentifier, maximum: ObjectIdentifier) -> Range<ObjectIdentifier>

    /// Returns a partial range up to, but not including, its upper bound.
    ///
    /// Use the prefix half-open range operator (prefix `..<`) to create a
    /// partial range of any type that conforms to the `Comparable` protocol.
    /// This example creates a `PartialRangeUpTo<Double>` instance that includes
    /// any value less than `5.0`.
    ///
    ///     let upToFive = ..<5.0
    ///
    ///     upToFive.contains(3.14)       // true
    ///     upToFive.contains(6.28)       // false
    ///     upToFive.contains(5.0)        // false
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the start of the collection up to, but not
    /// including, the partial range's upper bound.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[..<3])
    ///     // Prints "[10, 20, 30]"
    ///
    /// - Parameter maximum: The upper bound for the range.
    prefix public static func ..< (maximum: ObjectIdentifier) -> PartialRangeUpTo<ObjectIdentifier>

    /// Returns a partial range up to, and including, its upper bound.
    ///
    /// Use the prefix closed range operator (prefix `...`) to create a partial
    /// range of any type that conforms to the `Comparable` protocol. This
    /// example creates a `PartialRangeThrough<Double>` instance that includes
    /// any value less than or equal to `5.0`.
    ///
    ///     let throughFive = ...5.0
    ///
    ///     throughFive.contains(4.0)     // true
    ///     throughFive.contains(5.0)     // true
    ///     throughFive.contains(6.0)     // false
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the start of the collection up to, and
    /// including, the partial range's upper bound.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[...3])
    ///     // Prints "[10, 20, 30, 40]"
    ///
    /// - Parameter maximum: The upper bound for the range.
    prefix public static func ... (maximum: ObjectIdentifier) -> PartialRangeThrough<ObjectIdentifier>

    /// Returns a partial range extending upward from a lower bound.
    ///
    /// Use the postfix range operator (postfix `...`) to create a partial range
    /// of any type that conforms to the `Comparable` protocol. This example
    /// creates a `PartialRangeFrom<Double>` instance that includes any value
    /// greater than or equal to `5.0`.
    ///
    ///     let atLeastFive = 5.0...
    ///
    ///     atLeastFive.contains(4.0)     // false
    ///     atLeastFive.contains(5.0)     // true
    ///     atLeastFive.contains(6.0)     // true
    ///
    /// You can use this type of partial range of a collection's indices to
    /// represent the range from the partial range's lower bound up to the end
    /// of the collection.
    ///
    ///     let numbers = [10, 20, 30, 40, 50, 60, 70]
    ///     print(numbers[3...])
    ///     // Prints "[40, 50, 60, 70]"
    ///
    /// - Parameter minimum: The lower bound for the range.
    postfix public static func ... (minimum: ObjectIdentifier) -> PartialRangeFrom<ObjectIdentifier>
}

extension ObjectIdentifier : CustomDebugStringConvertible {

    /// A textual representation of the identifier, suitable for debugging.
    public var debugDescription: String { get }
}

extension ObjectIdentifier : Equatable {

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    @inlinable public static func == (x: ObjectIdentifier, y: ObjectIdentifier) -> Bool
}

extension ObjectIdentifier : Comparable {

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
    @inlinable public static func < (lhs: ObjectIdentifier, rhs: ObjectIdentifier) -> Bool
}

extension ObjectIdentifier : Hashable {

    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
    @inlinable public func hash(into hasher: inout Hasher)

    /// The hash value.
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Important: `hashValue` is deprecated as a `Hashable` requirement. To
    ///   conform to `Hashable`, implement the `hash(into:)` requirement instead.
    public var hashValue: Int { get }
}

/// A representation of the substructure and display style of an instance of
/// any type.
///
/// A mirror describes the parts that make up a particular instance, such as
/// the instance's stored properties, collection or tuple elements, or its
/// active enumeration case. Mirrors also provide a "display style" property
/// that suggests how this mirror might be rendered.
///
/// Playgrounds and the debugger use the `Mirror` type to display
/// representations of values of any type. For example, when you pass an
/// instance to the `dump(_:_:_:_:)` function, a mirror is used to render that
/// instance's runtime contents.
///
///     struct Point {
///         let x: Int, y: Int
///     }
///
///     let p = Point(x: 21, y: 30)
///     print(String(reflecting: p))
///     // Prints "▿ Point
///     //           - x: 21
///     //           - y: 30"
///
/// To customize the mirror representation of a custom type, add conformance to
/// the `CustomReflectable` protocol.
public struct Mirror {

    /// The representation to use for ancestor classes.
    ///
    /// A class that conforms to the `CustomReflectable` protocol can control how
    /// its mirror represents ancestor classes by initializing the mirror
    /// with an `AncestorRepresentation`. This setting has no effect on mirrors
    /// reflecting value type instances.
    public enum AncestorRepresentation {

        /// Generates a default mirror for all ancestor classes.
        ///
        /// This case is the default when initializing a `Mirror` instance.
        ///
        /// When you use this option, a subclass's mirror generates default mirrors
        /// even for ancestor classes that conform to the `CustomReflectable`
        /// protocol. To avoid dropping the customization provided by ancestor
        /// classes, an override of `customMirror` should pass
        /// `.customized({ super.customMirror })` as `ancestorRepresentation` when
        /// initializing its mirror.
        case generated

        /// Uses the nearest ancestor's implementation of `customMirror` to create
        /// a mirror for that ancestor.
        ///
        /// Other classes derived from such an ancestor are given a default mirror.
        /// The payload for this option should always be `{ super.customMirror }`:
        ///
        ///     var customMirror: Mirror {
        ///         return Mirror(
        ///             self,
        ///             children: ["someProperty": self.someProperty],
        ///             ancestorRepresentation: .customized({ super.customMirror })) // <==
        ///     }
        case customized(() -> Mirror)

        /// Suppresses the representation of all ancestor classes.
        ///
        /// In a mirror created with this ancestor representation, the
        /// `superclassMirror` property is `nil`.
        case suppressed
    }

    /// Creates a mirror that reflects on the given instance.
    ///
    /// If the dynamic type of `subject` conforms to `CustomReflectable`, the
    /// resulting mirror is determined by its `customMirror` property.
    /// Otherwise, the result is generated by the language.
    ///
    /// If the dynamic type of `subject` has value semantics, subsequent
    /// mutations of `subject` will not observable in `Mirror`.  In general,
    /// though, the observability of mutations is unspecified.
    ///
    /// - Parameter subject: The instance for which to create a mirror.
    public init(reflecting subject: Any)

    /// An element of the reflected instance's structure.
    ///
    /// When the `label` component in not `nil`, it may represent the name of a
    /// stored property or an active `enum` case. If you pass strings to the
    /// `descendant(_:_:)` method, labels are used for lookup.
    public typealias Child = (label: String?, value: Any)

    /// The type used to represent substructure.
    ///
    /// When working with a mirror that reflects a bidirectional or random access
    /// collection, you may find it useful to "upgrade" instances of this type
    /// to `AnyBidirectionalCollection` or `AnyRandomAccessCollection`. For
    /// example, to display the last twenty children of a mirror if they can be
    /// accessed efficiently, you write the following code:
    ///
    ///     if let b = AnyBidirectionalCollection(someMirror.children) {
    ///         for element in b.suffix(20) {
    ///             print(element)
    ///         }
    ///     }
    public typealias Children = AnyCollection<Mirror.Child>

    /// A suggestion of how a mirror's subject is to be interpreted.
    ///
    /// Playgrounds and the debugger will show a representation similar
    /// to the one used for instances of the kind indicated by the
    /// `DisplayStyle` case name when the mirror is used for display.
    public enum DisplayStyle {

        case `struct`

        case `class`

        case `enum`

        case tuple

        case optional

        case collection

        case dictionary

        case set

        /// Returns a Boolean value indicating whether two values are equal.
        ///
        /// Equality is the inverse of inequality. For any values `a` and `b`,
        /// `a == b` implies that `a != b` is `false`.
        ///
        /// - Parameters:
        ///   - lhs: A value to compare.
        ///   - rhs: Another value to compare.
        public static func == (a: Mirror.DisplayStyle, b: Mirror.DisplayStyle) -> Bool

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
    }

    /// Creates a mirror representing the given subject with a specified
    /// structure.
    ///
    /// You use this initializer from within your type's `customMirror`
    /// implementation to create a customized mirror.
    ///
    /// If `subject` is a class instance, `ancestorRepresentation` determines
    /// whether ancestor classes will be represented and whether their
    /// `customMirror` implementations will be used. By default, the
    /// `customMirror` implementation of any ancestors is ignored. To prevent
    /// bypassing customized ancestors, pass
    /// `.customized({ super.customMirror })` as the `ancestorRepresentation`
    /// parameter when implementing your type's `customMirror` property.
    ///
    /// - Parameters:
    ///   - subject: The instance to represent in the new mirror.
    ///   - children: The structure to use for the mirror. The collection
    ///     traversal modeled by `children` is captured so that the resulting
    ///     mirror's children may be upgraded to a bidirectional or random
    ///     access collection later. See the `children` property for details.
    ///   - displayStyle: The preferred display style for the mirror when
    ///     presented in the debugger or in a playground. The default is `nil`.
    ///   - ancestorRepresentation: The means of generating the subject's
    ///     ancestor representation. `ancestorRepresentation` is ignored if
    ///     `subject` is not a class instance. The default is `.generated`.
    public init<Subject, C>(_ subject: Subject, children: C, displayStyle: Mirror.DisplayStyle? = nil, ancestorRepresentation: Mirror.AncestorRepresentation = .generated) where C : Collection, C.Element == Mirror.Child

    /// Creates a mirror representing the given subject with unlabeled children.
    ///
    /// You use this initializer from within your type's `customMirror`
    /// implementation to create a customized mirror, particularly for custom
    /// types that are collections. The labels of the resulting mirror's
    /// `children` collection are all `nil`.
    ///
    /// If `subject` is a class instance, `ancestorRepresentation` determines
    /// whether ancestor classes will be represented and whether their
    /// `customMirror` implementations will be used. By default, the
    /// `customMirror` implementation of any ancestors is ignored. To prevent
    /// bypassing customized ancestors, pass
    /// `.customized({ super.customMirror })` as the `ancestorRepresentation`
    /// parameter when implementing your type's `customMirror` property.
    ///
    /// - Parameters:
    ///   - subject: The instance to represent in the new mirror.
    ///   - unlabeledChildren: The children to use for the mirror. The collection
    ///     traversal modeled by `unlabeledChildren` is captured so that the
    ///     resulting mirror's children may be upgraded to a bidirectional or
    ///     random access collection later. See the `children` property for
    ///     details.
    ///   - displayStyle: The preferred display style for the mirror when
    ///     presented in the debugger or in a playground. The default is `nil`.
    ///   - ancestorRepresentation: The means of generating the subject's
    ///     ancestor representation. `ancestorRepresentation` is ignored if
    ///     `subject` is not a class instance. The default is `.generated`.
    public init<Subject, C>(_ subject: Subject, unlabeledChildren: C, displayStyle: Mirror.DisplayStyle? = nil, ancestorRepresentation: Mirror.AncestorRepresentation = .generated) where C : Collection

    /// Creates a mirror representing the given subject using a dictionary
    /// literal for the structure.
    ///
    /// You use this initializer from within your type's `customMirror`
    /// implementation to create a customized mirror. Pass a dictionary literal
    /// with string keys as `children`. Although an *actual* dictionary is
    /// arbitrarily-ordered, when you create a mirror with a dictionary literal,
    /// the ordering of the mirror's `children` will exactly match that of the
    /// literal you pass.
    ///
    /// If `subject` is a class instance, `ancestorRepresentation` determines
    /// whether ancestor classes will be represented and whether their
    /// `customMirror` implementations will be used. By default, the
    /// `customMirror` implementation of any ancestors is ignored. To prevent
    /// bypassing customized ancestors, pass
    /// `.customized({ super.customMirror })` as the `ancestorRepresentation`
    /// parameter when implementing your type's `customMirror` property.
    ///
    /// - Parameters:
    ///   - subject: The instance to represent in the new mirror.
    ///   - children: A dictionary literal to use as the structure for the
    ///     mirror. The `children` collection of the resulting mirror may be
    ///     upgraded to a random access collection later. See the `children`
    ///     property for details.
    ///   - displayStyle: The preferred display style for the mirror when
    ///     presented in the debugger or in a playground. The default is `nil`.
    ///   - ancestorRepresentation: The means of generating the subject's
    ///     ancestor representation. `ancestorRepresentation` is ignored if
    ///     `subject` is not a class instance. The default is `.generated`.
    public init<Subject>(_ subject: Subject, children: KeyValuePairs<String, Any>, displayStyle: Mirror.DisplayStyle? = nil, ancestorRepresentation: Mirror.AncestorRepresentation = .generated)

    /// The static type of the subject being reflected.
    ///
    /// This type may differ from the subject's dynamic type when this mirror
    /// is the `superclassMirror` of another mirror.
    public let subjectType: Any.Type

    /// A collection of `Child` elements describing the structure of the
    /// reflected subject.
    public let children: Mirror.Children

    /// A suggested display style for the reflected subject.
    public let displayStyle: Mirror.DisplayStyle?

    /// A mirror of the subject's superclass, if one exists.
    public var superclassMirror: Mirror? { get }

    /// Returns a specific descendant of the reflected subject, or `nil` if no
    /// such descendant exists.
    ///
    /// Pass a variadic list of string and integer arguments. Each string
    /// argument selects the first child with a matching label. Each integer
    /// argument selects the child at that offset. For example, passing
    /// `1, "two", 3` as arguments to `myMirror.descendant(_:_:)` is equivalent
    /// to:
    ///
    ///     var result: Any? = nil
    ///     let children = myMirror.children
    ///     if let i0 = children.index(
    ///         children.startIndex, offsetBy: 1, limitedBy: children.endIndex),
    ///         i0 != children.endIndex
    ///     {
    ///         let grandChildren = Mirror(reflecting: children[i0].value).children
    ///         if let i1 = grandChildren.firstIndex(where: { $0.label == "two" }) {
    ///             let greatGrandChildren =
    ///                 Mirror(reflecting: grandChildren[i1].value).children
    ///             if let i2 = greatGrandChildren.index(
    ///                 greatGrandChildren.startIndex,
    ///                 offsetBy: 3,
    ///                 limitedBy: greatGrandChildren.endIndex),
    ///                 i2 != greatGrandChildren.endIndex
    ///             {
    ///                 // Success!
    ///                 result = greatGrandChildren[i2].value
    ///             }
    ///         }
    ///     }
    ///
    /// This function is suitable for exploring the structure of a mirror in a
    /// REPL or playground, but is not intended to be efficient. The efficiency
    /// of finding each element in the argument list depends on the argument
    /// type and the capabilities of the each level of the mirror's `children`
    /// collections. Each string argument requires a linear search, and unless
    /// the underlying collection supports random-access traversal, each integer
    /// argument also requires a linear operation.
    ///
    /// - Parameters:
    ///   - first: The first mirror path component to access.
    ///   - rest: Any remaining mirror path components.
    /// - Returns: The descendant of this mirror specified by the given mirror
    ///   path components if such a descendant exists; otherwise, `nil`.
    public func descendant(_ first: MirrorPath, _ rest: MirrorPath...) -> Any?
}

/// Reflection for `Mirror` itself.
extension Mirror : CustomStringConvertible {

    /// A textual representation of this instance.
    ///
    /// Calling this property directly is discouraged. Instead, convert an
    /// instance of any type to a string by using the `String(describing:)`
    /// initializer. This initializer works with any type, and uses the custom
    /// `description` property for types that conform to
    /// `CustomStringConvertible`:
    ///
    ///     struct Point: CustomStringConvertible {
    ///         let x: Int, y: Int
    ///
    ///         var description: String {
    ///             return "(\(x), \(y))"
    ///         }
    ///     }
    ///
    ///     let p = Point(x: 21, y: 30)
    ///     let s = String(describing: p)
    ///     print(s)
    ///     // Prints "(21, 30)"
    ///
    /// The conversion of `p` to a string in the assignment to `s` uses the
    /// `Point` type's `description` property.
    public var description: String { get }
}

extension Mirror : CustomReflectable {

    /// The custom mirror for this instance.
    ///
    /// If this type has value semantics, the mirror should be unaffected by
    /// subsequent mutations of the instance.
    public var customMirror: Mirror { get }
}

extension Mirror.DisplayStyle {

    public static func != (lhs: Mirror.DisplayStyle, rhs: Mirror.DisplayStyle) -> Bool
}

/// A type that explicitly supplies its own mirror.
///
/// You can create a mirror for any type using the `Mirror(reflecting:)`
/// initializer, but if you are not satisfied with the mirror supplied for
/// your type by default, you can make it conform to `CustomReflectable` and
/// return a custom `Mirror` instance.
public protocol CustomReflectable {

    /// The custom mirror for this instance.
    ///
    /// If this type has value semantics, the mirror should be unaffected by
    /// subsequent mutations of the instance.
    var customMirror: Mirror { get }
}

/// A type that explicitly supplies its own mirror, but whose
/// descendant classes are not represented in the mirror unless they
/// also override `customMirror`.
public protocol CustomLeafReflectable : CustomReflectable {
}

/// A protocol for legitimate arguments to `Mirror`'s `descendant`
/// method.
///
/// Do not declare new conformances to this protocol; they will not
/// work as expected.
public protocol MirrorPath {
}

