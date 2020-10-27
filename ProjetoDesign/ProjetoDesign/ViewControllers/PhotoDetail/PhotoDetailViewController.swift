//
//  PhotoDetailViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var photoTableView: UITableView!
    var post: PostUser?
    var photoDetail = [PhotoDetail]()
    var photos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoDetail.append(PhotoDetail(name: "\(post?.name)", city: "\(post?.city)", imageProfile: "\(post?.imageProfile)", imagePost: "\(post?.imagePost)", comments: "\(post?.comments)", allImages: ["\(post?.allImages)"]))
        photos.append(contentsOf: post!.allImages)
        print(post?.allImages)
        print(post?.imagePost)
        photoTableView.delegate = self
        photoTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}
extension PhotoDetailViewController: UITableViewDelegate{
    
}
extension PhotoDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! PhotoDetailTableViewCell
       cell.setupPhoto(photo: photoDetail[indexPath.row])
        return cell
    }
    
    
}
