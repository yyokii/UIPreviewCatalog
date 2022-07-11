//
//  File.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/24.
//


/// Configuration of image and markdown generation and its output content
public struct UIPreviewCatalogConfig {
    public let baseDirectoryName: String
    public let snapshotsDirectoryName: String
    public let snapshotFormat: Format
    public let markdownImageLinkWidth: Float?
    public let markdownImageLinkHeight: Float?
    public let previewCatalogFilename: String

    public enum Format {
        case png
        case jpg(compressionQuality: Float)

        var filenameExtension: String {
            if case .jpg = self {
                return ".jpg"
            } else {
                return ".png"
            }
        }
    }

    public init(directoryName: String,
         imageDirectoryName: String,
         imageFormat: Format = .jpg(compressionQuality: 0.8),
         markdownImageLinkWidth: Float?,
         markdownImageLinkHeight: Float?,
         previewCatalogFilename: String) {
        self.baseDirectoryName = directoryName
        self.snapshotsDirectoryName = imageDirectoryName
        self.snapshotFormat = imageFormat
        self.markdownImageLinkWidth = markdownImageLinkWidth
        self.markdownImageLinkHeight = markdownImageLinkHeight
        self.previewCatalogFilename = previewCatalogFilename
    }
}

extension UIPreviewCatalogConfig {
    public static let defaultConfig: Self = .init(directoryName: "UIPreviewCatalog",
                                           imageDirectoryName: "Images",
                                           markdownImageLinkWidth: 200,
                                           markdownImageLinkHeight: nil,
                                           previewCatalogFilename: "previewCatalog")
}
