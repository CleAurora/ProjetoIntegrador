//
//  UploadViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import Reachability
import PKHUD

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

    private let reachability = try! Reachability()
    private var hasInternet: Bool = true

    deinit {
        reachability.stopNotifier()
    }

    // MARK: - Super Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewBorder.roundedBottom()
        setupReachability()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uploadData.photosArray.removeAll()
        grabPhotos()
    }

    private func setupReachability() {
        reachability.whenReachable = { [self] _ in
            hasInternet = true
        }

        reachability.whenUnreachable = { [self] _ in
            hasInternet = false
        }

        try? reachability.startNotifier()
    }

    func grabPhotos(){
        uploadData.grabPhotos(completionHandler: { success, _ in
            if success {
                collectionSetup()
            }
        })
    }
    func collectionSetup(){
        self.uploadDataSource = uploadCollectionDelegateSource(uploadView: uploadData, view: self)
        uploadCollectionView.delegate = uploadDataSource
        uploadCollectionView.dataSource = uploadDataSource
        uploadCollectionView.reloadData()
    }
    // MARK: - IBActions

    private func showInternetError() {
        HUD.flash(.labeledError(title: "No internet", subtitle: "You can't continue"), delay: 5)
    }

    @IBAction func nextAction(_ sender: Any) {
        guard hasInternet else {
            return showInternetError()
        }

        if let legendViewController = UIStoryboard(name: "Legend", bundle: nil).instantiateInitialViewController() as? LegendViewController {
        legendViewController.imagemProfile = resizeImageView.image

        navigationController?.pushViewController(legendViewController, animated: true)
    }
    }
}
