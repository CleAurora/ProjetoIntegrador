//
//  uploadCollectionDelegateSource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-02.
//

import Foundation
import UIKit

class uploadCollectionDelegateSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
    var uploadImage = uploadImagePicker()
    var View = UploadViewController()

    init(uploadView: uploadImagePicker, view: UploadViewController) {
        self.uploadImage = uploadView
        self.View = view
    }
    required init?(coder aDecoder: NSCoder)
    {
             fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UploadCollectionCell
        if let imageContent = cell.uploadImageView.image {
            View.resizeImageView.image = imageContent
            View.nextButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uploadImage.numberOfRows()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uploadCell", for: indexPath) as! UploadCollectionCell
        cell.setupImage(image: uploadImage.photosArray[indexPath.row])
        return cell
    }

}
