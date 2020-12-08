//
//  searchViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class searchViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var userSearchView: UISearchBar!
    @IBOutlet weak var dataCollectionView: UICollectionView!
    
    // MARK: - Proprierts
    var searchIn = ""
    var userArray = [Post]()
    var filteredArray = [Usuario]()
    
    var controller = ViewRequest()
    var viewModel: searchTableDelegateDatasource?
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        userArray.append(Post(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel2.jpg", comments: "", allImages: [""]))
        userArray.append(Post(name: "Brendon", city: "Los Angeles", imageProfile: "brendon.jpg", imagePost: "post1.jpg", comments: "", allImages: [""]))
        userArray.append(Post(name: "Miles", city: "Vancouver, BC", imageProfile: "miles1.jpeg", imagePost: "miles0.jpeg", comments: "", allImages: [""]))
        navigationController?.navigationBar.isHidden = true
        searchTableView.isHidden = true
        dataCollectionView.dataSource = self
        dataCollectionView.delegate = self
        userSearchView.delegate = self
        dataCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    func tableViewSetup(){
        self.viewModel = searchTableDelegateDatasource(usuarioModel: controller, searchController: self)
        
        searchTableView.delegate = viewModel
        searchTableView.dataSource = viewModel
        searchTableView.reloadData()
    }
    
    func getData(){
        self.controller.loadData(completionHandler: { success, _ in
            if success {
                self.tableViewSetup()
               }
        })
    }
}

extension searchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.viewModel = searchTableDelegateDatasource(usuarioModel: controller, searchController: self)
        searchTableView.delegate = viewModel
        searchTableView.dataSource = viewModel
        
        self.viewModel?.searchIn = searchText
        
        dataCollectionView.isHidden = true
        searchTableView.isHidden = false
        
        self.viewModel?.filter(completionHandler: { success, _ in
            if success {
               self.searchTableView.reloadData()
            }
    })
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
