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
    @IBOutlet weak var notificationsTableView: UITableView!
    private lazy var controller: NotificationsTableDelegateDataSource = NotificationsTableDelegateDataSource(
        view: self, request: request, followRequest: followRequest
    )
    private lazy var request = NotificationsRequest()
    private lazy var followRequest = FollowRequest()
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
        super.viewDidAppear(animated)

        getData()
    }
    private func getData(){
        request.downloadData(completionHandler: { [weak self] success,_ in
            if success {
                self?.tableviewSetup()
            }
        })
    }
    
    func tableviewSetup(){
        notificationsTableView.delegate = controller
        notificationsTableView.dataSource = controller
        notificationsTableView.reloadData()
    }
}

