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

public class UIPreviewCatalog {
    
    typealias SavedItem = (name: String, fileName: String)
    
    let config: UIPreviewCatalogConfig
    let snapshotFilenameExtension = ".jpg"
    
    var savedSnapshots: [SavedItem] = []
    
    public init(config: UIPreviewCatalogConfig) {
        self.config = config
    }
    
    public func createCatalog(previewItems: [PreviewItem]) throws {
        savedSnapshots.removeAll()
        
        // Create Directory
        let snapshotsDirectoryPath = try getSnapShotsDirectoryPath()
        try FileManager.default.createDirectory(at: snapshotsDirectoryPath)
        
        // Generate Snapshots and Markdown
        try snapshotAll(previewItems: previewItems)
        let markdownContent = generateMarkdownContent(previewItemsCount: previewItems.count,
                                                      savedSnapshots: savedSnapshots,
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
                    #warning("check failed case")
                    savedSnapshots.append((name: filename, fileName: filename))
                } else {
                    #warning("need throw?")
                    print("No.\(index+1) of \(item.name) with the display name \(preview.displayName ?? "(empty)") could not be saved.")
                }
            }
        }
    }
    
    private func saveMarkdown(previewItemsCount: Int, savedSnapshots: [SavedItem], config: UIPreviewCatalogConfig) {
        
    }
    
    private func generateMarkdownContent(previewItemsCount: Int, savedSnapshots: [SavedItem], config: UIPreviewCatalogConfig) -> MarkdownContent {
        let title = "UI Preview Catalog"
        let description = """
        This is a list of Previews that conform to PreviewProvider.
        Number of Views: \(previewItemsCount)
        Number of preview patterns: \(savedSnapshots.count)
        """
        let previewsHeader = "Previews"
        
        let mdTitle: MarkdownHeader = .init(level: .h1, header: title)
        let mdDescription: MarkdownContentNormal = .init(content: description)
        let mdPreviewsHeader: MarkdownHeader = .init(level: .h2, header: previewsHeader)
        
        var outputMd = mdTitle + mdDescription + mdPreviewsHeader
        
        savedSnapshots.forEach {
            let mdPreviewItemName = MarkdownContentNormal(content: $0.name)
            let mdImageFileLink = MarkdownResizableImageLink(srcPath: "\(config.baseDirectoryName)/\($0.fileName)\(snapshotFilenameExtension)",
                                                             width: config.markdownImageLinkWidth,
                                                             height: config.markdownImageLinkHeight)
            
            outputMd = outputMd + mdPreviewItemName + mdImageFileLink
        }
        
        return outputMd
    }

    private func generateSnapshotFilename(item: PreviewItem, preview: _Preview, previewIndex: Int) -> String {
        var fileName = "\(item.name)"
        if let displayName = preview.displayName {
            fileName += "_\(displayName)"
        }
        fileName += "_\(previewIndex+1)"
        
        return fileName
    }

    private func saveSnapshot(of view: UIView, with name: String) throws {
        let snapShot: UIImage = view.asImage()
        if let data = snapShot.jpegData(compressionQuality: 0.8) {    
            let snapshotsPath = try getSnapShotsDirectoryPath()
            let saveDir = URL(fileURLWithPath: snapshotsPath, isDirectory: true)
            let filePath = saveDir.appendingPathComponent("\(name)\(snapshotFilenameExtension)")
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
        let directoryPath = "\(catalogPath)/\(config.imageDirectoryName)"
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
