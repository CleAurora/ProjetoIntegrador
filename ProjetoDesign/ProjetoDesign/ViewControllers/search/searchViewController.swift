//
//  searchViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class searchViewController: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var userSearchView: UISearchBar!
    @IBOutlet weak var dataCollectionView: UICollectionView!
    var searchIn = ""
    var userArray = [Post]()
    var filteredArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userArray.append(Post(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel2.jpg", comments: "", allImages: [""]))
        userArray.append(Post(name: "Brendon", city: "Los Angeles", imageProfile: "brendon.jpg", imagePost: "post1.jpg", comments: "", allImages: [""]))
        userArray.append(Post(name: "Miles", city: "Vancouver, BC", imageProfile: "miles1.jpeg", imagePost: "miles0.jpeg", comments: "", allImages: [""]))
        

        
        filteredArray = userArray
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.isHidden = true
        userSearchView.delegate = self
        dataCollectionView.dataSource = self
        dataCollectionView.delegate = self
        dataCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func filter() {
        if searchIn.isEmpty {
            dataCollectionView.isHidden = false
        }else{
            
            let searchText = searchIn.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
            filteredArray = userArray.filter({(name) -> Bool in
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
        searchTableView.reloadData()
    }
}
extension searchViewController: UITableViewDelegate{
    
}
extension searchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableCell
        cell.setup(user: filteredArray[indexPath.row])
        return cell
    }
}
extension searchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchIn = searchText
        dataCollectionView.isHidden = true
        searchTableView.isHidden = false
        filter()
    }
    
}
extension searchViewController: UICollectionViewDelegate{
    
}
extension searchViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCCell", for: indexPath) as! searchCollectionCell
        cell.setup(user: userArray[indexPath.row])
        return cell
    }
    
    
}
