//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий on 20.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Заголовок статьи"
    
    let feedCoordinator: FeedCoordinator
    
    init(feedCoordinator: FeedCoordinator) {
        self.feedCoordinator = feedCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        self.navigationItem.title = titlePost
        
        let barButtonItem = UIBarButtonItem(title: "Player", style: .plain, target: self, action: #selector(barButtonTapped))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func barButtonTapped() {
        feedCoordinator.handleAction(actionType: FeedActionType.alert)
    }
    
}
