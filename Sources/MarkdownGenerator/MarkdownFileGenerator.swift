//
//  MarkdownFileGenerator.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

import Foundation

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
//        try createDirectory(path: basePath)
        let output = mdContent.content
        try output.write(toFile: filePath, atomically: true, encoding: .utf8)
    }

//    private func createDirectory(path: String) throws {
//        guard path.isEmpty == false else {
//            return
//        }
//        var isDir: ObjCBool = false
//        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) == false {
//            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//        }
//    }
}
