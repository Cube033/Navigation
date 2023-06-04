//
//  UserAvatarCollectionViewCell.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 04.06.2023.
//

import UIKit

class UserAvatarCollectionViewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = frame.size.width / 2
        contentView.backgroundColor = .gray
        
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with user: User) {
        nameLabel.text = String(user.email.prefix(1))
    }
}

