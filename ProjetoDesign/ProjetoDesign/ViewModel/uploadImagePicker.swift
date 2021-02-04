//
//  uploadImagePicker.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-02.
//

import Foundation
import UIKit
import Photos

class uploadImagePicker: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var photosArray = [UIImage]()
    let pickerController = UIImagePickerController()

    func grabPhotos(completionHandler: (_ result: Bool, _ error: Error?) -> Void){
    do{
    pickerController.delegate = self
    let imgManager = PHImageManager.default()

    let requestOptions = PHImageRequestOptions()
    requestOptions.isSynchronous = false
    requestOptions.deliveryMode = .highQualityFormat
    requestOptions.isNetworkAccessAllowed = true
    requestOptions.isSynchronous = true

    requestOptions.progressHandler = { (progress, error, stop, info) in
        print("progress: \(progress)")
    }

    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        if let fetchResult : PHFetchResult? = PHAsset.fetchAssets(with: .image, options: fetchOptions) {

            if fetchResult!.count > 0 {
                for i in 0..<fetchResult!.count
            {
                    imgManager.requestImage(for: fetchResult!.object(at: i), targetSize: CGSize(width: 250, height: 250), contentMode: .aspectFill, options: requestOptions, resultHandler: {image, error in
                        if let photo = image {
                            self.photosArray.append(photo)
                        }
                })
            }

        }else{
            completionHandler(false,nil)
            print("you got no photos")
        }
            completionHandler(true,nil)
     }
    }catch{
        completionHandler(false,nil)
    }
}

    func numberOfRows() -> Int{
        return photosArray.count ?? 0
    }

}
