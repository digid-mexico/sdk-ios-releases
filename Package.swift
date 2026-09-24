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
            url: "https://github.com/digid-mexico/sdk-ios-releases/releases/download/1.13.0/DigidSDK-1.13.0.xcframework.zip",
            checksum: "3c4c9169a6a266a3e65640437c9168415ae56b852e4d93126ad13d61adcaa188"
        ),
        .binaryTarget(
            name: "DiditSDKBinary",
            url: "https://github.com/didit-protocol/sdk-ios/releases/download/4.7.2/DiditSDK.xcframework.zip",
            checksum: "e4c7b75f28be2f0ae2ced64b8e62fbaaeb49236f72beb22e0c1f2a3db0502400"
        ),
        .binaryTarget(
            name: "OpenSSLBinary",
            url: "https://github.com/didit-protocol/sdk-ios/releases/download/4.7.2/OpenSSL.xcframework.zip",
            checksum: "aae7c2d631e2d44459e91d5820e6550ad0741824a579ada2137a013f6dec36f2"
        )
    ]
)
