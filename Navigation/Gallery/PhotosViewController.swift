//
//  GalleryViewController.swift
//  Navigation
//
//  Created by Дмитрий on 19.08.2022.
//

import Foundation
import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var elementNumber = 0
    
    private var photoArray: [UIImage] = {
           var array = [UIImage]()
           return array
       }()
    
    private lazy var photosColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        return collectionView
    }()
    
    let imagePublisherFacade = ImagePublisherFacade()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Photo gallery"
        view.backgroundColor = .white
        
        layout()
        
        let photoArrayForObserver: [UIImage] = {
            var array = [UIImage]()
            for element in 0...19 {
                array.append(UIImage(named: "gallery\(element)")!)
            }
            return array
        }()
        
        imagePublisherFacade.subscribe(self)
        imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: photoArrayForObserver)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        imagePublisherFacade.removeSubscription(for: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    private func layout() {
        view.addSubview(photosColletionView)
        
        NSLayoutConstraint.activate([
            photosColletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosColletionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            photosColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photosColletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = photosColletionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        photoCell.setupCell(photoImage: photoArray[indexPath.row])
        return photoCell
    }
    
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let sideSize = (screenWidth - sideInset * 4) / 3
        return CGSize(width: sideSize, height: sideSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        photoArray.append(images.last!)
        photosColletionView.reloadData()
    }
}
