//
//  UIPreviewCatalog.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/18.
//

import Foundation
import SwiftUI
import XCTest

#if canImport(UIKit)

import UIKit

public struct UIPreviewCatalog {
    
    public static func snapshotAll(previewItems: [PreviewItem]) {
        for item in previewItems {
            for (index, preview) in item.previews.enumerated() {
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = UIHostingController(rootView: preview.content)
                window.makeKeyAndVisible()
                
                let fileName = generateSnapshotFileName(item: item, preview: preview, previewIndex: index)
                
                if let targetView = window.rootViewController?.view {
                    recordSnapshot(of: targetView, with: fileName)
                } else {
                    print("No.\(index+1) of \(item.name) with the display name \(preview.displayName ?? "(empty)") could not be saved.")
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
                XCTFail("Failed to output the file. We apologize for the inconvenience, please report it on GitHub.")
                print(error.localizedDescription)
            }
        }
    }

    public static func getSaveDirectoryPath() -> String {
        if let path = ProcessInfo.processInfo.environment["PREVIEW_CATALOG_PATH"] {
            return path
        } else {
            XCTFail("Set PREVIEW_CATALOG_PATH in the Environment Variables to specify the output location of the file.")
            return ""
        }
    }
}

#endif
