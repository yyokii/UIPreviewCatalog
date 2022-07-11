//
//  PreviewItem.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/19.
//

import SwiftUI

/// Preview Information
public struct PreviewItem {
    public let name: String
    let previews: [_Preview]
    
    public init(name: String, previews: [_Preview]){
        self.name = name
        self.previews = previews
    }
}
