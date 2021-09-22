//
//  SnapshotUIView.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/18.
//

import Foundation
import SwiftUI

#if canImport(UIKit)

import UIKit

struct UIPreviewCatalog {
    
    public static func snapshotAll(previewItems: [PreviewItem]) {
        for item in previewItems {
            for (index, preview) in item.previews.enumerated() {
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = UIHostingController(rootView: preview.content)
                window.makeKeyAndVisible()
                
                let fileName = generateSnapshotFileName(item: item, preview: preview, previewIndex: index)
                
                if let targetView = window.rootViewController?.view {
                    recordSnapshot(of: targetView, with: fileName)
                }
            }
        }
    }

    public static func generateSnapshotFileName(item: PreviewItem, preview: _Preview, previewIndex: Int) -> String {
        var fileName = "\(item.name)"
        if let displayName = preview.displayName {
            fileName += "_\(displayName)"
        }
        fileName += "_\(previewIndex+1)"
        
        return fileName
    }

   public static func recordSnapshot(of view: UIView, with name: String) {
        let snapShot: UIImage = view.asImage()
        saveImage(of: snapShot, with: name)
    }

   public static func saveImage(of image: UIImage, with name: String) {
        if let data = image.jpegData(compressionQuality: 0.8) {
            let now = Date()
            
            let path = getSaveDirectoryPath()
            let pathURL = URL(fileURLWithPath: path, isDirectory: true)
            
            let saveDir = pathURL.appendingPathComponent("Images_\(now)")
            let filePath = saveDir.appendingPathComponent("\(name).jpg")
            #warning("check existance")
            do {
                try FileManager.default.createDirectory(at: saveDir,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
                try data.write(to: filePath)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    public static func getSaveDirectoryPath() -> String {
        let path = ProcessInfo.processInfo.environment["PREVIEW_CATALOG_PATH"] ?? ""
        return path
    }
}

#endif
