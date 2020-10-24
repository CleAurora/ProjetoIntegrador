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
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
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
    
}
extension UserViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! UserCollectionCell
        
        return cell
    }
    
    
}
