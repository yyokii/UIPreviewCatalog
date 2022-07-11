import Foundation
import SwiftUI

public protocol UIPreviewCatalogFilename {
    func generateSnapshotFilename(item: PreviewItem, preview: _Preview, previewIndex: Int) -> String
}

struct UIPreviewCatalogFilenameDefault: UIPreviewCatalogFilename {
    func generateSnapshotFilename(item: PreviewItem, preview: _Preview, previewIndex: Int) -> String {
        var fileName = "\(item.name)_\(previewIndex+1)"
        if let displayName = preview.displayName {
            fileName += "_\(displayName)"
        }
        return fileName
    }
}
