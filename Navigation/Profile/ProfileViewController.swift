//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий on 27.03.2022.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
     
    let postArray = Post.getPostArray()
    private lazy var profileTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.rowHeight = 130
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setView()
        }
    
    private func setView() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        view.clipsToBounds = true
        view.addSubview(profileTableView)
        setConstraints()
        }
    
    private func setConstraints() {
            NSLayoutConstraint.activate([
                profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                profileTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
                profileTableView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
        }
    
    
//    let profileHeaderView = ProfileHeaderView()
//    var changeTitleButton = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setView()
//    }
//
//    private func setView(){
//        view.backgroundColor = .lightGray
//        self.view.addSubview(profileHeaderView)
//        self.title = "Profile"
//        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
//        changeTitleButton = setChangeTitleButton()
//        setConstraints()
//
//    }
//
//    private func setChangeTitleButton() -> UIButton{
//        let changeTitleButton: UIButton = {
//            let button = UIButton()
//            button.backgroundColor = .blue
//            button.layer.cornerRadius = 4.0
//            button.setTitle("Изменить заголовок", for: .normal)
//            button.setTitleColor(.white, for: .normal)
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//
//            button.layer.shadowColor = UIColor.black.cgColor
//            button.layer.shadowOffset = .init(width: 4, height: 4)
//            button.layer.shadowOpacity = 0.7
//            button.layer.shadowRadius = 4
//            button.addAction(
//              UIAction { _ in
//                  self.title = "new title"
//              }, for: .touchDown
//            )
//            button.translatesAutoresizingMaskIntoConstraints = false
//            return button
//        }()
//        self.view.addSubview(changeTitleButton)
//        return changeTitleButton
//    }
//
//    private func setConstraints() {
//        NSLayoutConstraint.activate([
//            profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
//
//            changeTitleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            changeTitleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//            changeTitleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            changeTitleButton.heightAnchor.constraint(equalToConstant: 25)
//        ])
//    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ProfileHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Tap cell \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        postCell.setupCell(model: postArray[indexPath.row])
        return postCell
    }
}
