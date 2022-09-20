//
//  AppDelegate.swift
//  Navigation
//
//  Created by Дмитрий on 13.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        let tabBarController = UITabBarController()
        let feedNavigationController = UINavigationController(rootViewController: FeedNavigationController())
        let tabBarItemFeed = UITabBarItem()
        let tabBarItemProfile = UITabBarItem()
        let logInController = LogInViewController()
        logInController.loginDelegate = LoginInspector as! LoginViewControllerDelegate
        let profileNavigationController = UINavigationController(rootViewController: logInController)
        
        feedNavigationController.tabBarItem = tabBarItemFeed
        profileNavigationController.tabBarItem = tabBarItemProfile
        
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        tabBarController.selectedViewController = feedNavigationController
        tabBarItemFeed.title = "Лента"
        tabBarItemProfile.title = "Профиль"
        tabBarItemFeed.image = UIImage(systemName: "doc.richtext")
        tabBarItemProfile.image = UIImage(systemName: "person.circle")
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}

