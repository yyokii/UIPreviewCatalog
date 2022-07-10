//
//  UIPreviewCatalog.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/18.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit

import MarkdownGenerator

/// Class responsible for outputting images and markdown
public class UIPreviewCatalog {
    
    typealias SavedItem = (name: String, fileName: String)
    
    let config: UIPreviewCatalogConfig
    let imageFilenameExtension = ".jpg"
    
    var savedSnapshotsInfo: [SavedItem] = []
    
    public init(config: UIPreviewCatalogConfig) {
        self.config = config
    }
    
    /// Run image and markdown generation
    /// - Parameter previewItems: Preview information to be used as output source
    /// - Throws: An error of type `Error`
    public func createCatalog(previewItems: [PreviewItem]) throws {
        savedSnapshotsInfo.removeAll()
        
        // Create Directory
        let snapshotsDirectoryPath = try getSnapShotsDirectoryPath()
        try FileManager.default.createDirectory(at: snapshotsDirectoryPath)
        
        // Generate Snapshots and Markdown
        try snapshotAll(previewItems: previewItems)
        let markdownContent = generateMarkdownContent(previewItemsCount: previewItems.count,
                                                      savedSnapshotsInfo: savedSnapshotsInfo,
                                                      config: config)
        let markdownBasePath = try getUIPreviewCatalogDirectoryPath()
        let mdGenerator = MarkdownFileGenerator(basePath: markdownBasePath,
                                                filename: config.previewCatalogFilename,
                                                content: markdownContent)
        try mdGenerator.write()
    }
    
    private func snapshotAll(previewItems: [PreviewItem]) throws {
        let window = UIWindow(frame: UIScreen.main.bounds)
        for item in previewItems {
            for (index, preview) in item.previews.enumerated() {
                window.rootViewController = UIHostingController(rootView: preview.content)
                window.makeKeyAndVisible()
                
                let filename = generateSnapshotFilename(item: item, preview: preview, previewIndex: index)
                
                if let targetView = window.rootViewController?.view {
                    try saveSnapshot(of: targetView, with: filename)
                    savedSnapshotsInfo.append((name: filename, fileName: filename))
                } else {
                    print("No.\(index+1) of \(item.name) with the display name \(preview.displayName ?? "(empty)") could not be saved.")
                }
            }
        }
    }
    
    private func generateMarkdownContent(previewItemsCount: Int, savedSnapshotsInfo: [SavedItem], config: UIPreviewCatalogConfig) -> MarkdownContent {
        let title = "UI Preview Catalog"
        let description = """
        This is a list of Previews that conform to PreviewProvider.\n
        Number of Views: \(previewItemsCount)\n
        Number of preview patterns: \(savedSnapshotsInfo.count)
        """
        let previewsHeader = "Previews"
        
        let mdTitle: MarkdownHeader = .init(level: .h1, header: title)
        let mdDescription: MarkdownContentNormal = .init(content: description)
        let mdPreviewsHeader: MarkdownHeader = .init(level: .h2, header: previewsHeader)
        
        var outputMd = mdTitle + mdDescription + mdPreviewsHeader
        
        savedSnapshotsInfo.forEach {
            let mdPreviewItemName = MarkdownContentNormal(content: $0.name)
            let mdImageFileLink = MarkdownResizableImageLink(srcPath: "\(config.snapshotsDirectoryName)/\($0.fileName)\(imageFilenameExtension)",
                                                             width: config.markdownImageLinkWidth,
                                                             height: config.markdownImageLinkHeight)
            
            outputMd = outputMd + mdPreviewItemName + mdImageFileLink
        }
        
        return outputMd
    }

    private func generateSnapshotFilename(item: PreviewItem, preview: _Preview, previewIndex: Int) -> String {
        config.snapshotFilename.generateSnapshotFilename(item: item, preview: preview, previewIndex: previewIndex)
    }

    private func saveSnapshot(of view: UIView, with name: String) throws {
        let snapShot: UIImage = view.asImage()
        if let data = snapShot.jpegData(compressionQuality: 0.8) {    
            let snapshotsPath = try getSnapShotsDirectoryPath()
            let saveDir = URL(fileURLWithPath: snapshotsPath, isDirectory: true)
            let filePath = saveDir.appendingPathComponent("\(name)\(imageFilenameExtension)")
            try data.write(to: filePath)
        } else {
            throw UIPreviewCatalogError.failedToCreateImageData
        }
    }
    
    private func getUIPreviewCatalogDirectoryPath() throws -> String {
        let basePath = try getBaseDirectoryPath()
        let directoryPath = "\(basePath)/\(config.baseDirectoryName)"
        return directoryPath
    }
    
    private func getSnapShotsDirectoryPath() throws -> String {
        let catalogPath = try getUIPreviewCatalogDirectoryPath()
        let directoryPath = "\(catalogPath)/\(config.snapshotsDirectoryName)"
        return directoryPath
    }

    private func getBaseDirectoryPath() throws -> String {
        if let path = ProcessInfo.processInfo.environment["PREVIEW_CATALOG_PATH"] {
            return path
        } else {
            throw UIPreviewCatalogError.invalidOutputPath
        }
    }
}

#endif
