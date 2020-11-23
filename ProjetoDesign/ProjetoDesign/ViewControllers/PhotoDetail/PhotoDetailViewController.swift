//
//  PhotoDetailViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var photoTableView: UITableView!
    
    // MARK: - Proprierts
    var post: PostUser?
    var photoDetail = [PostUser]()
    var name: String?
    var image: String?
    var comments: String?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        name = post!.name
        photoTableView.delegate = self
        photoTableView.dataSource = self
        photoDetail.append(PostUser(name: "\(name!)", city: "\(post!.city)", imageProfile: "\(post!.imageProfile)", imagePost: "\(image!)", comments: "\(comments!)", allImages: ["",""]))
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    func textInfo(){
     
    }
}

// MARK: - Extensions
extension PhotoDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
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
