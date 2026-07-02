# DigidSDK — iOS Releases

Repositorio público de distribución del **SDK de Digid para iOS** (verificación KYC y firma digital de documentos).

El SDK se distribuye como un **XCFramework binario** vía Swift Package Manager. Los clientes solo apuntan a este repositorio; SPM descarga y resuelve todo automáticamente.

## Instalación

### Opción A — Xcode

1. **File → Add Package Dependencies…**
2. URL: `https://github.com/digid-mexico/sdk-ios-releases`
3. Regla de versión: **Exact → 1.5.0** (o *Up to Next Major Version* desde 1.5.0).
4. Agrega el producto **DigidSDK** a tu *app target*.

### Opción B — Package.swift (proyectos SPM puros)

```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MiApp",
    platforms: [.iOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/digid-mexico/sdk-ios-releases", exact: "1.5.0")
    ],
    targets: [
        .target(name: "MiApp", dependencies: [
            .product(name: "DigidSDK", package: "sdk-ios-releases")
        ])
    ]
)
```

### Permisos — Info.plist

```xml
<key>NSCameraUsageDescription</key>
<string>Se requiere la cámara para verificar tu identidad y capturar tu firma.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Se requiere el micrófono para el video de prueba de vida.</string>
```

## Inicialización

```swift
import DigidSDK

Digid.shared.configure(
    token: token,
    clientId: clientId,
    environment: .sandbox   // .production en producción
)
```

Consulta el **Manual de Integración** para el detalle de los módulos KYC y de firma, el objeto `KYCResult` y la personalización visual.

## Versiones disponibles

| Versión | Fecha      | Novedades                                                                          |
|---------|------------|------------------------------------------------------------------------------------|
| 1.5.0   | 2026-07-02 | Resultado KYC ampliado, descarga automática de imágenes y video, control de logs.  |
| 1.4.1   | 2026-07-01 | Distribución como framework dinámico (compatibilidad con SDK de iOS 26+)            |
| 1.4.0   | 2026-06    | Enriquecimiento del resultado KYC                                                  |

> El historial completo está disponible en la pestaña **Releases** de este repositorio. Conserva siempre las versiones anteriores para clientes que fijen una versión específica.

## Novedades de la 1.5.0

- **`KYCResult` ampliado**: nuevos `status`, `ready`, `livenessMethod`, `ageEstimation`, `faceQuality`, `ipAnalysis` y `pdfUrl`.
- **`KYCDocument` más completo**: `personalNumber`, `dateOfIssue`, `placeOfBirth`, `age`, domicilio estructurado (`addressData` → `KYCAddress`) y campos OCR adicionales (`extraFieldsJson`).
- **Imágenes listas para usar**: el SDK descarga automáticamente frente, reverso, selfie y retrato, entregados como `UIImage` (`idFrontImage`, `idBackImage`, `selfieImage`, `portraitImage`), además de sus URLs remotas.
- **Video de prueba de vida**: descargado a un archivo local listo para reproducir (`livenessVideoLocalURL`) y con la URL remota (`livenessVideoURL`).
- **Control de logs**: `Digid.shared.verboseLogging` y `Digid.shared.engineLoggingEnabled` (ambos desactivados por defecto).

### Notas de migración (desde 1.4.x)

- La **API pública de Swift es compatible**: los cambios son aditivos y el código existente sigue compilando.
- **Cambio en el JSON de salida**: `toJSON()` agrupa lo biométrico bajo `verification` (antes `kyc`) e incluye `images`, `ip_analysis`, `pdf_url` y `liveness_video`. Si tu backend leía la clave `kyc`, actualízala a `verification`.

## Requisitos

- **iOS 14+**
- **Swift 5.7+**
- **Xcode 15+**

## Soporte

Distribución confidencial para integradores autorizados de Digid.
