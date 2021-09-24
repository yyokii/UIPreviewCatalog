//
//  File.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/24.
//

public struct UIPreviewCatalogConfig {
    public let baseDirectoryName: String
    public let imageDirectoryName: String
    public let markdownImageLinkWidth: Float?
    public let markdownImageLinkHeight: Float?
    public let previewCatalogFilename: String
    
    init(directoryName: String,
         imageDirectoryName: String,
         markdownImageLinkWidth: Float?,
         markdownImageLinkHeight: Float?,
         previewCatalogFilename: String) {
        self.baseDirectoryName = directoryName
        self.imageDirectoryName = imageDirectoryName
        self.markdownImageLinkWidth = markdownImageLinkWidth
        self.markdownImageLinkHeight = markdownImageLinkHeight
        self.previewCatalogFilename = previewCatalogFilename
    }
}

extension UIPreviewCatalogConfig {
    static let defaultConfig: Self = .init(directoryName: "UIPreviewCatalog",
                                           imageDirectoryName: "Images",
                                           markdownImageLinkWidth: 200,
                                           markdownImageLinkHeight: nil,
                                           previewCatalogFilename: "previewCatalog")
}
