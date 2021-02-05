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
    @IBOutlet var imageLoading: UIImageView!
    
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
        self.viewModel = searchTableDelegateDatasource(usuarioModel: controller, searchController: self, imageController: imageRequest)
        searchTableView.isHidden = true
        userSearchView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLoading()
       
    }
    
    @objc func showLoading(){
        if imageRequest.userArray.count == 0 {
            imageLoading.image = UIImage.gif(name: "loading")
        }
    }
    func getImage(){
        self.imageRequest.loadData(completionHandler: { success, _ in
            if success {
                self.collectionSetup()
            }
        })
    }
    
    func collectionSetup(){
      
        dataCollectionView.delegate = viewModel
        dataCollectionView.dataSource = viewModel
        
        if imageRequest.userArray.count > 0 {
            imageLoading.isHidden = true
        }
        dataCollectionView.reloadData()
    }
    func tableViewSetup(){
        
        searchTableView.delegate = viewModel
        searchTableView.dataSource = viewModel
        searchTableView.reloadData()
    }

    func getData(){
        self.controller.loadData(completionHandler: { success, _ in
            if success {
                self.getImage()
                self.tableViewSetup()
            }
        })
    }
}

extension searchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

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

