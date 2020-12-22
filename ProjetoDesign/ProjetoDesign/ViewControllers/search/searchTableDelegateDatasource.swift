//
//  searchTableDelegateDatasource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-04.
//

import Foundation
import UIKit

class searchTableDelegateDatasource: NSObject, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var searchIn = ""
    var usuarioModel = ViewRequest()
    var searchController = searchViewController()
    var filteredArray = [Usuario]()
    var searchImage = searchImageRequest()

    init(usuarioModel: ViewRequest, searchController: searchViewController, imageController: searchImageRequest) {
        self.usuarioModel = usuarioModel
        self.searchController = searchController
        self.searchImage = imageController
        filteredArray = usuarioModel.userArray
    }

    func filter(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if searchIn.isEmpty {
            searchController.dataCollectionView.isHidden = false
        } else {
            let options: String.CompareOptions = [.caseInsensitive, .diacriticInsensitive]
            let searchText = searchIn.folding(options: options, locale: nil)

            filteredArray = usuarioModel.userArray.filter({ (user) -> Bool in
                guard !searchText.isEmpty else {
                    return true
                }

                let nameToCompare = user.name.folding(options: options, locale: nil)
                let nicknameToCompare = user.nickname.folding(options: options, locale: nil)

                return nameToCompare.contains(searchText) || nicknameToCompare.contains(searchText)
            })
        }

        completionHandler(true, nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewcontroller = UIStoryboard(name: "User", bundle: nil).instantiateInitialViewController() as? UserViewController{
            viewcontroller.userProfile = filteredArray[indexPath.row]
            searchController.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableCell
        cell.setup(user: filteredArray[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "PhotoDetail", bundle: nil).instantiateInitialViewController() as? PhotoDetailViewController {
            vc.user = searchImage.userArray[indexPath.row]
            searchController.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchImage.userArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCCell", for: indexPath) as! searchCollectionCell
        cell.setup(user: searchImage.userArray[indexPath.row])

        return cell
    }
}
