//
//  MainTabBarViewController.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 24.09.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let feedScreen = ScreenFlow(flow: .feed)
    private let profileScreen = ScreenFlow(flow: .profile)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setControllers()
    }
    
    private func setControllers() {
        viewControllers = [feedScreen.navigationController,
                           profileScreen.navigationController]
    }
}
