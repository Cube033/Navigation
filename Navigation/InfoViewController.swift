//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дмитрий on 21.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupButton()
    }
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        button.setTitle("Доступные действия", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupButton() {
        self.view.addSubview(self.button)
        self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100).isActive = true
        self.button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func buttonAction() {
        setAlert()
    }
    
    private func setAlert() {
        let alert = UIAlertController(title: "Действия", message: "Выберите действие", preferredStyle: .alert)
        let actionPrint = UIAlertAction(title: "Вывести текст в консоль", style: .default) { (_) -> Void in
            print("Вывести текст")
        }
        let actionDismiss = UIAlertAction(title: "Закрыть окно", style: .default) { (_) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(actionPrint)
        alert.addAction(actionDismiss)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
