//
//  UploadViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class UploadViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK: - IBOutlets
    @IBOutlet weak var resizeImageView: UIImageView!
    @IBOutlet weak var uploadCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet var imageViewBorder: UIView!
    
    var imageSelected: UIImage?
    var uploadData = uploadImagePicker()
    var uploadDataSource: uploadCollectionDelegateSource?
    // MARK: - Proprierts
    var uploadArray = [Upload]()
    var uploadSelected: Upload?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewBorder.roundedBottom()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uploadData.photosArray.removeAll()
        grabPhotos()
    }
    func grabPhotos(){
        uploadData.grabPhotos(completionHandler: { success, _ in
            if success {
                collectionSetup()
            }
        })
    }
    func isImageSelected(){
        self.resizeImageView.image = imageSelected
        
    }
    func collectionSetup(){
        self.uploadDataSource = uploadCollectionDelegateSource(uploadView: uploadData, view: self)
        uploadCollectionView.delegate = uploadDataSource
        uploadCollectionView.dataSource = uploadDataSource
        uploadCollectionView.reloadData()
    }
    // MARK: - IBActions
    @IBAction func nextAction(_ sender: Any) {
        if let legendViewController = UIStoryboard(name: "Legend", bundle: nil).instantiateInitialViewController() as? LegendViewController {
        legendViewController.upload = uploadSelected

        navigationController?.pushViewController(legendViewController, animated: true)
    }
    }
}
