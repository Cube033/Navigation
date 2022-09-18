//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий on 27.03.2022.
//

import Foundation
import UIKit
import SnapKit

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
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(16)
            make.leading.equalTo(self).offset(15)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalTo(self)
            make.trailing.equalTo(self).offset(-16)
            make.height.equalTo(33)
        }
        
        statusButton.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView)
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.trailing.equalTo(nameLabel)
            make.height.equalTo(50)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.bottom.equalTo(statusButton.snp.top).offset(-16)
            make.trailing.equalTo(nameLabel)
            make.height.equalTo(40)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.bottom.equalTo(statusTextField.snp.top).offset(-16)
            make.trailing.equalTo(nameLabel)
        }
        
        coverView.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? "nil"
    }
    
    private func setAvatarImageView() -> UIImageView{
        let avatarImage = UIImage(named: "myAvatarImage")
        let avatarImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
            imageView.image = avatarImage
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
            label.text = "Dmitry Fedotov"
            let nameLabelFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
            label.textColor = .black
            label.font = nameLabelFont
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        return nameLabel
    }
    
    private func setStatusButton() -> UIButton{
        let statusButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .blue
            button.layer.cornerRadius = 4.0
            button.setTitle("Show status", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = .init(width: 4, height: 4)
            button.layer.shadowOpacity = 0.7
            button.layer.shadowRadius = 4
            button.addAction(
                UIAction { _ in
                    let labels = self.subviews.compactMap { $0 as? UILabel }
                    for label in labels {
                        if label.textColor == .gray {
                            let textViews = self.subviews.compactMap {$0 as? UITextField}
                            if let firstTextView = textViews.first {
                                label.text = firstTextView.text ?? "no text"
                            }
                        }
                    }
                }, for: .touchDown
            )
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        return statusButton
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
            label.text = "Waiting for something..."
            label.textColor = .gray
            label.font = .systemFont(ofSize: 14.0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        return statusLabel
    }
}


