// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DigidSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "DigidSDK", targets: ["DigidSDK", "DiditSDKBinary", "OpenSSLBinary"])
    ],
    targets: [
        .binaryTarget(
            name: "DigidSDK",
            url: "https://github.com/digid-mexico/sdk-ios-releases/releases/download/1.4.0/DigidSDK-1.4.0.xcframework.zip",
            checksum: "dd67398a73847779e5d2b6aa82c6ffbd69f7fe4b4e83b2a4431985e8a5f94755"
        ),
        .binaryTarget(
            name: "DiditSDKBinary",
            url: "https://github.com/didit-protocol/sdk-ios/releases/download/3.2.9/DiditSDK.xcframework.zip",
            checksum: "4b6edc73add1824933a28676c28a26ca88818015ba45bba427254b1beed16620"
        ),
        .binaryTarget(
            name: "OpenSSLBinary",
            url: "https://github.com/didit-protocol/sdk-ios/releases/download/3.2.9/OpenSSL.xcframework.zip",
            checksum: "85cc0052584d083df65e823ca94c4b15e8c1edc3e21b58a4cbcff6ae6b06e20c"
        )
    ]
)
