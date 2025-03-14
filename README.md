# Prueba Técnica - Desarrollador Mobile

## Resumen
Este proyecto demuestra cómo cambiar entre diferentes capas de persistencia (`SwiftData` y `CoreData`) utilizando principios de Arquitectura Limpia. La implementación garantiza que la decisión de usar `SwiftData` o `CoreData` se gestione dinámicamente en función de una configuración.

## Arquitectura
El proyecto sigue los principios de **Arquitectura Limpia**, asegurando bajo acoplamiento y alta escalabilidad. Incluye:

- **Arquitectura de Presentación MVVM**: Separa la lógica de negocio de la interfaz de usuario, facilitando el mantenimiento y la escalabilidad del código.
- **Patrón Coordinator**: Implementado a través de `AppCoordinator`, gestiona la navegación y flujo de la aplicación de manera centralizada, desacoplando la lógica de navegación de las vistas.
- **Implementación de Fábrica**: `ScanningListViewFactory` centraliza la creación de todas las capas (Presentación, Dominio y Datos), mejorando la mantenibilidad y flexibilidad.
- **Bajo Acoplamiento**: Los componentes interactúan a través de abstracciones, facilitando la extensión o modificación del sistema.
- **Swift + AVFoundation**: Integración con los frameworks multimedia de Apple para funcionalidades avanzadas.
- **Autenticación Biométrica**: Soporta Face ID y Touch ID para mayor seguridad.
- **Uso de Keychain**: Almacena de manera segura credenciales y datos sensibles.
- **Pruebas Unitarias**: Garantiza la confiabilidad de la aplicación validando las funcionalidades principales mediante pruebas automatizadas.

## Patrón Coordinator
El **Patrón Coordinator** permite gestionar la navegación de la aplicación de manera centralizada, asegurando una mejor organización del flujo de pantallas y la separación de responsabilidades. `AppCoordinator` maneja la autenticación y el enrutamiento de vistas sin acoplar la lógica de navegación a las propias vistas. Esto facilita la escalabilidad y la prueba de los flujos de usuario.

## Integración con Flutter

Siguiendo los principios de **Arquitectura Limpia**, la integración de Flutter en este proyecto se ha diseñado para ser modular, escalable y desacoplada. Esto se logra mediante el uso de un **protocolo de inyección de dependencias** que permite abstraer la inicialización de `FlutterEngine` y un **coordinador específico** para gestionar la navegación y comunicación con Flutter.

### **1. Desacoplamiento mediante un Protocolo**
En lugar de inicializar `FlutterEngine` directamente en `FlutterCoordinator`, se ha definido un protocolo `FlutterEngineProvider`, lo que permite inyectar diferentes implementaciones de `FlutterEngine` sin modificar la estructura del código. Esto facilita la escalabilidad y la realización de pruebas unitarias.

```swift
protocol FlutterEngineProvider {
    associatedtype FlutterView: View
    var engine: FlutterEngine { get }
    func createFlutterView() -> FlutterView
    func setupFlutterMethodChannel(viewController: FlutterViewController)
}
```

Una implementación concreta de este protocolo, `DefaultFlutterEngineProvider`, inicializa y gestiona el ciclo de vida del `FlutterEngine`:

```swift
class DefaultFlutterEngineProvider: FlutterEngineProvider {
    
    let engine: FlutterEngine
    
    typealias FlutterView = FlutterViewControllerWrapper
    
    init() {
        self.engine = FlutterEngine(name: FlutterConstants.primaryEngineName)
        self.engine.run()
    }
    
    func createFlutterView() -> FlutterViewControllerWrapper {
    }
    
    func setupFlutterMethodChannel(viewController: FlutterViewController) {
    }
}
```

### **2. Coordinador Específico para Flutter**
Se ha creado `FlutterCoordinator` para gestionar la navegación hacia Flutter y la comunicación mediante `MethodChannels`. Este coordinador recibe una instancia de `FlutterEngineProvider`, asegurando que la configuración del motor de Flutter se mantenga flexible y desacoplada.

```swift
class FlutterCoordinator {
     private let engineProvider: any FlutterEngineProvider
    
    init(engineProvider: any FlutterEngineProvider) {
        self.engineProvider = engineProvider
    }
    
    func createFlutterView() -> any View {
        engineProvider.createFlutterView()
    }
}
```


### **Conclusión**
Esta integración de Flutter en iOS sigue los principios de **Arquitectura Limpia**, permitiendo una separación clara de responsabilidades:

- **Protocolo para `FlutterEngine`**: Permite inyección de dependencias.
- **Coordinador Flutter**: Gestiona la navegación y la comunicación con iOS.
- **Uso de `MethodChannels`**: Facilita la interacción entre Flutter y Swift.

Gracias a esta estructura modular, la integración de nuevas funcionalidades en Flutter o la sustitución de `FlutterEngine` puede realizarse sin afectar la lógica de negocio ni la presentación de la app.


finalmnete se hace uso `FlutterEngine` y `FlutterViewController`.

   
**FlutterCoordinator.swif**
    - Inicializa `FlutterEngine` y gestiona la comunicación con Flutter.


Ejemplo de implementación en `AppCoordinator`:

```swift
func push(page: AppPages) {
    DispatchQueue.main.async {
        self.path.append(page)
    }
}

func popToRoot() {
    path = NavigationPath()
}
```

## Capturas de Pantalla

| Pantalla | Descripción |
|----------|------------|
| ![image](https://github.com/user-attachments/assets/9f22622d-98a0-4a82-8ce5-7782ab4aeb26) | **Pantalla de Autenticación** |
| ![image](https://github.com/user-attachments/assets/edacee62-d10a-4297-9f8e-1cef54d9e142) | **Lista de Escaneos Vacía** |
| ![image](https://github.com/user-attachments/assets/11ba69d9-8543-4291-b0dd-4799bb418f12) | **Lista con un Código QR Escaneado** |
| ![image](https://github.com/user-attachments/assets/84410feb-b9de-4e50-a173-47fe8785111c) | **Escaneo de Código QR en Tiempo Real** |


## Selección Dinámica del Repositorio
La aplicación determina el método de persistencia en función de la configuración `Use Core Data` en `Info.plist`:

```swift
private func createUseCase() -> ScannedDataUseCase? {
    guard let useCoreData = Bundle.main.infoDictionary?["Use Core Data"] as? String,
          useCoreData.elementsEqual("YES") else {
        return createRepository().map { ScannedSwiftDataUseCaseImpl(repository: $0) }
    }
    return createRepository().map { ScannedCoreDataRepositoryImpl(repository: $0) }
}
```

## Instrucciones de Configuración y Ejecución
### Requisitos previos
- Xcode 15 o superior
- iOS 17 o superior
- Swift 5.9 o superior

### Pasos para configurar y ejecutar la aplicación
1. **Clonar el repositorio**:
   ```sh
   git clone https://github.com/nelsonPena/Technical_Test_Mobile_Developer_Seek
   cd Technical_Test_Mobile_Developer_Seek
   ```
   
2. **Instalación de Dependencias con CocoaPods**

   - instala las dependencias ejecutando:
       ```sh
    cd ios
    pod install --repo-update
    ```

3. **Instalación de Flutter y Configuración de Frameworks**:

   - Para integrar Flutter en la aplicación iOS con SwiftUI, utilizando FlutterEngine y FlutterViewController, sigue estos pasos:
   
    **3.1. Instalación de Flutter**
    **3.2 Descarga e Instalación de Flutter**
    Si aún no tienes Flutter instalado, descárgalo desde la página oficial:

    - [Descargar Flutter](https://flutter.dev/docs/get-started/install)

    **3.3 Generar los Frameworks de Flutter para iOS**
    Para que iOS reconozca Flutter, compila los frameworks ejecutando:

    ```sh
    cd flutter_module
    flutter build ios-framework --output=../ios/Flutter/
    ```

    Esto generará los archivos de framework en `ios/Flutter/`.

    **3.4 Agregar el Módulo Flutter a Xcode**

    1. Abre Xcode y tu proyecto iOS.
    3. Agrega los generados en la carpeta Frameworks dentro del proyecto `Technical_Test_Mobile_Developer_Seek/Frameworks`.
   
4. **Abrir el proyecto en Xcode**:
   ```sh
   open Technical_Test_Mobile_Developer_Seek.xcodeproj
   ```
5. **Configurar Info.plist**:
   - Editar `Info.plist` y establecer la clave `Use Core Data` en `YES` o `NO` según el método de persistencia deseado.

5. **Seleccionar un simulador o dispositivo real** en Xcode.
6. **Compilar y ejecutar la aplicación**:
   - Presionar `Cmd + R` o hacer clic en el botón de ejecución en Xcode.

## Comentarios

### Integración de Flutter en la Aplicación Nativa

En la prueba técnica se planteó la creación de un módulo base en Flutter con una estructura compatible para futuras expansiones, integrándolo en la aplicación nativa mediante `FlutterEngine` y `FlutterViewController`, además de establecer un canal de comunicación entre Swift y Flutter utilizando `MethodChannels`.  

Sin embargo, debido al tiempo limitado para la entrega, no fue posible avanzar en este punto, aunque poseo conocimientos sobre su implementación.  

Es importante destacar que, si se requiere agregar un módulo o SDK que incorpore nuevas funcionalidades a la solución, la **Arquitectura Limpia** permite establecer un **bajo nivel de acoplamiento** entre dicho módulo y la aplicación. En este caso, se podría crear un **caso de uso** y su respectivo **protocolo** para interactuar con el módulo de manera desacoplada.  

Espero que esta prueba técnica refleje mi conocimiento en **Clean Code** 🙂. La integración de cualquier **plugin** o **SDK de terceros** puede realizarse siguiendo su documentación, pero diseñar un módulo con bajo acoplamiento y una buena arquitectura garantiza que, en el futuro, podamos migrar a otro proveedor sin generar fricción en el proceso de cambio.  

Un claro ejemplo de este principio se evidencia en esta prueba técnica, donde coexisten **dos frameworks de persistencia: Core Data y SwiftData**. Gracias a la arquitectura implementada, la presentación puede recibir datos de cualquiera de estos frameworks sin necesidad de modificaciones, simplemente cambiando un **parámetro de configuración**.
