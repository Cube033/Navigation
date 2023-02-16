//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Дмитрий on 19.08.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Palette.viewControllerBackgroundColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.backgroundColor = .yellow
        layout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = UIImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(photoImage: UIImage) {
        photoImageView.image = photoImage
    }
    
    private func layout() {
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
                photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ])
    }
}
