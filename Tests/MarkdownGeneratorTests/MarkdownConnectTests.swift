//
//  MarkdownConnectTests.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

import XCTest
@testable import MarkdownGenerator

class MarkdownConnectTests: XCTestCase {
    
    func testConnectContent() {
        
        // Given
        let title = "This is a header."
        let description = """
        This is a list of Previews that conform to PreviewProvider.
        Number of Views: 12
        Number of preview patterns: 120
        """
        let previewsHeader = "Previews"
        let previewDetail = "This is a detail"
        let mdTitle = MarkdownHeader(level: .h1, header: title)
        let mdDescription = MarkdownContentNormal(content: description)
        let mdPreviewsHeader = MarkdownHeader(level: .h2, header: previewsHeader)
        let mdPreviewDetail = MarkdownContentNormal(content: previewDetail)

        XCTContext.runActivity(named: "ConnectHeaderAndNormalContent") { _ in
            let connected = mdTitle + mdDescription + mdPreviewsHeader + mdPreviewDetail
            let result = connected.content
            let expectation = """
            # \(title)
            
            \(description)
            
            ## \(previewsHeader)
            
            \(previewDetail)
            """
            XCTAssertEqual(result, expectation)
        }
    }
}
