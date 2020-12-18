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

    // MARK: - Proprierts
    var photoModel: PhotoDetailModel?
    var controller: PhotoDetailTableDelegateDataSource?
    var photoArray = [PhotoDetailModel]()
    var viewRequest = ViewRequest()
    var user: searchModel?
    var post: PostUser?
    var photoDetail = [PostUser]()
    var name: String?
    var image: String?
    var comments: String?

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        photoTableView.delegate = self
//        photoTableView.dataSource = self

        getData()
    }
    
    func getData(){
        viewRequest.userSelected = user?.userId
        viewRequest.loadData(completionHandler: { success, _ in
            if success {
                self.tableSetup()
            }
        })
    }

    
    func tableSetup(){
        self.controller = PhotoDetailTableDelegateDataSource(view: self, request: viewRequest)
        controller?.passData(completionHandler: { success, _ in
            if success {
                
                self.photoTableView.delegate = self.controller
                self.photoTableView.dataSource = self.controller
                self.photoTableView.reloadData()
                
            }
        })
    }
}

//// MARK: - Extensions
//extension PhotoDetailViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
//}
//extension PhotoDetailViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return photoDetail.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! PhotoDetailTableViewCell
//        cell.setupPhoto(photo: photoDetail[indexPath.row])
//        return cell
//    }
//
//}
