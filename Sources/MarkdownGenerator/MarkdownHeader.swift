//
//  MarkdownHeader.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

public struct MarkdownHeader: MarkdownContent {
    
    public enum Level: Int {
        case h1 = 1
        case h2
        case h3
        case h4
        case h5
        case h6
    }
    
    public var content: String
    
    public init(level: Level, header: String) {
        let content: String = .init(repeating: "#", count: level.rawValue) + " " + header
        self.content = content
    }
}

