//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий on 27.03.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    var avatarImageView = UIImageView()
    var nameLabel = UILabel()
    var statusButton = UIButton()
    var statusTextField = UITextField()
    var statusLabel = UILabel()
    
    let coverView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeCoverButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        return button
    }()
    
    var coverViewWidthConstraint = NSLayoutConstraint()
    var coverViewHeightConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        setElements()
        addElements()
        setConstraits()
    }
    
    private func setElements(){
        avatarImageView = setAvatarImageView()
        nameLabel = setNameLabel()
        statusButton = setStatusButton()
        statusTextField = setStatusTextField()
        statusLabel = setStatusLabel()
    }
    
    private func addElements(){
        
        self.addSubview(nameLabel)
        self.addSubview(statusButton)
        self.addSubview(statusTextField)
        self.addSubview(statusLabel)
        self.addSubview(coverView)
        self.addSubview(avatarImageView)
    }
    
    private func setConstraits(){
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 33),
            
            statusButton.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusTextField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -16),
            statusTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -16),
            statusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            coverView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coverView.topAnchor.constraint(equalTo: self.topAnchor),
            coverView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            coverView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
        ])
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? "nil"
    }
    
    private func setAvatarImageView() -> UIImageView{
        let avatarImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 50
            imageView.clipsToBounds = true
            imageView.layer.borderColor = UIColor.white.cgColor // цвет рамки
            imageView.layer.borderWidth = 3
            imageView.layer.masksToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        return avatarImageView
    }
    
    private func setNameLabel() -> UILabel{
        let nameLabel: UILabel = {
            let label = UILabel()
            let nameLabelFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
            label.textColor = .black
            label.font = nameLabelFont
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        return nameLabel
    }
    
    private func setStatusButton() -> UIButton{
        return CustomButton(title: "Show status",
                                  backgroundColor: nil,
                                  tapAction: {
            let labels = self.subviews.compactMap { $0 as? UILabel }
            for label in labels {
                if label.textColor == .gray {
                    let textViews = self.subviews.compactMap {$0 as? UITextField}
                    if let firstTextView = textViews.first {
                        label.text = firstTextView.text ?? "no text"
                    }
                }
            }
        })
    }
    
    private func setStatusTextField() -> UITextField{
        let statusTextField: UITextField = {
            let textField = UITextField()
            textField.font = .systemFont(ofSize: 15)
            textField.backgroundColor = .white
            textField.layer.cornerRadius = 12
            textField.clipsToBounds = true
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.borderWidth = 1
            textField.layer.masksToBounds = true
            textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        return statusTextField
    }
    
    private func setStatusLabel() -> UILabel{
        let statusLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = .systemFont(ofSize: 14.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        return statusLabel
    }
    
    public func setUserInfo(user: User) {
        nameLabel.text = user.fullName
        avatarImageView.image = user.avatar
        statusLabel.text = user.status
    }
}


