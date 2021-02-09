//
//  PhotoDetailViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit
import Kingfisher
import Firebase
final class PhotoDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var photoTableView: UITableView!
    @IBOutlet var commentsTableView: UITableView!
    @IBOutlet var loadingImage: UIImageView!
    @IBOutlet var photoProfile: roundImageView!
    @IBOutlet var nameUserButton: UIButton!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var postImage: roundImageView!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var photoView: UIView!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var commentImage: UIImageView!
    @IBOutlet var commentTextField: UITextField!
    
    // MARK: - Proprierts
    var photoModel: PhotoDetailModel?
    private lazy var databaseReference: DatabaseReference = Database.database().reference()
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
            postSetup()
           
        }else{
            getData()
            postSetup()
        }
    }
    
    func postSetup(){
        if let userName = name ?? viewRequest.userName{
            self.title = "\(userName)'s Post"
            nameUserButton.setTitle(userName, for: .normal)
            if let caption = user?.caption ?? postDetail?.caption {
                
                let text = "\(userName): \(caption)".withBoldText(text: "\(userName)")
                captionLabel.attributedText = text
            }
        }
        self.commentsLabel.text = "\(0)"
        if let image = postDetail?.imagePost ?? user?.imagePostUrl{
            postImage.kf.setImage(with: URL(string: image))
        }
        if let profileImage = image ?? viewRequest.imageProfile{
            photoProfile.kf.setImage(with: URL(string: profileImage))
            commentImage.kf.setImage(with: URL(string: profileImage))
        }
        cityLabel.text = user?.city ?? postDetail?.city
    }
    
    func getData(){
        
        viewRequest.userSelected = user?.userId
        viewRequest.loadData(completionHandler: { success, _ in
            if success {
                self.postSetup()
            }
        })
    }
    
    func loadDataCurrent(){
       
        controller?.loadData(completionHandler: { success, _ in
            if success {
            }
        })
    }
    @IBAction func addNewComments(_ sender: Any) {
        setComments()
    }
    func setComments(){
        let uid = Auth.auth().currentUser?.uid
        let dict: [String: Any] = [
            "UserID": uid,
            "TimeStamp": NSDate().timeIntervalSince1970,
            "Text": commentTextField.text]
        
        if let childKey = user?.childKey ?? postDetail?.childKey {
            databaseReference.child("posts").child(childKey).child("Comments").childByAutoId().setValue(dict)
            commentTextField.text = nil
    }
}
    func getComments(){
        if let postID = postDetail?.childKey ?? user?.childKey{
            commentsRequest.getComments(ID: postID , completionHandler: { success, _ in
                if success{
                    self.commentsLabel.text = "\(self.commentsRequest.commentsDetails.count)"
                   
                    
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

