//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import UIKit
import GoogleMaps
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let connectivity = Connectivity.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Загружаем данные с базы
        NetworkHelper.shared.downloadAllRequest()
        GMSServices.provideAPIKey(Constants.apiKey)
        connectivity.startNetworkReachabilityObserver()
        configureFirebase()
        return true
    }

    private func configureFirebase() {
        FirebaseApp.configure()
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
    
    func applicationWillTerminate(_ application: UIApplication) {
        connectivity.stopNetworkReachabilityObserver()
    }


}

