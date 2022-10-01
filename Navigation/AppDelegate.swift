//
//  AppDelegate.swift
//  Navigation
//
//  Created by Дмитрий on 13.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()
    
    let appConfiguration: AppConfiguration
    
    override init (){
        let appConfigurationOpt = AppConfiguration.allCases.randomElement()
        self.appConfiguration = appConfigurationOpt ?? AppConfiguration.link1
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let mainCoordinator = MainCoordinator(window: window!)
        mainCoordinator.startApplication()
        
        return true
    }
}

