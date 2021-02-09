//
//  searchViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit
import Gifu

class searchViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var userSearchView: UISearchBar!
    @IBOutlet weak var dataCollectionView: UICollectionView!
    @IBOutlet var imageLoading: GIFImageView!
    var timer: Timer?
    // MARK: - Proprierts
    var searchIn = ""
    var userArray = [Post]()
    var filteredArray = [Usuario]()
    private lazy var controller = ViewRequest()
    private lazy var imageRequest = searchImageRequest()
    private lazy var viewModel: searchTableDelegateDatasource = searchTableDelegateDatasource(
        usuarioModel: controller, searchController: self, imageController: imageRequest
    )
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        searchTableView.isHidden = true
        userSearchView.delegate = self
        imageLoading.isHidden = false
        imageLoading.prepareForAnimation(withGIFNamed: "loading")
        imageLoading.startAnimatingGIF()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "activateTab"), object: .none)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    @objc func showLoading(){
        if imageRequest.userArray.count == 0 {
            imageLoading.startAnimatingGIF()
        }
    }

    func getImage(){
        self.imageRequest.loadData(completionHandler: { success, _ in
            if success {
                self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.collectionSetup),userInfo: nil, repeats: true)
            }
        })
    }
    
    @objc func collectionSetup(){

        dataCollectionView.delegate = viewModel
        dataCollectionView.dataSource = viewModel
        dataCollectionView.reloadData()
        
        imageLoading.isHidden = true
        imageLoading.stopAnimatingGIF()
        
    }
    func tableViewSetup(){
        
        searchTableView.delegate = viewModel
        searchTableView.dataSource = viewModel
        searchTableView.reloadData()
    }

    func getData(){
        controller.loadData { [unowned self] success, _ in
            if success {
                getImage()
                tableViewSetup()
            }
        }
    }
}

extension searchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTableView.delegate = viewModel
        searchTableView.dataSource = viewModel

        viewModel.searchIn = searchText

        dataCollectionView.isHidden = true
        searchTableView.isHidden = false

        viewModel.filter { [weak self] success, _ in
            if success {
                self?.searchTableView.reloadData()
            }
        }
    }
}

