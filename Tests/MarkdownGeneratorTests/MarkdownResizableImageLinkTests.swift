//
//  MarkdownResizableImageLinkTests.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

import XCTest
@testable import MarkdownGenerator

class MarkdownResizableImageLinkTests: XCTestCase {
    
    func testGenerateContent_WhenInputGiven_OutputValidMarkdownString() {
        
        // Given
        let srcPath = "image/demo.jpg"
        
        XCTContext.runActivity(named: "GiveWidthAndHeight") { _ in
            let width: Float = 200
            let height: Float = 200
            
            let result = MarkdownResizableImageLink(srcPath: srcPath, width: width, height: height).content
            let expectation = "<img src=\"\(srcPath)\" width=\"\(width)\" height=\"\(height)\">"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "GiveWidth") { _ in
            let width: Float = 200
            let height: Float? = nil
            
            let result = MarkdownResizableImageLink(srcPath: srcPath, width: width, height: height).content
            let expectation = "<img src=\"\(srcPath)\" width=\"\(width)\" height=\"\">"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "GiveHeight") { _ in
            let width: Float? = nil
            let height: Float = 200
            
            let result = MarkdownResizableImageLink(srcPath: srcPath, width: width, height: height).content
            let expectation = "<img src=\"\(srcPath)\" width=\"\" height=\"\(height)\">"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "GiveOnlySourcePath") { _ in
            let width: Float? = nil
            let height: Float? = nil
            
            let result = MarkdownResizableImageLink(srcPath: srcPath, width: width, height: height).content
            let expectation = "<img src=\"\(srcPath)\" width=\"\" height=\"\">"
            
            XCTAssertEqual(result, expectation)
        }
    }
}

