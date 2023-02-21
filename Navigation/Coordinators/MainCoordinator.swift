//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 24.09.2022.
//

import Foundation
import UIKit

protocol MainCoordinatorProtokol {
    
    var window: UIWindow? {get set}
    
    func startApplication()
}

class MainCoordinator: MainCoordinatorProtokol {
    
    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func startApplication(){
        let localNotificationService = LocalNotificationsService()
        localNotificationService.registeForLatestUpdatesIfPossible()
        
        var currentViewController: UIViewController
        if UserInfo.shared.loggedIn {
            let viewController = MainTabBarViewController()
            currentViewController = viewController
            
        }  else {
            let viewController = LogInViewController(mainCoordinator: self)
            viewController.loginDelegate = MyLoginFactory.makeLoginInspector()
            currentViewController = viewController //костыль - так как не удается указать свойство loginDelegate напрямую
        }
        self.window?.rootViewController = currentViewController
        self.window?.makeKeyAndVisible()
    }
}
