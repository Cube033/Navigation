//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 24.09.2022.
//

import Foundation
import UIKit

enum ProfileActionType: CoordinatorActionProtocol {
    case profile
    case gallery
}

class ProfileCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func getStartViewController() -> UIViewController {
        let user = UserInfo.shared.user!
        let profileViewModel = ProfileViewModel(coordinator: self, user: user)
        let viewController = ProfileViewController(viewModel: profileViewModel)
        return viewController
    }
    
    func handleAction(actionType: CoordinatorActionProtocol) {
        let profileActionType = actionType as! ProfileActionType
        switch profileActionType {
        case .profile:
            // искуственная конструкция, оправдывающая применение координатора в таком маленьком модуле
            let user = UserInfo.shared.user!
            let profileViewModel = ProfileViewModel(coordinator: self, user: user)
            let viewController = ProfileViewController(viewModel: profileViewModel)
            navigationController.pushViewController(viewController, animated: true)
        case .gallery:
            let postViewController = PhotosViewController()
            navigationController.pushViewController(postViewController, animated: true)
        }
    }
}
