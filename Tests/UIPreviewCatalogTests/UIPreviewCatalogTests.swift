import XCTest
import SwiftUI

@testable import UIPreviewCatalog

final class UIPreviewCatalogTests: XCTestCase {

    struct TestView: View {
        var body: some View {
            EmptyView()
        }
    }

    struct TestView_Previews: PreviewProvider {
        static var previews: some View {
            TestView()
        }
    }

    func testOutputPNG() throws {
        let catalog = UIPreviewCatalog(config: .init(
            directoryName: "UIPreviewCatalog",
            imageDirectoryName: "Images",
            imageFormat: .png,
            markdownImageLinkWidth: 100,
            markdownImageLinkHeight: 100,
            previewCatalogFilename: "previewCatalog")
        )
        try catalog.createCatalog(previewItems: [.init(name: "Test", previews: TestView_Previews._allPreviews)])
    }

    func testOutputJPG() throws {
        let catalog = UIPreviewCatalog(config: .init(
            directoryName: "UIPreviewCatalog",
            imageDirectoryName: "Images",
            imageFormat: .jpg(compressionQuality: 0.8),
            markdownImageLinkWidth: 100,
            markdownImageLinkHeight: 100,
            previewCatalogFilename: "previewCatalog")
        )
        try catalog.createCatalog(previewItems: [.init(name: "Test", previews: TestView_Previews._allPreviews)])
    }
}

