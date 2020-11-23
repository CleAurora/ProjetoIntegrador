//
//  UserViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-23.
//

import UIKit

class UserViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    // MARK: - Proprierts
    var name: String?
    var userArray = [Post]()
    var post: PostUser?
    var images: [String] = []
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        userArray.append(Post(name: "\(post!.name)", city: "", imageProfile: "\(post!.imageProfile)", imagePost: "", comments: "\(post!.comments)", allImages: ["", ""]))
        images.append(contentsOf: post!.allImages)
    }
}

// MARK: - Extensions 
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionCell
        //cell.setup(user: userArray[indexPath.row])
        print(images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileReuCell", for: indexPath) as! ProfileCollectionReusableView
        cell.setup(post: userArray[indexPath.row])
        return cell
    }
    
    
}
