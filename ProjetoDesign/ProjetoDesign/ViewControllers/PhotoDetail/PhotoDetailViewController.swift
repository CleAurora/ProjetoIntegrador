//
//  PhotoDetailViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit

final class PhotoDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var photoTableView: UITableView!
    @IBOutlet var commentsTableView: UITableView!
    @IBOutlet var loadingImage: UIImageView!
    
    // MARK: - Proprierts
    var photoModel: PhotoDetailModel?
    var controller: PhotoDetailTableDelegateDataSource?
    var commentsRequest = CommentsRequest()
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deactivateTab"), object: .none)
        self.tabBarController?.tabBar.isHidden = true
        
        self.controller = PhotoDetailTableDelegateDataSource(view: self, request: viewRequest, commentsRequest: commentsRequest)
        getComments()
        loadingImage.isHidden = false
        loadingImage.image = UIImage.gif(name: "loading")
        
        self.navigationController?.navigationBar.isHidden = false
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
       
        controller?.loadData(completionHandler: { success, _ in
            if success {
                self.tableViewSetup()
            }
        })
    }
    
    func getComments(){
        if let postID = postDetail?.childKey {
            commentsRequest.getComments(ID: postID , completionHandler: { success, _ in
                if success{
                    self.tableCommentsSetup()
                }
            })
        }
    }
    
    func tableCommentsSetup(){
        self.commentsTableView.delegate = self.controller
        self.commentsTableView.dataSource = self.controller
        self.commentsTableView.reloadData()
    }
    
    func tablePassData(){
        controller?.passData(completionHandler: { success, _ in
            if success {
                self.tableViewSetup()
               
            }
        })
    }
    
    func tableViewSetup(){
        self.photoTableView.delegate = self.controller
        self.photoTableView.dataSource = self.controller
        self.photoTableView.reloadData()
        self.loadingImage.isHidden = true
        self.getComments()
    }
}

