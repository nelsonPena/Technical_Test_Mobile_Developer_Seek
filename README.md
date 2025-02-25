# Prueba Técnica - Desarrollador Mobile

## Resumen
Este proyecto demuestra cómo cambiar entre diferentes capas de persistencia (`SwiftData` y `CoreData`) utilizando principios de Arquitectura Limpia. La implementación garantiza que la decisión de usar `SwiftData` o `CoreData` se gestione dinámicamente en función de una configuración.

## Arquitectura
El proyecto sigue los principios de **Arquitectura Limpia**, asegurando bajo acoplamiento y alta escalabilidad. Incluye:

- **Implementación de Fábrica**: `ScanningListViewFactory` centraliza la creación de todas las capas (Presentación, Dominio y Datos), mejorando la mantenibilidad y flexibilidad.
- **Bajo Acoplamiento**: Los componentes interactúan a través de abstracciones, facilitando la extensión o modificación del sistema.
- **Swift + AVFoundation**: Integración con los frameworks multimedia de Apple para funcionalidades avanzadas.
- **Autenticación Biométrica**: Soporta Face ID y Touch ID para mayor seguridad.
- **Uso de Keychain**: Almacena de manera segura credenciales.
- **Pruebas Unitarias**: Garantiza la confiabilidad de la aplicación validando las funcionalidades principales mediante pruebas automatizadas.

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
   git clone https://github.com/tuusuario/tu-repositorio.git
   cd tu-repositorio
   ```
2. **Abrir el proyecto en Xcode**:
   ```sh
   open YourProject.xcodeproj
   ```
3. **Configurar Info.plist**:
   - Editar `Info.plist` y establecer la clave `Use Core Data` en `YES` o `NO` según el método de persistencia deseado.
4. **Seleccionar un simulador o dispositivo real** en Xcode.
5. **Compilar y ejecutar la aplicación**:
   - Presionar `Cmd + R` o hacer clic en el botón de ejecución en Xcode.

## Beneficios de la Arquitectura Limpia en Esta Implementación
✅ **Escalabilidad** - Agregar una nueva capa de persistencia (ej. Firebase, Realm) requiere cambios mínimos.  
✅ **Separación de Responsabilidades** - La UI, la lógica de negocio y la persistencia de datos están desacopladas.  
✅ **Testabilidad** - Cada componente puede ser probado de forma independiente.  
✅ **Flexibilidad** - El sistema selecciona dinámicamente la mejor implementación del repositorio.  
✅ **Seguridad** - La autenticación biométrica y el uso de Keychain mejoran la protección del usuario.  
✅ **Confiabilidad** - Las pruebas unitarias aseguran estabilidad y previenen regresiones.  

