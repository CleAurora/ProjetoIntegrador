//
//  notificationsViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class notificationsViewController: UIViewController {

    // MARK: - IBOultes
    @IBOutlet weak var notificationsTableView: UITableView!
    var controller: NotificationsTableDelegateDataSource?
    var request = NotificationsRequest()
    var userSelected = userSelectedrequest()
    var userRequest = ViewRequest()
    // MARK: - Proprierts
    var userArray = [Post]()

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    func getData(){
        request.downloadData(completionHandler: { success,_ in
            if success {
                self.tableviewSetup()
            }
        })
    }
    func tableviewSetup(){
        self.controller = NotificationsTableDelegateDataSource(view: self, request: request, userRequest: userRequest)
        notificationsTableView.delegate = controller
        notificationsTableView.dataSource = controller
        notificationsTableView.reloadData()
    }
}

