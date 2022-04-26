//
//  AppDelegate.swift
//  Marvel
//
//  Created by AvantgardeIT on 18/4/22.
//

import KeychainSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        saveAPICredentials()
        return true
    }

    func saveAPICredentials() {
        let keychain = KeychainSwift()
        keychain.set("829356a53f49da37b07aa6da90cadf1d", forKey: "APIKEY")
        keychain.set("f568f1864cfac5629ef6514d050ce4efde17c0a9", forKey: "PRIVATEAPIKEY")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
