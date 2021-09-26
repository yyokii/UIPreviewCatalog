//
//  MarkdownContentNormal.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/26.
//

public struct MarkdownContentNormal: MarkdownContent {
    public var content: String
    
    public init(content: String) {
        self.content = content
    }
}
