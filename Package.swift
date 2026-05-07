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
            url: "https://github.com/digid-mexico/sdk-ios-releases/releases/download/1.2.1/DigidSDK-1.2.1.xcframework.zip",
            checksum: "f138286eb248c4c8df5e1a7e3381764003a72f03413bfeb2cb61366297bb5640"
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
