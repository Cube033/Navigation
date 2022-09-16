//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий on 20.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Заголовок статьи"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
        self.navigationItem.title = titlePost
        
        let barButtonItem = UIBarButtonItem(title: "Alert", style: .plain, target: self, action: #selector(barButtonTapped))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func barButtonTapped() {
        let infoViewController = InfoViewController()
        infoViewController.modalPresentationStyle = .automatic
        present(infoViewController, animated: true, completion: nil)
    }
    
}
