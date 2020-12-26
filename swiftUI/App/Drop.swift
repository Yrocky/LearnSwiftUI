//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// An interface that you implement to interact with a drop operation in a view
/// modified to accept drops.
///
/// The ``DropDelegate`` protocol provides a comprehensive and flexible way to
/// interact with a drop operation. Specify a drop delegate when you modify a
/// view to accept drops with the ``View/onDrop(of:delegate:)-6lin8`` method.
///
/// Alternatively, for simple drop cases that don't require the full
/// functionality of a drop delegate, you can modify a view to accept drops
/// using the ``View/onDrop(of:isTargeted:perform:)-f15m`` or the
/// ``View/onDrop(of:isTargeted:perform:)-982eu`` method. These methods handle the
/// drop using a closure you provide as part of the modifier.
@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol DropDelegate {

    /// Tells the delegate that a drop containing items conforming to one of the
    /// expected types entered a view that accepts drops.
    ///
    /// Specify the expected types when you apply the drop modifier to the view.
    /// The default implementation returns `true`.
    func validateDrop(info: DropInfo) -> Bool

    /// Tells the delegate it can request the item provider data from the given
    /// information.
    ///
    /// Incorporate the received data into your app's data model as appropriate.
    /// - Returns: A Boolean that is `true` if the drop was successful, `false`
    ///   otherwise.
    func performDrop(info: DropInfo) -> Bool

    /// Tells the delegate a validated drop has entered the modified view.
    ///
    /// The default implementation does nothing.
    func dropEntered(info: DropInfo)

    /// Tells the delegate that a validated drop moved inside the modified view.
    ///
    /// Use this method to return a drop proposal containing the operation the
    /// delegate intends to perform at the drop ``DropInfo/location``. The
    /// default implementation of this method returns `nil`, which tells the
    /// drop to use the last valid returned value or else
    /// ``DropOperation/copy``.
    func dropUpdated(info: DropInfo) -> DropProposal?

    /// Tells the delegate a validated drop operation has exited the modified
    /// view.
    ///
    /// The default implementation does nothing.
    func dropExited(info: DropInfo)
}

@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DropDelegate {

    /// Tells the delegate that a drop containing items conforming to one of the
    /// expected types entered a view that accepts drops.
    ///
    /// Specify the expected types when you apply the drop modifier to the view.
    /// The default implementation returns `true`.
    public func validateDrop(info: DropInfo) -> Bool

    /// Tells the delegate a validated drop has entered the modified view.
    ///
    /// The default implementation does nothing.
    public func dropEntered(info: DropInfo)

    /// Tells the delegate that a validated drop moved inside the modified view.
    ///
    /// Use this method to return a drop proposal containing the operation the
    /// delegate intends to perform at the drop ``DropInfo/location``. The
    /// default implementation of this method returns `nil`, which tells the
    /// drop to use the last valid returned value or else
    /// ``DropOperation/copy``.
    public func dropUpdated(info: DropInfo) -> DropProposal?

    /// Tells the delegate a validated drop operation has exited the modified
    /// view.
    ///
    /// The default implementation does nothing.
    public func dropExited(info: DropInfo)
}

/// The current state of a drop.
@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DropInfo {

    /// The location of the drag in the coordinate space of the drop view.
    public var location: CGPoint { get }

    /// Indicates whether at least one item conforms to at least one of the
    /// specified uniform type identifiers.
    ///
    /// - Parameter contentTypes: The uniform type identifiers to query for.
    /// - Returns: Whether at least one item conforms to one of `contentTypes`.
    @available(iOS 14.0, macOS 11.0, *)
    public func hasItemsConforming(to contentTypes: [UTType]) -> Bool

    /// Finds item providers that conform to at least one of the specified
    /// uniform type identifiers.
    ///
    /// This function is only valid during the `performDrop()` action.
    ///
    /// - Parameter contentTypes: The uniform type identifiers to query for.
    /// - Returns: The item providers that conforms to `contentTypes`.
    @available(iOS 14.0, macOS 11.0, *)
    public func itemProviders(for contentTypes: [UTType]) -> [NSItemProvider]
}

@available(iOS, introduced: 13.4, deprecated: 100000.0, message: "Provide `UTType`s as the `types` instead.")
@available(macOS, introduced: 10.15, deprecated: 100000.0, message: "Provide `UTType`s as the `types` instead.")
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DropInfo {

    /// Returns whether at least one item conforms to at least one of the
    /// specified uniform type identifiers.
    public func hasItemsConforming(to types: [String]) -> Bool

    /// Returns an Array of items that each conform to at least one of the
    /// specified uniform type identifiers.
    ///
    /// This function is only valid during the performDrop() action.
    public func itemProviders(for types: [String]) -> [NSItemProvider]
}

/// Operation types that determine how a drag and drop session resolves when the
/// user drops a drag item.
@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public enum DropOperation {

    /// Cancel the drag operation and transfer no data.
    case cancel

    /// The drop activity is not allowed at this time or location.
    case forbidden

    /// Copy the data to the modified view.
    case copy

    /// Move the data represented by the drag items instead of copying it.
    case move

    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func == (a: DropOperation, b: DropOperation) -> Bool

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

@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DropOperation : Equatable {
}

@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DropOperation : Hashable {
}

/// The behavior of a drop.
@available(iOS 13.4, macOS 10.15, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DropProposal {

    /// The drop operation that the drop proposes to perform.
    public let operation: DropOperation

    public init(operation: DropOperation)
}


@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Defines the destination of a drag-and-drop operation that handles the
    /// dropped content with a closure that you specify.
    ///
    /// The drop destination is the same size and position as this view.
    ///
    /// - Parameters:
    ///   - supportedContentTypes: The uniform type identifiers that describe the
    ///     types of content this view can accept through drag and drop.
    ///     If the drag and drop operation doesn't contain any of the supported
    ///     types, then this drop destination doesn't activate and `isTargeted`
    ///     doesn't update.
    ///   - isTargeted: A binding that updates when a drag and drop operation
    ///     enters or exits the drop target area. The binding's value is `true` when
    ///     the cursor is inside the area, and `false` when the cursor is outside.
    ///   - action: A closure that takes the dropped content and responds
    ///     appropriately. The parameter to `action` contains the dropped
    ///     items, with types specified by `supportedContentTypes`. Return `true`
    ///     if the drop operation was successful; otherwise, return `false`.
    ///
    /// - Returns: A view that provides a drop destination for a drag
    ///   operation of the specified types.
    public func onDrop(of supportedContentTypes: [UTType], isTargeted: Binding<Bool>?, perform action: @escaping ([NSItemProvider]) -> Bool) -> some View


    /// Defines the destination of a drag and drop operation that handles the
    /// dropped content with a closure that you specify.
    ///
    /// The drop destination is the same size and position as this view.
    ///
    /// - Parameters:
    ///   - supportedContentTypes: The uniform type identifiers that describe
    ///     the types of content this view can accept through drag and drop.
    ///     If the drag and drop operation doesn't contain any of the supported
    ///     types, then this drop destination doesn't activate and `isTargeted`
    ///     doesn't update.
    ///   - isTargeted: A binding that updates when a drag and drop operation
    ///     enters or exits the drop target area. The binding's value is `true` when
    ///     the cursor is inside the area, and `false` when the cursor is outside.
    ///   - action: A closure that takes the dropped content and responds
    ///     appropriately. The first parameter to `action` contains the dropped
    ///     items, with types specified by `supportedContentTypes`. The second
    ///     parameter contains the drop location in this view's coordinate
    ///     space. Return `true` if the drop operation was successful;
    ///     otherwise, return `false`.
    ///
    /// - Returns: A view that provides a drop destination for a drag
    ///   operation of the specified types.
    public func onDrop(of supportedContentTypes: [UTType], isTargeted: Binding<Bool>?, perform action: @escaping ([NSItemProvider], CGPoint) -> Bool) -> some View


    /// Defines the destination of a drag and drop operation using behavior
    /// controlled by the delegate that you provide.
    ///
    /// The drop destination is the same size and position as this view.
    ///
    /// - Parameters:
    ///   - supportedContentTypes: The uniform type identifiers that describe the
    ///     types of content this view can accept through drag and drop.
    ///     If the drag and drop operation doesn't contain any of the supported
    ///     types, then this drop destination doesn't activate and `isTargeted`
    ///     doesn't update.
    ///   - delegate: A type that conforms to the ``DropDelegate`` protocol. You
    ///     have comprehensive control over drop behavior when you use a
    ///     delegate.
    ///
    /// - Returns: A view that provides a drop destination for a drag
    ///   operation of the specified types.
    public func onDrop(of supportedContentTypes: [UTType], delegate: DropDelegate) -> some View

}

@available(iOS, introduced: 13.4, deprecated: 100000.0, message: "Provide `UTType`s as the `supportedContentTypes` instead.")
@available(macOS, introduced: 10.15, deprecated: 100000.0, message: "Provide `UTType`s as the `supportedContentTypes` instead.")
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Defines the destination for a drag and drop operation, using the same
    /// size and position as this view, handling dropped content with the given
    /// closure.
    ///
    /// - Parameters:
    ///   - supportedTypes: The uniform type identifiers that describe the
    ///     types of content this view can accept through drag and drop.
    ///     If the drag and drop operation doesn't contain any of the supported
    ///     types, then this drop destination doesn't activate and `isTargeted`
    ///     doesn't update.
    ///   - isTargeted: A binding that updates when a drag and drop operation
    ///     enters or exits the drop target area. The binding's value is `true`
    ///     when the cursor is inside the area, and `false` when the cursor is
    ///     outside.
    ///   - action: A closure that takes the dropped content and responds
    ///     appropriately. The parameter to `action` contains the dropped
    ///     items, with types specified by `supportedTypes`. Return `true`
    ///     if the drop operation was successful; otherwise, return `false`.
    /// - Returns: A view that provides a drop destination for a drag
    ///   operation of the specified types.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func onDrop(of supportedTypes: [String], isTargeted: Binding<Bool>?, perform action: @escaping ([NSItemProvider]) -> Bool) -> some View


    /// Defines the destination for a drag and drop operation with the same size
    /// and position as this view, handling dropped content and the drop
    /// location with the given closure.
    ///
    /// - Parameters:
    ///   - supportedTypes: The uniform type identifiers that describe the
    ///     types of content this view can accept through drag and drop.
    ///     If the drag and drop operation doesn't contain any of the supported
    ///     types, then this drop destination doesn't activate and `isTargeted`
    ///     doesn't update.
    ///   - isTargeted: A binding that updates when a drag and drop operation
    ///     enters or exits the drop target area. The binding's value is `true`
    ///     when the cursor is inside the area, and `false` when the cursor is
    ///     outside.
    ///   - action: A closure that takes the dropped content and responds
    ///     appropriately. The first parameter to `action` contains the dropped
    ///     items, with types specified by `supportedTypes`. The second
    ///     parameter contains the drop location in this view's coordinate
    ///     space. Return `true` if the drop operation was successful;
    ///     otherwise, return `false`.
    /// - Returns: A view that provides a drop destination for a drag
    ///   operation of the specified types.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func onDrop(of supportedTypes: [String], isTargeted: Binding<Bool>?, perform action: @escaping ([NSItemProvider], CGPoint) -> Bool) -> some View


    /// Defines the destination for a drag and drop operation with the same size
    /// and position as this view, with behavior controlled by the given
    /// delegate.
    ///
    /// - Parameters:
    ///   - supportedTypes: The uniform type identifiers that describe the
    ///     types of content this view can accept through drag and drop.
    ///     If the drag and drop operation doesn't contain any of the supported
    ///     types, then this drop destination doesn't activate and `isTargeted`
    ///     doesn't update.
    ///   - delegate: A type that conforms to the `DropDelegate` protocol. You
    ///     have comprehensive control over drop behavior when you use a
    ///     delegate.
    /// - Returns: A view that provides a drop destination for a drag
    ///   operation of the specified types.
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func onDrop(of supportedTypes: [String], delegate: DropDelegate) -> some View

}
