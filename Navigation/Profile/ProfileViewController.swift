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
    var changeTitleButton = UIButton()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView(){
        view.backgroundColor = .lightGray
        self.view.addSubview(profileHeaderView)
        self.title = "Profile"
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        changeTitleButton = setChangeTitleButton()
        setConstraints()
        
    }
    
    private func setChangeTitleButton() -> UIButton{
        let changeTitleButton: UIButton = {
            let button = UIButton()
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
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        self.view.addSubview(changeTitleButton)
        return changeTitleButton
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            
            changeTitleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            changeTitleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            changeTitleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            changeTitleButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    @objc private func buttonAction() {
        self.title = "new title"
    }
}
