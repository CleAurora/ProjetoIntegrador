//
//  UploadViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import Reachability
import PKHUD
import SwiftGifOrigin
import Photos

class UploadViewController: UIViewController,  UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    // MARK: - IBOutlets
    @IBOutlet weak var resizeImageView: UIImageView!
    @IBOutlet weak var uploadCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet var imageViewBorder: UIView!
    @IBOutlet var tabBarViewLeft: UIView!
    @IBOutlet var tabBarViewRight: UIView!
    @IBOutlet var imageLoading: UIImageView!
    @IBOutlet var tabBarCustomItem: UITabBarItem!
    
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
        
        
        tabBarViewLeft.roundCorners(.topRight, radius: 33)
        tabBarViewRight.roundCorners(.topLeft, radius: 33)
        imageViewBorder.roundedBottom()
        setupReachability()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        uploadData.photosArray.removeAll()
    
        grabPhotos()
    }
    
    func showLoading(){
        if uploadData.photosArray.count == 0 {
            imageLoading.isHidden = false
            imageLoading.image = UIImage.gif(name: "loading")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "activateTab"), object: .none)
        self.tabBarController?.tabBar.isHidden = false
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
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.authorizedAcessPhotos()
                }else if status == .denied {
                    self.denideAcessPhotos()
                }
             }
            )} else if photos == .authorized {
                authorizedAcessPhotos()
            }else if photos == .denied {
                denideAcessPhotos()
            }
    }
    func authorizedAcessPhotos(){
        uploadData.grabPhotos(completionHandler: { success, _ in
        if success {
            collectionSetup()
        }else{
            print("dont have acess")
            }
        })
    }
    func denideAcessPhotos(){
        let alert = UIAlertController(title: "Photos", message: "Photos access is absolutely necessary to use this app", preferredStyle: .alert)
                // Add "OK" Button to alert, pressing it will bring you to the settings app
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }))
                // Show the alert with animation
                self.present(alert, animated: true)
    }
    func collectionSetup(){
        self.uploadDataSource = uploadCollectionDelegateSource(uploadView: uploadData, view: self)
        uploadCollectionView.delegate = uploadDataSource
        uploadCollectionView.dataSource = uploadDataSource
        
        if uploadData.photosArray.count > 0 {
            imageLoading.isHidden = true
        }
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

