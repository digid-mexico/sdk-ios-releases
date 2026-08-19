# DigidSDK — iOS Releases

Repositorio público de distribución del **SDK de Digid para iOS** (verificación KYC y firma digital de documentos).

El SDK se distribuye como un **XCFramework binario** vía Swift Package Manager. Los clientes solo apuntan a este repositorio; SPM descarga y resuelve todo automáticamente.

## Instalación

### Opción A — Xcode

1. **File → Add Package Dependencies…**
2. URL: `https://github.com/digid-mexico/sdk-ios-releases`
3. Regla de versión: **Exact → 1.10.0** (o *Up to Next Major Version* desde 1.10.0).
4. Agrega el producto **DigidSDK** a tu *app target*.

### Opción B — Package.swift (proyectos SPM puros)

```swift
// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MiApp",
    platforms: [.iOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/digid-mexico/sdk-ios-releases", exact: "1.10.0")
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
<key>NSLocationWhenInUseUsageDescription</key>
<string>Se requiere tu ubicación para registrarla como constancia al firmar documentos que así lo exigen.</string>
```

> `NSLocationWhenInUseUsageDescription` es obligatoria si alguno de tus documentos usa `required_gps`. Sin ella iOS **ignora la solicitud de permiso en silencio**: no aparece el diálogo, no llega ninguna lectura, y el firmante se topa con un error al final sin ninguna pista. Desde la 1.9.0 el SDK lo detecta y lo reporta en consola con `verboseLogging` activo.

Si usas Xcode 13 o posterior sin archivo `Info.plist`, agrégala en **Target → Info → Custom iOS Target Properties**, o como *build setting* `INFOPLIST_KEY_NSLocationWhenInUseUsageDescription`.

### Manifiesto de privacidad

Desde la 1.9.0 el SDK incluye su propio `PrivacyInfo.xcprivacy`, así que ya no recibirás avisos de App Store Connect por las APIs que usa. Declara los datos que el SDK recolecta (fotos y video, biométricos faciales, nombre, domicilio, identificador de usuario y ubicación precisa cuando el documento la exige), todos con propósito de funcionalidad de la app y sin seguimiento publicitario.

Sigue siendo tu responsabilidad declarar esos mismos datos en la **Nutrition Label** de tu ficha de App Store.

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
| 1.10.0  | 2026-08-19 | `DigidTheme.accentColor` para teñir las ilustraciones (opt-in). Al finalizar la firma se espera la lectura de ubicación en vuelo en vez de mostrar un error inmediato; entrega más rápida en interiores. Sin cambios breaking. **Versión recomendada.** |
| 1.9.0   | 2026-08-11 | `isApproved` ahora exige que el servidor haya aprobado. Firma con ubicación (`required_gps`). Manifiesto de privacidad incluido. Corrige un cierre inesperado al capturar la selfie de firma. Pantallas del motor de verificación en español. |
| 1.8.0   | 2026-08-03 | Pinch-zoom en la lectura del documento. La pantalla de T&C ahora la dicta el backend por cliente (sin cambios de integración). `addressData` agrega `municipio`, `colonia`, `numeroExterior`, `cruzamientos` y `parsingConfidence`. |
| 1.7.0   | 2026-07-21 | `KYCResult.sessionId` devuelve el identificador que envía el integrador. Nuevo error `duplicateSessionId` cuando ese id ya se usó. |
| 1.5.0   | 2026-07-02 | Resultado KYC ampliado, descarga automática de imágenes y video, control de logs.  |
| 1.4.1   | 2026-07-01 | Distribución como framework dinámico (compatibilidad con SDK de iOS 26+)            |
| 1.4.0   | 2026-06    | Enriquecimiento del resultado KYC                                                  |

> El historial completo está disponible en la pestaña **Releases** de este repositorio. Conserva siempre las versiones anteriores para clientes que fijen una versión específica.

## Novedades de la 1.10.0

### Color de acento en las ilustraciones — opt-in

`DigidTheme` agrega `accentColor`, que tiñe los elementos decorativos verde azulado de las ilustraciones del SDK (hoy, la pantalla de Términos y Condiciones):

```swift
DigidTheme(
    primaryColor: UIColor(hex: "#1A3C6E") ?? .systemBlue,
    secondaryColor: UIColor(hex: "#2D8CF0") ?? .blue,
    backgroundColor: .white,
    accentColor: UIColor(hex: "#1A3C6E") ?? .systemTeal   // opcional
)
```

> **Es opt-in a propósito**: si no lo configuras, las ilustraciones conservan su color original (`#6AC1B4`) — actualizar el SDK no cambia nada visualmente. Los botones y cabeceras siguen usando `primaryColor`; si quieres que la ilustración acompañe a tu tema, pasa `accentColor` explícitamente.

### Correcciones

- **Al finalizar la firma ya no aparece un error de ubicación inexistente.** Si la lectura seguía en vuelo al pulsar finalizar, se mostraba el error de inmediato. Ahora el botón indica "Obteniendo ubicación..." y el envío continúa solo al llegar la coordenada; el error solo aparece tras un fallo real.
- **Entrega de ubicación más rápida en interiores** (precisión a cien metros, suficiente para la constancia) y respaldo con la última ubicación conocida del sistema si la lectura falla.

## Novedades de la 1.9.0

### Correcciones que cambian resultados

- **`isApproved` ya no puede dar un falso positivo.** Antes combinaba solo los tres sub-checks biométricos, así que un rechazo por rostro duplicado, dispositivo o IP en lista de bloqueo, o AML llegaba con los tres en `true` y la propiedad devolvía aprobado. Ahora exige además que el servidor haya dictado `Approved`. **No cambia de firma, pero devuelve `false` en casos donde antes devolvía `true`**: si tu backend registraba aprobaciones a partir de esta propiedad, revisa tus registros históricos.
- **Los puntajes del resultado parcial ya no se inventan.** Cuando el servidor no alcanza a entregar los datos completos, `faceMatchScore` y `livenessScore` llegan en `0.0` en vez de un `100.0` fabricado. Usa `ready` para distinguir un resultado completo de uno degradado — antes venía siempre en `true`, ahora refleja la realidad.
- **Respuestas parciales del servidor ya no rompen el resultado.** Un campo nulo o ausente en el bloque de verificación tumbaba la decodificación completa y el SDK reportaba un error genérico en vez de entregar el resultado.

### Novedades

- **Firma con ubicación**: los documentos con `required_gps` ya se pueden firmar. El SDK verifica que declares `NSLocationWhenInUseUsageDescription`, solicita el permiso, y corta antes de enviar si no consigue la lectura, con opción de reintentar o abrir Ajustes. Antes el servidor respondía con error y revertía la operación **después** de que el usuario aceptó cada punto de firma.
- **Manifiesto de privacidad** (`PrivacyInfo.xcprivacy`) incluido en el XCFramework. Elimina los avisos de App Store Connect al subir tu build, incluido el ITMS-91053 por APIs que tu código nunca invoca.
- **Pantallas del motor de verificación en español**. Antes salían en inglés por el idioma por defecto del proveedor.

### Correcciones de estabilidad

- **Cierre inesperado al capturar la selfie de firma**: el callback de la cámara tocaba la interfaz desde una cola interna de AVFoundation. Podía producir corrupción visual o un cierre de tu app.

## Novedades de la 1.8.0

- **Zoom en el visor de documentos**: pinch para acercar hasta 4x en la vista de lectura antes de firmar. El progreso de lectura no retrocede al hacer zoom.
- **Términos y Condiciones por cliente**: Digid puede deshabilitar la pantalla de T&C del SDK para tu `clientId` (útil si tu app ya muestra términos propios). No requiere ningún cambio de integración; contacta a Digid para configurarlo.
- **Domicilio desglosado**: `KYCAddress` agrega `municipio`, `colonia`, `numeroExterior`, `cruzamientos` y `parsingConfidence`, también presentes en el JSON de `toJSON()` dentro de `address_data`.
- Ajustes visuales en la aplicación de firmas.

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
