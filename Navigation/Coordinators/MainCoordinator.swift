//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 24.09.2022.
//

import Foundation
import UIKit

protocol MainCoordinatorProtokol: AnyObject {
    
    var window: UIWindow? {get set}
    
    func startApplication()
}

class MainCoordinator: MainCoordinatorProtokol {
    
    var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
        AccessManager.shared.mainCoordinatorDelegate = self
    }
    
    func startApplication(){
        let localNotificationService = LocalNotificationsService()
        localNotificationService.registeForLatestUpdatesIfPossible()
        
        var currentViewController: UIViewController
        if AccessManager.shared.userLoggedIn() {
            let viewController = MainTabBarViewController()
            currentViewController = viewController
            
        }  else {
            let viewController = LogInViewController(mainCoordinator: self)
            currentViewController = viewController //костыль - так как не удается указать свойство loginDelegate напрямую
        }
        self.window?.rootViewController = currentViewController
        self.window?.makeKeyAndVisible()
    }
}
