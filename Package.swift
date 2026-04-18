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
            url: "https://github.com/digid-mexico/sdk-ios-releases/releases/download/1.1.2/DigidSDK-1.1.2.xcframework.zip",
            checksum: "7d958ecbc3fcacfa8e29d8052dad3d968234a875df3e0be7585e194a6d3f6ffa"
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
