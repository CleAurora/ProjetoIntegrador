//
//  PhotoDetailViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit

final class PhotoDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var photoTableView: UITableView!
    @IBOutlet var loadingImage: UIImageView!
    
    // MARK: - Proprierts
    var photoModel: PhotoDetailModel?
    var controller: PhotoDetailTableDelegateDataSource?
    var photoArray = [PhotoDetailModel]()
    var viewRequest = ViewRequest()
    var user: searchModel?
    var post: PostUser?
    var postDetail: DownloadPost?
    var photoDetail = [PostUser]()
    var name: String?
    var image: String?
    var comments: String?
    var selectedFromCurrent: String?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingImage.isHidden = false
        loadingImage.image = UIImage.gif(name: "loading")
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if selectedFromCurrent != nil {
            loadDataCurrent()
        }else{
            getData()
        }
    }

    func getData(){
       
        viewRequest.userSelected = user?.userId
        viewRequest.loadData(completionHandler: { success, _ in
            if success {
                self.tablePassData()
            }
        })
    }
    
    func loadDataCurrent(){
        self.controller = PhotoDetailTableDelegateDataSource(view: self, request: viewRequest)
        controller?.loadData(completionHandler: { success, _ in
            if success {
                
                self.photoTableView.delegate = self.controller
                self.photoTableView.dataSource = self.controller
                self.photoTableView.reloadData()
                self.loadingImage.isHidden = true
            }
        })
    }
    
    func tablePassData(){
        self.controller = PhotoDetailTableDelegateDataSource(view: self, request: viewRequest)
        controller?.passData(completionHandler: { success, _ in
            if success {
                
                self.photoTableView.delegate = self.controller
                self.photoTableView.dataSource = self.controller
                self.photoTableView.reloadData()
                self.loadingImage.isHidden = true
            }
        })
    }
}

