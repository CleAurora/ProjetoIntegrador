//
//  UserViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-23.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    var name: String?
    var userArray = [Post]()
    var post: PostUser?
    var images: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        images.append(contentsOf: post!.allImages)
        print(images)
        setup()
        // Do any additional setup after loading the view.
    }
    func setup(){
        nameLabel.text = post?.name
        profileImageView.image = UIImage(named: "\(post!.imageProfile)")
        bioLabel.text = post?.comments
    }
}
extension UserViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(images[indexPath.row])
        if let vc = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateInitialViewController() as? PhotoDetailViewController{
            vc.name = post?.name
            vc.comments = post?.comments
            vc.image = images[indexPath.row]
            vc.post = post
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
extension UserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! UserCollectionCell
        cell.imageCollection.image = UIImage(named: images[indexPath.row])
        print(images[indexPath.row])
        return cell
    }
    
    
}
