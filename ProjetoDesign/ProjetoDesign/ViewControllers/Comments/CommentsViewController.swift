//
//  CommentsViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit

class CommentsViewController: UIViewController {
    @IBOutlet weak var commentsTableview: UITableView!
    @IBOutlet weak var profileImageView: roundImageView!
    var commentsArray = [comments]()
    @IBOutlet weak var commentsTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsArray.append(comments(name: "Melissa", comment: "The black rose should bloom once more", image: "mel0.jpg"))
        commentsArray.append(comments(name: "Brendon", comment: "Too weird to live, too rare to die ", image: "brendon.jpg"))
        commentsArray.append(comments(name: "Miles", comment: "Needless to say, I keep her in check", image: "miles0.jpeg"))
        profileImageView.image = UIImage(named: "mel0.jpg")
        commentsTableview.delegate = self
        commentsTableview.dataSource = self
        commentsTableview.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
extension CommentsViewController: UITableViewDelegate{
    
}
extension CommentsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as! CommentsTableCell
        cell.setup(comments: commentsArray[indexPath.row])
        return cell
    }
    
    
}
