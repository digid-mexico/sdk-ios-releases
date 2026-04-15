import PackageDescription

let package = Package(
    name: "DigidSDK",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "DigidSDK", targets: ["DigidSDKBundle"])
    ],
    targets: [
        .binaryTarget(
            name: "DigidSDK",
            url: "https://github.com/digid-mexico/sdk-ios/releases/download/1.1.0/DigidSDK-1.1.0.xcframework.zip",
            checksum: "9b00609989b8efbe00e34bb682683c401eb03ef1fb8d195c6f257046fb30cb58" // DigidSDK
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
        ),
        .target(
            name: "DigidSDKBundle",
            dependencies: [
                "DigidSDK",
                "DiditSDKBinary",
                "OpenSSLBinary"
            ],
            path: "Sources/DigidSDKBundle"
        )
    ]
)
