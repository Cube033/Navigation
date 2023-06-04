//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий on 18.08.2022.
//

import Foundation
import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let photosContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photo1ImageView: UIImageView = {
        getPhotoImageView(photo: "gallery0")
    }()
    
    private lazy var photo2ImageView: UIImageView = {
        getPhotoImageView(photo: "gallery1")
    }()
    
    private lazy var photo3ImageView: UIImageView = {
        getPhotoImageView(photo: "gallery2")
    }()
    
    private lazy var photo4ImageView: UIImageView = {
        getPhotoImageView(photo: "gallery3")
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "photos".localized
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let goToGalleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder){
        fatalError("error")
    }
    
    private func getPhotoImageView(photo photoName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: photoName)
        imageView.clipsToBounds = true
        return imageView
    }
    
    func layout(screenWidth: CGFloat) {
        [
            photo1ImageView,
            photo2ImageView,
            photo3ImageView,
            photo4ImageView,
            titleLabel,
            goToGalleryImageView
        ].forEach {contentView.addSubview($0)}
        
        let extInset: CGFloat = 12
        let intInset: CGFloat = 8
        let offset = 3 * intInset + 2 * extInset
        let sideSize: CGFloat = (screenWidth - offset) / 4
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: extInset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: extInset),
            
            goToGalleryImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            goToGalleryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -extInset),
            goToGalleryImageView.heightAnchor.constraint(equalToConstant: 25),
            goToGalleryImageView.widthAnchor.constraint(equalToConstant: 25),
            
            photo1ImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: extInset),
            photo1ImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            photo1ImageView.widthAnchor.constraint(equalToConstant: sideSize),
            photo1ImageView.heightAnchor.constraint(equalToConstant: sideSize),
            
            photo2ImageView.topAnchor.constraint(equalTo: photo1ImageView.topAnchor),
            photo2ImageView.leadingAnchor.constraint(equalTo: photo1ImageView.trailingAnchor, constant: intInset),
            photo2ImageView.widthAnchor.constraint(equalToConstant: sideSize),
            photo2ImageView.heightAnchor.constraint(equalToConstant: sideSize),
            
            photo3ImageView.topAnchor.constraint(equalTo: photo1ImageView.topAnchor),
            photo3ImageView.leadingAnchor.constraint(equalTo: photo2ImageView.trailingAnchor, constant: intInset),
            photo3ImageView.widthAnchor.constraint(equalToConstant: sideSize),
            photo3ImageView.heightAnchor.constraint(equalToConstant: sideSize),
            
            photo4ImageView.topAnchor.constraint(equalTo: photo1ImageView.topAnchor),
            photo4ImageView.leadingAnchor.constraint(equalTo: photo3ImageView.trailingAnchor, constant: intInset),
            photo4ImageView.widthAnchor.constraint(equalToConstant: sideSize),
            photo4ImageView.heightAnchor.constraint(equalToConstant: sideSize),
            photo4ImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -extInset),
            
             ])
    }
}
