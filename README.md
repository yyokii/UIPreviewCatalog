# UIPreviewCatalog

UIPreviewCatalog is a library that takes snapshots of SwiftUI's Preview and generates Markdown that lists them.

It outputs a list of snapshot images of the View describing the Preview, and Markdown like the following.

<img width="400" alt="outputs" src="https://user-images.githubusercontent.com/20992687/134666975-f0b173cc-8367-404b-9c6a-89c079d27752.png">

<img width="400" alt="output_markdown" src="https://user-images.githubusercontent.com/20992687/134667079-bb2d7de4-444b-474a-a5da-21ed8d1f499e.png">

The demo project is here.  
[yyokii/DemoUIPreviewCatalog](https://github.com/yyokii/DemoUIPreviewCatalog)

## Usage

There are three steps to follow.

      1. install the library
      2. generate the `PreviewItem` array
      3. generate snapshot and Markdown files

### 1. Installing the library

Since it does not affect the functionality of the application, add the dependency to the test target.

It can be installed using the [Swift Package Manager](https://swift.org/package-manager/#conceptual-overview).  
It can be installed via Xcode or the `Package.swift` manifest.

### 2. Generate the `PreviewItem` array

There is a `struct` called `PreviewItem` in this library, which is the target of creating a snapshot.  
You can define it yourself as follows, or you can use an existing code generator to simplify it.  
The file you create should be included in your test target.

```swift
import SwiftUI
import UIPreviewCatalog
@testable import DemoUIPreviewCatalog

let previewItems: [PreviewItem] = [
    .init(name: "BlueView_Previews", previews: BlueView_Previews._allPreviews),
    .init(name: "ContentView_Previews", previews: ContentView_Previews._allPreviews),
]
```

#### Code generation using [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

In an application under development, it is troublesome to manually create the `PreviewItem` array as described above. So, let's use [Sourcery](https://github.com/krzysztofzablocki/Sourcery) to extract the `struct` that conforms to the `PreviewProvider` and generate the `PreviewItem` array.

First, install [Sourcery](https://github.com/krzysztofzablocki/Sourcery).  
Then, create a template file for source generation.  
The template file is [PreviewItem.stencil](https://github.com/yyokii/DemoUIPreviewCatalog/blob/main/PreviewItem.stencil). Please create the same one.

Then use the [Sourcery](https://github.com/krzysztofzablocki/Sourcery) command to generate the code.  
A sample is shown below.  

```
$ sourcery \
   --sources /Users/{Foo}/Desktop/DemoUIPreviewCatalog/DemoUIPreviewCatalog \
   --templates /Users/{Foo}/Desktop/PreviewItem.stencil   \
   --output /Users/{Foo}/Desktop/DemoUIPreviewCatalog/DemoUIPreviewCatalogTests \
   --args mainTarget=DemoUIPreviewCatalog
```

`--sources` : Specify the path to analyze the sources. Here, the main target of the application is specified.

`--templates`: Specify the path to the template files. We will use the ones we created earlier.

`--output`: Specify the path where the generated code will be placed. It is to be included in the test target.

`--args` : Give an arbitrary variable. The generated file will be placed in the test target, but since it uses the Preview information of the main target, we need to write `@testable import DemoUIPreviewCatalog` to resolve the reference. Therefore, here we specify the module name of the main target of the application.

Executing this will generate the following file.  

```swift
import SwiftUI
import UIPreviewCatalog
@testable import DemoUIPreviewCatalog

let previewItems: [PreviewItem] = [
    .init(name: "BlueView_Previews", previews: BlueView_Previews._allPreviews),
    .init(name: "ContentView_Previews", previews: ContentView_Previews._allPreviews),
]
```

### 3. Generate snapshot and Markdown files

Set the environment variable in Edit Scheme of Xcode.
Name : `PREVIEW_CATALOG_PATH`.  
Value : The output path for images and markdown. For example, `$(SOURCE_ROOT)`.  

<img width="500" alt="add_environment_variable" src="https://user-images.githubusercontent.com/20992687/134667267-edf3290e-1790-47f0-8858-e8f78b057c5e.png">

Output a snapshot and a Markdown file.  
The file will be output by executing `createCatalog(previewItems:)` as shown below.

```swift
func testOutputUIPreviewCatalog() {
    let catalog = UIPreviewCatalog(config: .defaultConfig)
    do {
        try catalog.createCatalog(previewItems: previewItems)
    } catch {
        print(error.localizedDescription)
        XCTFail()
    }
}
```

## Contributions

Pull requests and issues are always welcome. Please open any issues and PRs for bugs, features, or documentation.

## License

UIPreviewCatalog is licensed under the MIT license. See [LICENSE](https://github.com/yyokii/UIPreviewCatalog/blob/main/LICENSE) for more info.
