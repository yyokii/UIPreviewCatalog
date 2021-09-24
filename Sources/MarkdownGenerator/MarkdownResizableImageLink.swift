//
//  MarkdownResizableImageLink.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

public struct MarkdownResizableImageLink: MarkdownContent {
    public var content: String
    
    public init(srcPath: String, width: Float?, height: Float?) {
        var imageWidth: String = ""
        var imageHeight: String = ""
        
        if let width = width {
            imageWidth = "\(width)"
        }
        
        if let height = height {
            imageHeight = "\(height)"
        }
        
        let content = "<img src=\"\(srcPath)\" width=\"\(imageWidth)\" height=\"\(imageHeight)\">"
        self.content = content
    }
}
