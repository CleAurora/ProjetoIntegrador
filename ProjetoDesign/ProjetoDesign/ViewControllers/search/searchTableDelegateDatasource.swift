//
//  searchTableDelegateDatasource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-04.
//

import Foundation
import UIKit

class searchTableDelegateDatasource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var searchIn = ""
    var usuarioModel = ViewRequest()
    var searchController = searchViewController()
    var filteredArray = [Usuario]()
    
    init(usuarioModel: ViewRequest, searchController: searchViewController) {
        self.usuarioModel = usuarioModel
        self.searchController = searchController
        filteredArray = usuarioModel.userArray
    }
    
    func filter(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if searchIn.isEmpty {
            searchController.dataCollectionView.isHidden = false
            
        }else{
            
            let searchText = searchIn.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
            
            filteredArray = usuarioModel.userArray.filter({(name) -> Bool in
                let canAppear = true
               
                return canAppear
            })
        
            .filter({(name) -> Bool in
                if searchText.isEmpty {
                    return true
                }
                return name.name.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil).contains(searchText)
            })
            
        }
        print(filteredArray)
       completionHandler(true,nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableCell
        cell.setup(user: filteredArray[indexPath.row])
        return cell
    }
}




