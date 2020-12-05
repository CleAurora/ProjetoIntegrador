//
//  ProfileViewModel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-04.
//

import Foundation
import UIKit
class ProfileViewModel: NSObject, UICollectionViewDelegate, UICollectionViewDataSource{

    
    var userModel = ViewRequest()
    var view = ProfileViewController()
    
    init(userModel: ViewRequest, view: ProfileViewController) {
        self.userModel = userModel
        self.view = view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return view.imagensArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionCell
        cell.setup(user: view.imagensArray[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileReuCell", for: indexPath) as! ProfileCollectionReusableView
        cell.setup(user: userModel.currentUser[indexPath.row])
        return cell
    
    
}
}