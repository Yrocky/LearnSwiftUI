//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A document model definition used to serialize reference type documents to
/// and from file contents.
///
/// Conformance to `ReferenceFileDocument` is expected to be thread-safe, and
/// deserialization and serialization will be done on a background thread.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol ReferenceFileDocument : ObservableObject {

    /// A type of the document snapshot that can be used for serialization
    /// in parallel to the main document being editable.
    ///
    /// - See Also: `snapshot(contentType:)`
    associatedtype Snapshot

    /// The types the document is able to open.
    static var readableContentTypes: [UTType] { get }

    /// The types the document is able to save or export to.
    ///
    /// Defaults to `readableContentTypes`.
    static var writableContentTypes: [UTType] { get }

    /// Initialize self by reading from the contents of a given `ReadConfiguration`.
    init(configuration: Self.ReadConfiguration) throws

    /// The configuration for reading document contents.
    typealias ReadConfiguration = FileDocumentReadConfiguration

    /// Create a snapshot of the current state of the document, which will be
    /// used for serialization while `self` becomes editable by the user.
    ///
    /// When saving a `ReferenceFileDocument`, edits to the document are blocked
    /// until snapshot with a copy of any mutable references can be created.
    /// Once the snapshot is created, the document becomes editable in parallel
    /// to the snapshot being serialized using `write(snaphot:to:contentType:)`.
    ///
    /// - Parameter contentType: The content type being written, for which the
    ///   snapshot should be created.
    func snapshot(contentType: UTType) throws -> Self.Snapshot

    /// Serialize the snapshot to file contents for a specified `type`.
    ///
    /// - Parameters:
    ///   - snapshot: The snapshot of the document containing the state required
    ///     to be saved.
    ///   - configuration: The configuration for the current document contents.
    ///
    /// - Returns: The destination to serialize the document contents to. The
    ///   value can be a newly created `FileWrapper` or an updated `FileWrapper`
    ///   of the one provided in `configuration`.
    func fileWrapper(snapshot: Self.Snapshot, configuration: Self.WriteConfiguration) throws -> FileWrapper

    /// The configurations for serializing document contents.
    typealias WriteConfiguration = FileDocumentWriteConfiguration
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension ReferenceFileDocument {

    /// The types the document is able to save or export to.
    ///
    /// Defaults to `readableContentTypes`.
    public static var writableContentTypes: [UTType] { get }
}

/// The properties of an open reference file document.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct ReferenceFileDocumentConfiguration<Document> where Document : ReferenceFileDocument {

    /// The current document model.
    ///
    /// Changes to the document are observed and on change dirty the document
    /// state for resaving. Undo actions are not automatically registered and
    /// need to be done explicitly.
    public var document: Document

    public var $document: ObservedObject<Document>.Wrapper { get }

    /// The url of the open file document.
    public var fileURL: URL?

    /// Whether the document is able to be edited.
    ///
    /// This can return `false` if the document is in viewing mode or if the
    /// file is unable to be written to.
    public var isEditable: Bool
}
