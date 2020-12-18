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
    var imageRequest = searchImageRequest()
    var viewModel: searchTableDelegateDatasource?
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        searchTableView.isHidden = true
        userSearchView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
        getImage()
       
    }
    
    func getImage(){
        self.imageRequest.loadData(completionHandler: { success, _ in
            if success {
                self.collectionSetup()
            }
        })
    }
    
    func collectionSetup(){
        self.viewModel = searchTableDelegateDatasource(usuarioModel: controller, searchController: self, imageController: imageRequest)
        
        dataCollectionView.delegate = viewModel
        dataCollectionView.dataSource = viewModel
        dataCollectionView.reloadData()

    }
    func tableViewSetup(){
        self.viewModel = searchTableDelegateDatasource(usuarioModel: controller, searchController: self, imageController: imageRequest)
        
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

        self.viewModel = searchTableDelegateDatasource(usuarioModel: controller, searchController: self, imageController: imageRequest)
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

