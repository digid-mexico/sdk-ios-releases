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
            url: "https://github.com/digid-mexico/sdk-ios-releases/releases/download/1.9.0/DigidSDK-1.9.0.xcframework.zip",
            checksum: "cb808eb5063ae7d8420e979a95450a6363841540c1a9fecb8ccc3934ee591007"
        ),
        .binaryTarget(
            name: "DiditSDKBinary",
            url: "https://github.com/didit-protocol/sdk-ios/releases/download/4.5.3/DiditSDK.xcframework.zip",
            checksum: "0d491674542dda6007c287358b3207df090cb8c98b6659909edc3877881c18ba"
        ),
        .binaryTarget(
            name: "OpenSSLBinary",
            url: "https://github.com/didit-protocol/sdk-ios/releases/download/4.5.3/OpenSSL.xcframework.zip",
            checksum: "19597104b8c673f50175b04f4f3b11fcf7365e1923908ffe7d0fa1d44ff3f0f5"
        )
    ]
)
