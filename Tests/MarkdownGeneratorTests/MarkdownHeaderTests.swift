//
//  MarkdownHeaderTests.swift
//  
//
//  Created by Higashihara Yoki on 2021/09/23.
//

import XCTest
@testable import MarkdownGenerator

class MarkdownHeaderTests: XCTestCase {
    
    func testGenerateContent_WhenHeaderLevelGiven_OutputValidMarkdownString() {
        
        // Given
        let header = "This is a header."
        
        XCTContext.runActivity(named: "h1") { _ in
            let result = MarkdownHeader(level: .h1, header: header).content
            let expectation = "# \(header)"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "h2") { _ in
            let result = MarkdownHeader(level: .h2, header: header).content
            let expectation = "## \(header)"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "h3") { _ in
            let result = MarkdownHeader(level: .h3, header: header).content
            let expectation = "### \(header)"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "h4") { _ in
            let result = MarkdownHeader(level: .h4, header: header).content
            let expectation = "#### \(header)"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "h5") { _ in
            let result = MarkdownHeader(level: .h5, header: header).content
            let expectation = "##### \(header)"
            
            XCTAssertEqual(result, expectation)
        }
        
        XCTContext.runActivity(named: "h6") { _ in
            let result = MarkdownHeader(level: .h6, header: header).content
            let expectation = "###### \(header)"
            
            XCTAssertEqual(result, expectation)
        }
    }
}
