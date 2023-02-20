//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 24.09.2022.
//

import Foundation
import UIKit

enum FeedActionType: CoordinatorActionProtocol {
    case feed
    case post
    case alert
    case videoPlayer
    case mapViewController
}

class FeedCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    var currentViewController = UIViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func getStartViewController() -> UIViewController {
        let viewController = FeedNavigationController(feedCoordinator: self)
        return viewController
    }
    
    func handleAction(actionType: CoordinatorActionProtocol) {
        let feedActionType = actionType as! FeedActionType
        switch feedActionType {
        case .feed:
            // искуственная конструкция, оправдывающая применение координатора в таком маленьком модуле
            currentViewController = FeedNavigationController(feedCoordinator: self)
            navigationController.pushViewController(currentViewController, animated: true)
        case .post:
            currentViewController = PostViewController(feedCoordinator: self)
            navigationController.pushViewController(currentViewController, animated: true)
        case .alert:
            currentViewController = InfoViewController()
            currentViewController.modalPresentationStyle = .automatic
            navigationController.present(currentViewController, animated: true, completion: nil)
        case .videoPlayer:
            currentViewController = VideoPlayerViewController()
            navigationController.present(currentViewController, animated: true, completion: nil)
        case .mapViewController:
            currentViewController = MapViewController()
            navigationController.pushViewController(currentViewController, animated: true)
        }
    }
}
 
