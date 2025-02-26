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
2. **Abrir el proyecto en Xcode**:
   ```sh
   open Technical_Test_Mobile_Developer_Seek.xcodeproj
   ```
3. **Configurar Info.plist**:
   - Editar `Info.plist` y establecer la clave `Use Core Data` en `YES` o `NO` según el método de persistencia deseado.

4. **Seleccionar un simulador o dispositivo real** en Xcode.
5. **Compilar y ejecutar la aplicación**:
   - Presionar `Cmd + R` o hacer clic en el botón de ejecución en Xcode.

### Comentarios 

El punto en la prueba, referente a flutter:
```
Crear un módulo base en Flutter con estructura compatible para futuras
expansiones, integrando dicho módulo en la aplicación nativa mediante
FlutterEngine y FlutterViewController y utilizando un canal de comunicación
entre Swift y Flutter utilizando MethodChannels
```

**No fue posible avanzar en este punto debido al poco tiempo establecido para la entrega.**

Pero no sobra dejar en claro que si se requiere agregar un módulo o una SDK que agregue nuevas funcionalidades a la solucion, con el uso de arquitectura limpia, se puede brindar un bajo nivel de acoplamiento, entre dicho módulo y la solución, en este caso podríamos crear un caso de uso y su respectivo protocolo para poder interactuar con dicho módulo. 

Espero que esta prueba demuestre mi conocimiento... y

Ya que la integración de cualquier plugin o de SDK de terceros se puede hacer siguiendo el paso a paso de los mismos, pero integrar un módulo con bajo nivel de acoplamiento, usando una buena arquitectura, nos garantiza que en un futuro podremos migrar a otro proveedor, sin tener fricción en el proceso de cambio
