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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
