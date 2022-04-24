# marvel-swift

Para la realización de este proyecto se ha utilizado una arquitectura MVVM. 

Las comunicaciones con el servidor se llevan a cabo con Alamofire y FutureKit(https://github.com/FutureKit/FutureKit). 

La lógica de negocio se comunica con las vistas mediante una aproximación más sencilla de RXSwift llamada ReactiveKit(https://github.com/DeclarativeHub/ReactiveKithttps://github.com/DeclarativeHub/ReactiveKit)

## Frameworks

- Alamofire (Http requests) https://github.com/Alamofire/Alamofire
- FutureKit (Futures and Promises) https://github.com/FutureKit/FutureKit
- PaginatedTableView (Pagination in table view) https://github.com/salmaanahmed/PaginatedTableView
- Bond (View binding) https://github.com/DeclarativeHub/Bond
- SVProgressHud (Loading, progress and error views) https://github.com/SVProgressHUD/SVProgressHUD
- Nuke (Image handling) https://github.com/kean/Nuke
- Atributika (Text attributes) https://github.com/psharanda/Atributika
- Snapkit (Constraints manager) https://github.com/SnapKit/SnapKit
- Swiftlint (Code quality) https://github.com/realm/SwiftLint

## Analysis

Se ha realizado un análisis con Instruments para la detección de fugas de memoria

<img width="1267" alt="Captura de pantalla 2022-04-24 a las 8 34 47" src="https://user-images.githubusercontent.com/86626415/165001073-23cc52a4-289c-45d9-8f16-f2bdca9394bb.png">

Se ha cubierto la lógica de negocio con Test Unitarios. El análisis de Sonar muestra 27 Code Smells localizados en dos carpetas auxiliares (ImageViewer y FutureKit) las cuales extienden algunas funcionalidades para la gestión de la imagen del detalle y los Futures.

<img width="1307" alt="Captura de pantalla 2022-04-25 a las 1 03 28" src="https://user-images.githubusercontent.com/86626415/165001122-6e76697d-b86b-4995-b233-74840c86de0a.png">

## Próximos pasos

En caso de disponer mas tiempo se hubieran realizado las siguientes mejoras:

- Implementación de inyección de dependencias
- Mejoras estéticas
- UI Tests
