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
}

class FeedCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
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
            let viewController = FeedNavigationController(feedCoordinator: self)
            navigationController.pushViewController(viewController, animated: true)
        case .post:
            let postViewController = PostViewController(feedCoordinator: self)
            navigationController.pushViewController(postViewController, animated: true)
        case .alert:
            let infoViewController = InfoViewController()
            infoViewController.modalPresentationStyle = .automatic
            navigationController.present(infoViewController, animated: true, completion: nil)
        case .videoPlayer:
            let videoPlayerViewController = VideoPlayerViewController()
            navigationController.present(videoPlayerViewController, animated: true, completion: nil)
        }
    }
}
