## Locale Hub - Swift SDK

![](https://img.shields.io/github/v/release/locale-hub/sdk-swift)

### Table of Contents
* [Installation](#installation)
* [Usage](#usage)
* [Authors](#authors)

## Installation
To install Locale Hub SDK using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the
[tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)
using the URL for the Locale Hub SDK repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter https://github.com/locale-hub/sdk-swift.git

or you can add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/locale-hub/sdk-swift.git", from: "3.5.0"),
```

## Usage

The entry point of the library is the `LocaleHubSDK` class. You can use it as in the following example:

```swift
import LocaleHubSDK

/* this would load the offline bundle only */

let sdk = try? LocaleHubSDK()


/* this would load the offline bundle first, and look for translation patches online */

// let sdk = try! LocaleHubSDK(config: LocaleHubSDKConfiguration(
//     endpoint: "https://localehub.example.com/api/1",
//     projectId: "YOUR_PROJECT_ID",
//     deploymentTag: "YOUR_DEPLOYMENT_TAG",
//     apiKey: "YOUR_API_KEY"
// ))


/* you can override the list of preferred cultures
 * otherwise it defaults to system configuration */

sdk.preferredCultures = [.en_GB, .fr_FR]


/* to access localized strings, you must subscribe to the sdk.currentManifest publisher.
 * currenManifest auto-updated with:
 * - latest translation patches
 * - changes to the preferredCultures list
 */
let cancellable = sdk.currentManifest
    .sink { manifest in
        print(manifest("some_translation_key"))
    }
```

If you're interested in using LocaleHub in your SwiftUI app, we have a [specific package](https://github.com/locale-hub/sdk-apple) which makes the integration easier.

## Authors

- Bidon Aurélien ([@abidon](https://github.com/abidon))
- Pichon Jeremy ([@Jeremy-Pichon](https://github.com/Jeremy-Pichon))
