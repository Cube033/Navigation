//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий on 27.03.2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        profileHeaderView.superFrameWidht = self.view.safeAreaLayoutGuide.layoutFrame.width
        self.view.addSubview(profileHeaderView)
        self.title = "Profile"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = self.view.safeAreaLayoutGuide.layoutFrame
    }
}
