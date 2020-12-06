//
//  UserTableDelegateDataSource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-05.
//

import Foundation
import UIKit
class UserCollectionDelegateDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var userModel = userSelectedrequest()
    var view = UserViewController()
    var userSelected = [Usuario]()
    
    init(userModel: userSelectedrequest, view: UserViewController) {
        self.userModel = userModel
        self.view = view
        
    }
    func useArrayTo(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        userSelected.append(userModel.selectedUser!)
        //userSelected = userModel.selectedUser
        print(userSelected)
        print("array")
        completionHandler(true,nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return view.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionCell
        //cell.setup(user: userArray[indexPath.row])
        print(view.images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "profileReuCell", for: indexPath) as! ProfileCollectionReusableView
        cell.setup(user: userSelected[indexPath.row])
        return cell
    }
    
}
