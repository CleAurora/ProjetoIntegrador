//
//  notificationsViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class notificationsViewController: UIViewController {

    @IBOutlet weak var notificationsTableView: UITableView!
    var userArray = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()

        userArray.append(Post(name: "Brendon", city: "Los Angeles", imageProfile: "brendon.jpg", imagePost: "post1.jpg"))
        userArray.append(Post(name: "Miles", city: "Vancouver, BC", imageProfile: "miles1.jpeg", imagePost: "miles0.jpeg"))
        
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        notificationsTableView.reloadData()
        // Do any additional setup after loading the view.
    }


}
extension notificationsViewController: UITableViewDelegate {
    
}

extension notificationsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationsCell", for: indexPath) as! NotificationsTableCell
        cell.setup(users: userArray[indexPath.row])
        return cell
    }
    
    
}

