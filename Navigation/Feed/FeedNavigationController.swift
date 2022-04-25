//
//  FeedNavigationController.swift
//  Navigation
//
//  Created by Дмитрий on 20.03.2022.
//

import UIKit

class FeedNavigationController: UIViewController {

    let post = Post(title: "Моя статья")
    let feedButtonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedButtonStackView.axis  = NSLayoutConstraint.Axis.vertical
        feedButtonStackView.spacing   = 10.0
        feedButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        feedButtonStackView.alignment = .center
        view.backgroundColor = .lightText
        self.view.addSubview(feedButtonStackView)
        feedButtonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        feedButtonStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        feedButtonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        feedButtonStackView.addArrangedSubview(getNewFeedButton())
        feedButtonStackView.addArrangedSubview(getNewFeedButton())
    }
    
    private func getNewFeedButton()->UIButton{
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }
    
    @objc private func buttonAction() {
            let postViewController = PostViewController()
            postViewController.titlePost = post.title
            self.navigationController?.pushViewController(postViewController, animated: true)
        }

}
