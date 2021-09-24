//
//  FileManager+CreateDirectory.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/24.
//

import Foundation

extension FileManager {
    public func createDirectory(at path: String) throws {
        guard path.isEmpty == false else {
            return
        }
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) == false {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
