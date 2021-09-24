//
//  MarkdownList.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

/// Unordered Lists
public struct MarkdownList: MarkdownContent {
    public var content: String
    
    public init(items: [String]) {
        var content = ""
        items.forEach { item in
            content += "* \(item)\n"
        }
        self.content = content
    }
}

