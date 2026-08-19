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
            url: "https://github.com/digid-mexico/sdk-ios-releases/releases/download/1.10.0/DigidSDK-1.10.0.xcframework.zip",
            checksum: "02978df54ee672c83773fbb7f2e7089b6a00b096884aac027384fb17d935cefb"
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
