//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий on 14.08.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private let postContentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private let postImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .black
            imageView.clipsToBounds = true
            return imageView
        }()
        
        private let postTitleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.numberOfLines = 2
            return label
        }()
    
    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = UIImage()
        postTitleLabel.text = ""
        postDescriptionLabel.text = ""
        likesCountLabel.text = "Likes: 0"
        viewsCountLabel.text = "Views: 0"
    }
    
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    func setupCell(model: Post) {
        postImageView.image = UIImage(named: model.image)
        postTitleLabel.text = model.title
        postDescriptionLabel.text = model.description
        likesCountLabel.text = "Likes: \(model.likes)"
        viewsCountLabel.text = "Views: \(model.views)"
    }
    
    private func layout() {
        contentView.addSubview(postContentView)
        [
            postImageView,
            postTitleLabel,
            postDescriptionLabel,
            likesCountLabel,
            viewsCountLabel
        ].forEach {postContentView.addSubview($0)}
        
        let textInset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            postContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            postTitleLabel.topAnchor.constraint(equalTo: postContentView.topAnchor, constant: textInset),
            postTitleLabel.leadingAnchor.constraint(equalTo: postContentView.leadingAnchor, constant: textInset),
            postTitleLabel.trailingAnchor.constraint(equalTo: postContentView.trailingAnchor, constant: -textInset),
            
            postImageView.topAnchor.constraint(equalTo: postTitleLabel.bottomAnchor, constant: textInset),
            postImageView.widthAnchor.constraint(equalTo: postContentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: postContentView.widthAnchor),
            
            postDescriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: textInset),
            postDescriptionLabel.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: postTitleLabel.trailingAnchor),
            
            likesCountLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: textInset),
            likesCountLabel.leadingAnchor.constraint(equalTo: postTitleLabel.leadingAnchor),
            
            viewsCountLabel.topAnchor.constraint(equalTo: postDescriptionLabel.bottomAnchor, constant: textInset),
            viewsCountLabel.trailingAnchor.constraint(equalTo: postTitleLabel.trailingAnchor),
            viewsCountLabel.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: -textInset)
             ])
    }

}
