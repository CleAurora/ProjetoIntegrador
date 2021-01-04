//
//  CommentsViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit

class CommentsViewController: UIViewController{

    // MARK: - IBOutlets
    @IBOutlet weak var commentsTableview: UITableView!
    @IBOutlet weak var profileImageView: roundImageView!
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var postButton: UIButton!

    // MARK: - Proprierts
    var commentsArray = [CommentViewModel]()

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        self.title = "Comments"

        commentsArray.append(CommentViewModel(userName: "Melissa", text: "The black rose should bloom once more", image: "mel0.jpg"))
        commentsArray.append(CommentViewModel(userName: "Brendon", text: "Too weird to live, too rare to die ", image: "brendon.jpg"))
        commentsArray.append(CommentViewModel(userName: "Miles", text: "Needless to say, I keep her in check", image: "miles0.jpeg"))
        commentsArray.append(CommentViewModel(userName: "Gwen", text: "Don't threaten me with a good time", image: "gwen"))
        commentsArray.append(CommentViewModel(userName: "Connor", text: "Have you never wondered who you really are? wheter you're just a machine executing a program or...", image: "Connor"))

        profileImageView.image = UIImage(named: "mel0.jpg")
        postButton.isHidden = true
        commentsTableview.delegate = self
        commentsTableview.dataSource = self
        commentsTableview.reloadData()

        commentTextField.delegate = self

        let imageView = UIImage(systemName: "chevron.backward")!.withTintColor(.systemIndigo)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageView, style: .plain, target: self, action: #selector(addTapped))

    }

    // MARK: OBJC Methods
    @objc func addTapped(){

        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: true)

    }

    // MARK: - Methods
    func buttonShow(){
        if commentTextField.text!.isEmpty || commentTextField.text == "" {
            postButton.isHidden = true
        }else {
            postButton.isHidden = false
        }
    }
    func addNewItem(){
        commentsArray.append(CommentViewModel(userName: "Melissa ", text: "\(commentTextField.text!)", image: "mel0.jpg"))

        commentTextField.resignFirstResponder()
        commentsTableview.reloadData()
        commentTextField.text = ""

    }

    // MARK: - IBActions
    @IBAction func postButton(_ sender: Any) {
        addNewItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Extensions 
extension CommentsViewController: UITableViewDelegate{

}
extension CommentsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as! CommentsTableCell
        cell.setup(comments: commentsArray[indexPath.row])

        cell.likedButton = {
            let itemList = cell.imageString
            if itemList == "suit.heart.fill"{
                cell.likeImage.image = UIImage(systemName: "suit.heart")
            } else {
                cell.likeImage.image = UIImage(systemName: "suit.heart.fill")!.withTintColor(UIColor.systemIndigo)
            }
            cell.changeImage()
        }
        return cell
    }

}
extension CommentsViewController: UITextFieldDelegate{
}
extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
