//
//  notificationsViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class notificationsViewController: UIViewController {

    // MARK: - IBOultes
    @IBOutlet var tabBarViewRight: UIView!
    @IBOutlet var tabBarViewLeft: UIView!
    @IBOutlet weak var notificationsTableView: UITableView!
    var controller: NotificationsTableDelegateDataSource?
    var request = NotificationsRequest()
    var userSelected = userSelectedrequest()
    var userRequest = ViewRequest()
    var followRequest = FollowRequest()
    // MARK: - Proprierts
    var userArray = [Post]()

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        tabBarViewRight.roundCorners(.topLeft, radius: 33)
        tabBarViewLeft.roundCorners(.topRight, radius: 33)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        //getData()
    }
    private func getData(){
        request.downloadData(completionHandler: { success,_ in
            if success {
                self.tableviewSetup()
            }
        })
    }
    
    func tableviewSetup(){
        self.controller = NotificationsTableDelegateDataSource(view: self, request: request, userRequest: userRequest, followRequest: followRequest)
        notificationsTableView.delegate = controller
        notificationsTableView.dataSource = controller
        notificationsTableView.reloadData()
    }
}

