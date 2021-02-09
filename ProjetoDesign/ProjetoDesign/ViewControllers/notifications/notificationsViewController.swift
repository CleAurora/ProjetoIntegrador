//
//  notificationsViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

final class notificationsViewController: UIViewController {

    // MARK: - IBOultes
    @IBOutlet var tabBarViewRight: UIView!
    @IBOutlet var tabBarViewLeft: UIView!
    @IBOutlet var notificationsTableView: UITableView!
   
    private lazy var controller: NotificationsTableDelegateDataSource = NotificationsTableDelegateDataSource(
        view: self, request: request, followRequest: followRequest
   )
    var request = NotificationsRequest()
    var followRequest = FollowRequest()

    // MARK: - Proprierts
    var userArray = [Post]()

    // MARK: - Super Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    
        notificationsTableView.delegate = controller
        notificationsTableView.dataSource = controller
        
        tabBarViewRight.roundCorners(.topLeft, radius: 33)
        tabBarViewLeft.roundCorners(.topRight, radius: 33)
        
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    private func getData(){
        request.downloadData { success,_ in
            if success {
                self.tableviewSetup()
            }
        }
    }
    
    func tableviewSetup(){
        
        notificationsTableView.reloadData()
    }
}

