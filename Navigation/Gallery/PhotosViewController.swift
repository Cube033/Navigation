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
    
    private var photoArray = [UIImage]()
    
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
        
        self.navigationItem.title = "photogallery".localize
        view.backgroundColor = .white
        
        layout()
        addImages()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }
    
    private func addImages() {
        
        processAndAddImages(filter: .colorInvert, qos: .userInteractive, numberOfPhotos: 15) //time interval 4.461292208055966
        processAndAddImages(filter: .chrome, qos: .userInitiated, numberOfPhotos: 13) //time interval 4.501476333010942
        processAndAddImages(filter: .gaussianBlur(radius: 10), qos: .default, numberOfPhotos: 10) //time interval 3.184501750045456
        processAndAddImages(filter: .monochrome(color: .blue, intensity: 5), qos: .utility, numberOfPhotos: 4) //time interval 1.2014757079305127
        processAndAddImages(filter: .noir, qos: .background, numberOfPhotos: 19) //time interval 6.409920625039376
    }
    
    private func processAndAddImages(filter: ColorFilter, qos: QualityOfService, numberOfPhotos: Int){
        var end = DispatchTime.now()
        
        let photoArrayForProcessor = GalleryModel.getPartOfArray(numberOfElements: numberOfPhotos)
        let imageProcessor = iOSIntPackage.ImageProcessor()
        let start = DispatchTime.now()
        imageProcessor.processImagesOnThread(sourceImages: photoArrayForProcessor,
                                             filter: filter,
                                             qos: qos,
                                             completion: {photoArrayFromProcessor in
            photoArrayFromProcessor.forEach {
                if let processedPhoto = $0 {
                    self.photoArray.append(UIImage(cgImage: processedPhoto))
                }
            }
            end = DispatchTime.now()
            let nanoTimeEnd = Double(end.uptimeNanoseconds) / 1_000_000_000
            let nanoTimeStart = Double(start.uptimeNanoseconds) / 1_000_000_000
            let timeInterval =  nanoTimeEnd - nanoTimeStart// Technically could overflow for long running tests
#if DEBUG
            print("filter type: \(filter).time interval \(timeInterval)")
#endif
            DispatchQueue.main.async {
                self.photosColletionView.reloadData()
            }
        })
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

