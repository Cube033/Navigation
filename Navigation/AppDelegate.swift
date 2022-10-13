//
//  AppDelegate.swift
//  Navigation
//
//  Created by Дмитрий on 13.03.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()
    
    let appConfiguration: AppConfiguration
    
    override init (){
        let appConfigurationOpt = AppConfiguration.allCases.randomElement()
        self.appConfiguration = appConfigurationOpt ?? AppConfiguration.link1
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        let mainCoordinator = MainCoordinator(window: window!)
        mainCoordinator.startApplication()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        try? Auth.auth().signOut()
    }
}

