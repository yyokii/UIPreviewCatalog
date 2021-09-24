//
//  MarkdownFileGenerator.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

import Foundation

import SwiftHelpers

public struct MarkdownFileGenerator {

    public let basePath: String
    public let filename: String
    public var mdContent: MarkdownContent

    public init(basePath: String, filename: String, content: MarkdownContent) {
        self.filename = filename.trimmingCharacters(in: .whitespacesAndNewlines)
        self.basePath = basePath.trimmingCharacters(in: .whitespacesAndNewlines)
        self.mdContent = content
    }

    public var filePath: String {
        return basePath.isEmpty ? "\(filename).md" : "\(basePath)/\(filename).md"
    }

    public func write() throws {
        try FileManager.default.createDirectory(at: basePath)
        let output = mdContent.content
        try output.write(toFile: filePath, atomically: true, encoding: .utf8)
    }
}
