import class Foundation.Bundle

extension Foundation.Bundle {
    static var module: Bundle = {
        let mainPath = "/Applications/Xcode-12.5.1.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/Sourcery_SourceryLibTests.bundle"
        let buildPath = "/Users/yoki/Downloads/Sourcery-1.5.0/.build/x86_64-apple-macosx/release/Sourcery_SourceryLibTests.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle != nil ? preferredBundle : Bundle(path: buildPath) else {
            fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}