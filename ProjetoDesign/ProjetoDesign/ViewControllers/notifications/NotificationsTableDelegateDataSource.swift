//
//  NotificationsTableDelegateDataSource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-05.
//

import Foundation
import UIKit
class NotificationsTableDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    
    var view = notificationsViewController()
    var request = NotificationsRequest()
    var userRequest = ViewRequest()
    
    init(view: notificationsViewController, request: NotificationsRequest, userRequest: ViewRequest){
        self.view = view
        self.request = request
        self.userRequest = userRequest
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(request.notificationsUser.count)
        return request.notificationsUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationsCell", for: indexPath) as! NotificationsTableCell
        
        let notifications = request.notificationsUser[indexPath.row]
        cell.setup(notifications: notifications)
       
        print(notifications.name)
        return cell
    }
}
