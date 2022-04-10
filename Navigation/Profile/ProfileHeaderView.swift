//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий on 27.03.2022.
//

import Foundation
import UIKit

class ProfileHeaderView: UIView {
    
    var superFrameWidht: CGFloat = 0
    
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
        
        avatarImageView.frame = .init(x: 16, y: 16, width: 100, height: 100)
        avatarImageView.layer.cornerRadius = 50
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderColor = UIColor.white.cgColor // цвет рамки
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.masksToBounds = true
        self.addSubview(avatarImageView)
        
        let nameLabel = UILabel()
        nameLabel.text = "Hipster Cat"
        nameLabel.frame = .init(x: avatarImageView.frame.maxX + 16,
                                y: 27,
                                width: 200,
                                height: 33)
        let nameLabelFont = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        nameLabel.textColor = .black
        nameLabel.font = nameLabelFont
        self.addSubview(nameLabel)
        
        print(superFrameWidht)
        
         let statusButton = UIButton(frame: .init(x: 16,
                                                 y: avatarImageView.frame.maxY + 16,
                                                  width: 390 - 32,
                                                 height: 50))
        statusButton.backgroundColor = .blue
        statusButton.layer.cornerRadius = 4.0
        statusButton.setTitle("Show status", for: .normal)
        statusButton.setTitleColor(.white, for: .normal)
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOffset = .init(width: 4, height: 4)
        statusButton.layer.shadowOpacity = 0.7
        statusButton.layer.shadowRadius = 4
        statusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //statusButton.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(statusButton)
        
        let statusLabel = UILabel(frame: CGRect(x: nameLabel.frame.minX,
                                                y: statusButton.frame.minY - 34 - 30,
                                                width: 200,
                                                height: 30))
        statusLabel.text = "Waiting for something..."
        statusLabel.textColor = .gray
        statusLabel.font = .systemFont(ofSize: 14.0)
        self.addSubview(statusLabel)
        
    }
    
    
    @objc private func buttonAction() {
        let labels = self.subviews.compactMap { $0 as? UILabel }
        for label in labels {
            if label.textColor == .gray {
                print(label.text ?? "")
            }
        }
    }
    
    
}


