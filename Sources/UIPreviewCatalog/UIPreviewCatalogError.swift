//
//  UIPreviewCatalogError.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/24.
//

import Foundation

enum UIPreviewCatalogError: Error, LocalizedError {
    case failedToCreateImageData
    case failedToSaveImage
    case invalidOutputPath
    
    var errorDescription: String? {
        switch self {
        case .failedToCreateImageData:
            return "Failed to generate image data."
        case .failedToSaveImage:
            return "Failed to output the file. We apologize for the inconvenience, please report it on GitHub."
        case .invalidOutputPath:
            return "Set PREVIEW_CATALOG_PATH in the Environment Variables to specify the output location of the file."
        }
    }
}
