//
//  AppDelegate.swift
//  Navigation
//
//  Created by Дмитрий on 13.03.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let mainCoordinator = MainCoordinator(window: window!)
        mainCoordinator.startApplication()
        
        return true
    }
}

