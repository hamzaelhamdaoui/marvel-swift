# marvel-swift

An MVVM architecture has been used for the realization of this project. 

Communications with the server are carried out with Alamofire and FutureKit(https://github.com/FutureKit/FutureKit). 

The business logic communicates with the views using a simpler RXSwift approach called ReactiveKit(https://github.com/DeclarativeHub/ReactiveKithttps://github.com/DeclarativeHub/ReactiveKit).

## Requirements 
- Xcode 12.0+
- iOS 14.0+
- Swift 5.0

## Common SetUp
- Clone the repo.
- Install dependencies with Cocoapods (inside project directory) using: pod install
- Open the workspace Marvel.xcworkspace
- Have fun!

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
- KeychainSwift (Keychain helper) https://github.com/evgenyneu/keychain-swift

## Analysis

An analysis has been performed with Instruments for the detection of memory leaks.

<img width="1267" alt="Captura de pantalla 2022-04-24 a las 8 34 47" src="https://user-images.githubusercontent.com/86626415/165001073-23cc52a4-289c-45d9-8f16-f2bdca9394bb.png">

The business logic has been covered with Unitary Tests. Sonar analysis shows 27 Code Smells located in two auxiliary folders (ImageViewer and FutureKit) which extend some functionalities for the management of the detail image and Futures.

<img width="1307" alt="Captura de pantalla 2022-04-25 a las 1 03 28" src="https://user-images.githubusercontent.com/86626415/165001122-6e76697d-b86b-4995-b233-74840c86de0a.png">

## Next steps

If more time was available, the following improvements would have been made:

- Dependency injection implementation
- Aesthetic improvements
- UI Tests
