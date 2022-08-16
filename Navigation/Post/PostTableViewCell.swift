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
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.backgroundColor = UIColor.blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray3
        return label
    }()
    
    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray3
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customizeCell()
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = UIImage()
        postTitleLabel.text = ""
        postDescriptionLabel.text = ""
    }
    
    func setupCell(model: Post) {
        postImageView.image = UIImage(named: model.image)
        postTitleLabel.text = model.title
    }
    
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    private func customizeCell() {
        contentView.backgroundColor = .systemGray2
        postContentView.layer.cornerRadius = 10
        postContentView.layer.borderWidth = 1
        postContentView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func layout() {
        [
            postContentView,
            postImageView,
            postTitleLabel,
            postDescriptionLabel
        ].forEach { contentView.addSubview($0)}
        
        let heightView: CGFloat = 100
        let viewInset: CGFloat = 8
        let imageInset: CGFloat = 10
        
        NSLayoutConstraint.activate([
            postContentView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: viewInset),
            postContentView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: viewInset),
            postContentView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -viewInset),
            postContentView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -viewInset),
            postContentView.heightAnchor.constraint(equalToConstant: heightView),
            
            postImageView.topAnchor.constraint(equalTo: postContentView.topAnchor, constant: imageInset),
            postImageView.leadingAnchor.constraint(equalTo: postContentView.leadingAnchor, constant: imageInset),
            //postImageView.heightAnchor.constraint(equalToConstant: heightView - imageInset * 2),
            postImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: -imageInset),
            postImageView.widthAnchor.constraint(equalToConstant: heightView - imageInset * 2),
            
            postTitleLabel.topAnchor.constraint(equalTo: postImageView.topAnchor),
            postTitleLabel.trailingAnchor.constraint(equalTo: postContentView.trailingAnchor, constant: -16),
            postTitleLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 16)
            ])
    }

}
