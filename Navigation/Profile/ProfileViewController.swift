//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий on 27.03.2022.
//

import Foundation
import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    let postArray = Post.getPostArray()
    private let user: User
    let profileCoordinator: ProfileCoordinator
    
    init (user: User, profileCoordinator: ProfileCoordinator) {
        self.user = user
        self.profileCoordinator = profileCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private let tableHeader = ProfileHeaderView()
    private let groupAnimation = CAAnimationGroup()
    private let alphaCoverViewAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
    private var startAvatarPosition = CGPoint()
    private let alphaCloseButtonAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
    private lazy var imageRatio = view.bounds.width / tableHeader.avatarImageView.bounds.width
    private var animationCounter: (isForwardAnimation: Bool, counter: Int) = (true, 0)
    private lazy var avatarCornerRadius = tableHeader.avatarImageView.bounds.height / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    private func setView() {
        #if DEBUG
            view.backgroundColor = .yellow
        #else
            view.backgroundColor = .white
        #endif
        tableHeader.setUserInfo(user: user)
        navigationController?.isNavigationBarHidden = true
        view.clipsToBounds = true
        view.addSubview(profileTableView)
        setConstraints()
        setupGesture()
        alphaCloseButtonAnimation.delegate = self
        alphaCoverViewAnimation.delegate = self
        groupAnimation.delegate = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileTableView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatarImageHandler))
        tableHeader.avatarImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapAvatarImageHandler() {
        profileTableView.isUserInteractionEnabled = false
        startAvatarPosition = tableHeader.avatarImageView.center
        animationCounter.isForwardAnimation = true
        
        //image view Animation
        
        let positionAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.position))
        positionAnimation.fromValue = tableHeader.avatarImageView.center
        positionAnimation.toValue = view.center
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        cornerRadiusAnimation.fromValue = avatarCornerRadius
        cornerRadiusAnimation.toValue = 0
        
        let resizingAnimation = CABasicAnimation(keyPath: "transform.scale")
        resizingAnimation.fillMode = .forwards
        resizingAnimation.fromValue = 1
        resizingAnimation.toValue = imageRatio
        
        groupAnimation.duration = 0.5
        groupAnimation.beginTime = 0
        groupAnimation.speed = 1
        groupAnimation.animations = [cornerRadiusAnimation, positionAnimation, resizingAnimation]
        tableHeader.avatarImageView.layer.add(groupAnimation, forKey: nil)
        
        // cover view animation
        alphaCoverViewAnimation.fromValue = 0
        alphaCoverViewAnimation.toValue = 0.7
        alphaCoverViewAnimation.duration = 0.5
        alphaCoverViewAnimation.speed = 1
        alphaCoverViewAnimation.beginTime = 0
        tableHeader.coverView.layer.add(alphaCoverViewAnimation, forKey: nil)
        
        // close button animation
        addCloseButton()
        alphaCloseButtonAnimation.fromValue = 0
        alphaCloseButtonAnimation.toValue = 1
        alphaCloseButtonAnimation.duration = 0.3
        alphaCloseButtonAnimation.beginTime = CACurrentMediaTime() + 0.5
        alphaCloseButtonAnimation.speed = 1
        tableHeader.closeCoverButton.layer.add(alphaCloseButtonAnimation, forKey: nil)
    }
    
    private func addCloseButton() {
        tableHeader.closeCoverButton.addTarget(self, action: #selector(closeCoverButtonHandler), for: .touchUpInside)
        view.addSubview(tableHeader.closeCoverButton)
        
        NSLayoutConstraint.activate([
            tableHeader.closeCoverButton.topAnchor.constraint(equalTo: tableHeader.topAnchor, constant: 5),
            tableHeader.closeCoverButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            tableHeader.closeCoverButton.widthAnchor.constraint(equalToConstant: 30),
            tableHeader.closeCoverButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func closeCoverButtonHandler() {
        animationCounter.isForwardAnimation = false
        
        alphaCloseButtonAnimation.speed = -1
        alphaCloseButtonAnimation.beginTime = 0
        tableHeader.closeCoverButton.layer.add(alphaCloseButtonAnimation, forKey: nil)
        
        self.groupAnimation.speed = -1
        self.groupAnimation.beginTime = CACurrentMediaTime() +  0.3
        self.tableHeader.avatarImageView.layer.add(self.groupAnimation, forKey: nil)
        
        alphaCoverViewAnimation.speed = -1
        alphaCoverViewAnimation.beginTime = CACurrentMediaTime() +  0.3
        tableHeader.coverView.layer.add(alphaCoverViewAnimation, forKey: nil)
        
        profileTableView.isUserInteractionEnabled = true
    }
}

extension ProfileViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        //fixing the position of elements after animation
        
        if animationCounter.counter == 3 {
            animationCounter.counter = 1
        } else {
            animationCounter.counter = animationCounter.counter + 1
        }
        
        switch animationCounter {
        case (true, 1):
            tableHeader.avatarImageView.layer.position = view.center
            tableHeader.avatarImageView.layer.cornerRadius = 0
            tableHeader.avatarImageView.transform = CGAffineTransform(scaleX: imageRatio, y: imageRatio)
        case (true, 2):
            tableHeader.coverView.alpha = 0.7
        case (true, 3):
            tableHeader.closeCoverButton.alpha = 1
        case (false, 1):
            tableHeader.closeCoverButton.alpha = 0
        case (false, 2):
            tableHeader.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            tableHeader.avatarImageView.layer.position = startAvatarPosition
            tableHeader.avatarImageView.layer.cornerRadius = avatarCornerRadius
        case (false, 3):
            tableHeader.coverView.alpha = 0
        default:
            break
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return tableHeader
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
            profileCoordinator.handleAction(actionType: ProfileActionType.gallery)
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


