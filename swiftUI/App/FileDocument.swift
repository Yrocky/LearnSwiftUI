//
//  Shape.swift
//  
//
//  Created by Rocky Young on 2020/12/24.
//

import Foundation


/// A document model definition used to serialize documents to and from file
/// contents.
///
/// Conformance to `FileDocument` is expected to have value semantics and be
/// thread-safe. Serialization and deserialization will be done on a background
/// thread.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public protocol FileDocument {

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

    /// Serialize the document to file contents for a specified `configuration`.
    /// - Parameter configuration: the configuration for the current document
    ///   contents.
    ///
    /// - Returns: The destination to serialize the document contents to. The
    ///   value can be a newly created `FileWrapper` or an updated `FileWrapper`
    ///   of the one provided in `configuration`.
    func fileWrapper(configuration: Self.WriteConfiguration) throws -> FileWrapper

    /// The configuration for serializing document contents.
    typealias WriteConfiguration = FileDocumentWriteConfiguration
}

@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension FileDocument {

    /// The types the document is able to save or export to.
    ///
    /// Defaults to `readableContentTypes`.
    public static var writableContentTypes: [UTType] { get }
}

/// The properties of an open file document.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct FileDocumentConfiguration<Document> where Document : FileDocument {

    /// The current document model.
    ///
    /// Setting a new value will mark the document as dirty for later saving
    /// as well as register an undo action to restore the model to its previous
    /// value.
    ///
    /// If `isEditable` is `false`, setting a new value will have no effect.
    public var document: Document { get nonmutating set }

    public var $document: Binding<Document> { get }

    /// The url of the open file document.
    public var fileURL: URL?

    /// Whether the document is able to be edited.
    ///
    /// This can return `false` if the document is in viewing mode or if the
    /// file is unable to be written to.
    public var isEditable: Bool
}

/// The configuration for reading file contents.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct FileDocumentReadConfiguration {

    /// The expected uniform type of the file contents.
    public let contentType: UTType

    /// The file wrapper containing the document content.
    public let file: FileWrapper
}

/// The configuration for serializing file contents.
@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct FileDocumentWriteConfiguration {

    /// The expected uniform type of the file contents.
    public let contentType: UTType

    /// The file wrapper containing the current document content.
    /// `nil` if the document is unsaved.
    public let existingFile: FileWrapper?
}


@available(iOS 14.0, macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {

    /// Presents a system interface for allowing the user to export an in-memory
    /// document to a file on disk.
    ///
    /// In order for the interface to appear, both `isPresented` must be `true`
    /// and `document` must not be `nil`. When the operation is finished,
    /// `isPresented` will be set to `false` before `onCompletion` is called. If
    /// the user cancels the operation, `isPresented` will be set to `false` and
    /// `onCompletion` will not be called.
    ///
    /// The `contentType` provided must be included within the document type's
    /// `writableContentTypes`, otherwise the first valid writable content type
    /// will be used instead.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - document: The in-memory document to export.
    ///   - contentType: The content type to use for the exported file.
    ///   - defaultFilename: If provided, the default name to use for the
    ///     exported file, which will the user will have an opportunity to edit
    ///     prior to the export.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     has succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileExporter<D>(isPresented: Binding<Bool>, document: D?, contentType: UTType, defaultFilename: String? = nil, onCompletion: @escaping (Result<URL, Error>) -> Void) -> some View where D : FileDocument


    /// Presents a system interface for allowing the user to export a collection
    /// of in-memory documents to files on disk.
    ///
    /// In order for the interface to appear, both `isPresented` must be `true`
    /// and `documents` must not be empty. When the operation is finished,
    /// `isPresented` will be set to `false` before `onCompletion` is called. If
    /// the user cancels the operation, `isPresented` will be set to `false` and
    /// `onCompletion` will not be called.
    ///
    /// The `contentType` provided must be included within the document type's
    /// `writableContentTypes`, otherwise the first valid writable content type
    /// will be used instead.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - documents: The collection of in-memory documents to export.
    ///   - contentType: The content type to use for the exported file.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     has succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileExporter<C>(isPresented: Binding<Bool>, documents: C, contentType: UTType, onCompletion: @escaping (Result<[URL], Error>) -> Void) -> some View where C : Collection, C.Element : FileDocument


    /// Presents a system interface for allowing the user to export an in-memory
    /// document to a file on disk.
    ///
    /// In order for the interface to appear, both `isPresented` must be `true`
    /// and `document` must not be `nil`. When the operation is finished,
    /// `isPresented` will be set to `false` before `onCompletion` is called. If
    /// the user cancels the operation, `isPresented` will be set to `false` and
    /// `onCompletion` will not be called.
    ///
    /// The `contentType` provided must be included within the document type's
    /// `writableContentTypes`, otherwise the first valid writable content type
    /// will be used instead.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - document: The in-memory document to export.
    ///   - contentType: The content type to use for the exported file.
    ///   - defaultFilename: If provided, the default name to use for the
    ///     exported file, which will the user will have an opportunity to edit
    ///     prior to the export.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     has succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileExporter<D>(isPresented: Binding<Bool>, document: D?, contentType: UTType, defaultFilename: String? = nil, onCompletion: @escaping (Result<URL, Error>) -> Void) -> some View where D : ReferenceFileDocument


    /// Presents a system interface for allowing the user to export a collection
    /// of in-memory documents to files on disk.
    ///
    /// In order for the interface to appear, both `isPresented` must be `true`
    /// and `documents` must not be empty. When the operation is finished,
    /// `isPresented` will be set to `false` before `onCompletion` is called. If
    /// the user cancels the operation, `isPresented` will be set to `false` and
    /// `onCompletion` will not be called.
    ///
    /// The `contentType` provided must be included within the document type's
    /// `writableContentTypes`, otherwise the first valid writable content type
    /// will be used instead.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to whether the interface should be shown.
    ///   - documents: The collection of in-memory documents to export.
    ///   - contentType: The content type to use for the exported file.
    ///   - onCompletion: A callback that will be invoked when the operation has
    ///     has succeeded or failed.
    ///   - result: A `Result` indicating whether the operation succeeded or
    ///     failed.
    public func fileExporter<C>(isPresented: Binding<Bool>, documents: C, contentType: UTType, onCompletion: @escaping (Result<[URL], Error>) -> Void) -> some View where C : Collection, C.Element : ReferenceFileDocument

}
