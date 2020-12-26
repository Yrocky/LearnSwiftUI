//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation



/// A scene that enables support for opening, creating, and saving documents.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct DocumentGroup<Document, Content> : Scene where Content : View {

    /// The content and behavior of the scene.
    ///
    /// For any scene that you create, provide a computed `body` property that
    /// defines the scene as a composition of other scenes. You can assemble a
    /// scene from primitive scenes that SwiftUI provides, as well as other
    /// scenes that you've defined.
    ///
    /// Swift infers the scene's ``SwiftUI/Scene/Body-swift.associatedtype``
    /// associated type based on the contents of the `body` property.
    public var body: some Scene { get }

    /// The type of scene that represents the body of this scene.
    ///
    /// When you create a custom scene, Swift infers this type from your
    /// implementation of the required ``SwiftUI/Scene/body-swift.property``
    /// property.
    public typealias Body = some Scene
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DocumentGroup where Document : FileDocument {

    /// Creates a document group that is able to create and edit file documents.
    ///
    /// - Parameters:
    ///   - newDocument: The initial document used when the user creates
    ///     a new document.
    ///   - editor: The editing UI for the provided document.
    public init(newDocument: @autoclosure @escaping () -> Document, @ViewBuilder editor: @escaping (FileDocumentConfiguration<Document>) -> Content)

    /// Creates a document group that is able to view file documents.
    ///
    /// - Parameters:
    ///   - documentType: The type of document being viewed.
    ///   - viewer: The viewing UI for the provided document.
    ///
    /// - See Also: `CFBundleTypeRole` with a value of "Viewer"
    public init(viewing documentType: Document.Type, @ViewBuilder viewer: @escaping (FileDocumentConfiguration<Document>) -> Content)
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension DocumentGroup where Document : ReferenceFileDocument {

    /// Creates a document group that is able to create and edit reference file
    /// documents.
    ///
    /// - Parameters:
    ///   - newDocument: The initial document used when the user creates
    ///     a new document. The argument should create a new instance, such that
    ///     a new document is created on each invocation of the closure.
    ///   - editor: The editing UI for the provided document.
    ///
    /// The current document for a given editor instance is also provided as an
    /// environment object for its subhierarchy.
    ///
    /// Undo support is not automatically provided for this construction of
    /// a `DocumentGroup`, and any updates to the document by the editor view
    /// hierarchy are expected to register undo operations when appropriate.
    public init(newDocument: @escaping () -> Document, @ViewBuilder editor: @escaping (ReferenceFileDocumentConfiguration<Document>) -> Content)

    /// Creates a document group that is able to view reference file documents.
    ///
    /// - Parameters:
    ///   - documentType: The type of document being viewed.
    ///   - viewer: The viewing UI for the provided document.
    ///
    /// The current document for a given editor instance is also provided as an
    /// environment object for its subhierarchy.
    ///
    /// - See Also: `CFBundleTypeRole` with a value of "Viewer"
    public init(viewing documentType: Document.Type, @ViewBuilder viewer: @escaping (ReferenceFileDocumentConfiguration<Document>) -> Content)
}
