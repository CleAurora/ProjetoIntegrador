//
//  CommentsViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit
import PKHUD

final class CommentsViewController: UIViewController {
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var profileImageView: roundImageView!
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var postButton: UIButton!

    // MARK: - Private constants

    var postId: String?
    private lazy var viewModel = CommentsViewModel(postId: postId)

    // MARK: - Super Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deactivateTab"), object: .none)
        self.tabBarController?.tabBar.isHidden = true
        
        setupView()
        fetch()
    }

    private func fetch() {
        HUD.show(.progress)

        viewModel.get { [self] in
            showErrorIfNeeded(title: "Erro ao carregar os comentários")
            updateView()
        }
    }

    private func showErrorIfNeeded(title: String) {
        if let error = viewModel.failure {
            show(error: error, title: title)
        }
    }

    private func show(error: Error, title: String) {
        let alertController = UIAlertController(
            title: title, message: error.localizedDescription, preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        present(alertController, animated: true, completion: nil)
    }

    private func updateView() {
        profileImageView.kf.setImage(with: viewModel.user?.photoUrl)
        commentsTableView.reloadData()
        HUD.hide(animated: true)
    }

    private func setupView() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        title = "Comments"

        //postButton.isHidden = true
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
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
        commentTextField.resignFirstResponder()
        commentTextField.text = ""
    }

    // MARK: - IBActions
    @IBAction func postButton(_ sender: Any) {
        viewModel.add(comment: commentTextField.text) { [self] in
            addNewItem()
            showErrorIfNeeded(title: "Erro ao adicionar o comentário")
        }
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
        viewModel.comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentsCell", for: indexPath) as! CommentsTableCell
        cell.setup(comments: viewModel.comments[indexPath.row])

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
