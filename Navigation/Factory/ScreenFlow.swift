//
//  ViewControllerFactory.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 24.09.2022.
//

import Foundation
import UIKit

class ScreenFlow {
    
    enum Flow {
        case feed
        case profile
        case savedPosts
    }
    
    var flow: Flow
    let navigationController = UINavigationController()
    private(set) var coordinator: CoordinatorProtocol?
    
    init(flow: Flow){
        self.flow = flow
        getViewController()
    }
    
    func getViewController() {
        switch flow {
        case .feed:
            self.coordinator = FeedCoordinator(navigationController: self.navigationController)
            let viewController = self.coordinator!.getStartViewController()
            navigationController.setViewControllers([viewController], animated: true)
            let tabBarItemFeed = UITabBarItem()
            navigationController.tabBarItem = tabBarItemFeed
            tabBarItemFeed.title = "Лента"
            tabBarItemFeed.image = UIImage(systemName: "doc.richtext")
        case .profile:
            self.coordinator = ProfileCoordinator(navigationController: self.navigationController)
            let viewController = self.coordinator!.getStartViewController()
            navigationController.setViewControllers([viewController], animated: true)
            let tabBarItemProfile = UITabBarItem()
            navigationController.tabBarItem = tabBarItemProfile
            tabBarItemProfile.title = "Профиль"
            tabBarItemProfile.image = UIImage(systemName: "person.circle")
        case .savedPosts:
            let viewController = SavedPostsTableViewController()
            navigationController.setViewControllers([viewController], animated: true)
            let tabBarItemProfile = UITabBarItem()
            navigationController.tabBarItem = tabBarItemProfile
            tabBarItemProfile.title = "Сохранено"
            tabBarItemProfile.image = UIImage(systemName: "tray.full")
        }
    }
    
}

