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
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
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
        if section == 0 {
            return ProfileHeaderView()
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 190
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
            photoCell.layout(screenWidth: view.bounds.width)
            return photoCell
        } else {
            let postCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            postCell.setupCell(model: postArray[indexPath.row])
            return postCell
        }
    }
}
