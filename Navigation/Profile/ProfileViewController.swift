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
        self.view.addSubview(profileHeaderView)
        self.title = "Profile"
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        [
            profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ]
        .forEach({$0.isActive = true})
        
        let changeTitleButton = UIButton()
        setChangeTitleButton(button: changeTitleButton)
    }
    
    private func setChangeTitleButton(button: UIButton){
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4.0
        button.setTitle("Изменить заголовок", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .init(width: 4, height: 4)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        [
            button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 25)
        ]
        .forEach({$0.isActive = true})
    }
    
    @objc private func buttonAction() {
        self.title = "new title"
    }
}
