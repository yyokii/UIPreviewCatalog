//
//  MarkdownContent.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

public protocol MarkdownContent {
    var content: String { get }
}

public struct MarkdownContentNormal: MarkdownContent {
    public var content: String
    
    public init(content: String) {
        self.content = content
    }
}

public func +(lhs: MarkdownContent, rhs: MarkdownContent) -> MarkdownContentNormal{
    let content = lhs.content + "\n\n" + rhs.content
    return MarkdownContentNormal(content: content)
}
