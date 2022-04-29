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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    
    private func setupView() {
        let avatarImage = UIImage(named: "myAvatarImage")
        let avatarImageView = UIImageView(image: avatarImage)
        setAvatarImageView(view: avatarImageView)
        
        let nameLabel = UILabel()
        setNameLabel(view: nameLabel, Anch: avatarImageView.trailingAnchor)
        
        let statusButton = UIButton()
        setstatusButton(view: statusButton, leadingAnchor: avatarImageView.leadingAnchor, topAnchor: avatarImageView.bottomAnchor, trailingAnchor: nameLabel.trailingAnchor)
        
        let statusTextField = UITextField()
        setStatusTextField(statusTextField: statusTextField, leadingAnchor: nameLabel.leadingAnchor, bottomAnchor: statusButton.topAnchor, trailingAnchor: nameLabel.trailingAnchor)
        
        let statusLabel = UILabel()
        setStatusLabel(statusLabel: statusLabel, leadingAnchor: nameLabel.leadingAnchor, bottomAnchor: statusTextField.topAnchor, trailingAnchor: nameLabel.trailingAnchor)
    }
    
    @objc private func buttonAction() {
        let labels = self.subviews.compactMap { $0 as? UILabel }
        for label in labels {
            if label.textColor == .gray {
                let textViews = self.subviews.compactMap {$0 as? UITextField}
                if let firstTextView = textViews.first {
                    label.text = firstTextView.text ?? "no text"
                }
            }
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? "nil"
        
    }
    
    private func setAvatarImageView(view: UIImageView){
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.white.cgColor // цвет рамки
        view.layer.borderWidth = 3
        view.layer.masksToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        [
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalToConstant: 100)
        ]
        .forEach({$0.isActive = true})
    }
    
    private func setNameLabel(view: UILabel, Anch: NSLayoutAnchor<NSLayoutXAxisAnchor>){
        view.text = "Hipster Cat"
        let nameLabelFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        view.textColor = .black
        view.font = nameLabelFont
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        [
            view.leadingAnchor.constraint(equalTo: Anch, constant: 16),
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            //nameLabel.widthAnchor.constraint(equalToConstant: 200),
            view.heightAnchor.constraint(equalToConstant: 33)
        ]
        .forEach({$0.isActive = true})
    }
    
    private func setstatusButton(view: UIButton,
                                 leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                 topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                                 trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>){
        view.backgroundColor = .blue
        view.layer.cornerRadius = 4.0
        view.setTitle("Show status", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 4, height: 4)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4
        view.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        [
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 50)
        ]
        .forEach({$0.isActive = true})
    }
    
    private func setStatusTextField(statusTextField: UITextField,
                                    leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                    bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                                    trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>){
        statusTextField.font = .systemFont(ofSize: 15)
        statusTextField.backgroundColor = .white
        statusTextField.layer.cornerRadius = 12
        statusTextField.clipsToBounds = true
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.masksToBounds = true
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        self.addSubview(statusTextField)
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        [
            statusTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ]
        .forEach({$0.isActive = true})
    }
    
    private func setStatusLabel(statusLabel: UILabel,
                                leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                                trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>){
        statusLabel.text = "Waiting for something..."
        statusLabel.textColor = .gray
        statusLabel.font = .systemFont(ofSize: 14.0)
        self.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            statusLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        .forEach({$0.isActive = true})
    }
}


