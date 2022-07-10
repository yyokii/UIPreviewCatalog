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
    public let snapshotFilename: UIPreviewCatalogFilename
    public let markdownImageLinkWidth: Float?
    public let markdownImageLinkHeight: Float?
    public let previewCatalogFilename: String

    public init(directoryName: String,
         imageDirectoryName: String,
         imageFilename: UIPreviewCatalogFilename,
         markdownImageLinkWidth: Float?,
         markdownImageLinkHeight: Float?,
         previewCatalogFilename: String) {
        self.baseDirectoryName = directoryName
        self.snapshotsDirectoryName = imageDirectoryName
        self.snapshotFilename = imageFilename
        self.markdownImageLinkWidth = markdownImageLinkWidth
        self.markdownImageLinkHeight = markdownImageLinkHeight
        self.previewCatalogFilename = previewCatalogFilename
    }
}

extension UIPreviewCatalogConfig {
    public static let defaultConfig: Self = .init(directoryName: "UIPreviewCatalog",
                                           imageDirectoryName: "Images",
                                           imageFilename: UIPreviewCatalogFilenameDefault(),
                                           markdownImageLinkWidth: 200,
                                           markdownImageLinkHeight: nil,
                                           previewCatalogFilename: "previewCatalog")
}
