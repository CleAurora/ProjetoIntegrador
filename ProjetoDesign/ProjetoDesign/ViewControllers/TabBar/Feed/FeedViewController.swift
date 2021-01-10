//
//  FeedViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

final class FeedViewController: UIViewController, HeaderDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var storieCollectionView: UICollectionView!

    // MARK: - Proprierts
    var arrayTable = [Post]()
    var arrayCollection = [stories]()
    var currentUser: Profile?

    private lazy var viewModel = FeedViewModel(for: self)

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupCollection()

        navigationController?.navigationBar.isHidden = true

        viewModel.load { [weak self] in
            self?.feedTableView.reloadData()
        }

        viewModel.getCurrentUser { [weak self] profile in
            self?.currentUser = profile
            self?.storieCollectionView.reloadData()
        }

        arrayCollection.append(stories(storieImageView: "gwen"))
        arrayCollection.append(stories(storieImageView: "miles1.jpeg"))
        arrayCollection.append(stories(storieImageView: "brendon.jpg"))
        arrayCollection.append(stories(storieImageView: "Connor"))

        storieCollectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        feedTableView.reloadData()
    }

    // MARK: - Methods

    func isDeveloping(){
        let alert = UIAlertController(title: "This option still under development", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true, completion: nil)
    }

    func setupTableView(){
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.reloadData()
    }
    func setupCollection(){
        storieCollectionView.delegate = self
        storieCollectionView.dataSource = self
        storieCollectionView.reloadData()
    }

    // MARK: - IBActions
    @IBAction func infoButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "InfoPost", bundle: nil).instantiateInitialViewController() as? infoPostViewController {
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)

        }
    }

}

// MARK: - Extensions 
extension FeedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension FeedViewController: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.setup(post: viewModel.posts[indexPath.row])
        cell.delegate = self

        cell.nameTap = {
        if let viewcontroller = UIStoryboard(name: "User", bundle: nil).instantiateInitialViewController() as? UserViewController {
            viewcontroller.post = self.viewModel.posts[indexPath.row]
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
        cell.heartTap = {
            let h2 = cell.heart
                if h2 != nil {
                    cell.likeImageView.isHidden = false
                    cell.viewLiked.backgroundColor = UIColor.systemIndigo
                    cell.likeImageView.image = UIImage(named: "heart1.png")
                    cell.heart = nil
                    let toImage = UIImage(named:"heart1.png")

                    UIView.transition(with: cell,
                                      duration: 0.3,
                                          options: .transitionCrossDissolve,
                                          animations: {
                                            cell.likeImageView.image = toImage
                                          },
                                          completion: {_ in (
                                            //let notImage = UIImage(named:"")
                                                        UIView.transition(with: cell.likeImageView,
                                                                              duration: 2,
                                                                              options: .transitionCrossDissolve,
                                                                              animations: {
                                                                                cell.likeImageView.image = UIImage(named: "")
                                                                              },
                                                                              completion: nil)
                    )})
                }else {
                    cell.viewLiked.backgroundColor = UIColor.lightGray
                    //cell.likeImageView.image = UIImage(named: "heart0.png")
                    cell.heart = "Item"

                    let toImage = UIImage(named:"broken")

                    UIView.transition(with: cell.likeImageView,
                                      duration: 0.3,
                                          options: .transitionCrossDissolve,
                                          animations: {
                                            cell.likeImageView.image = toImage
                                          },
                                          completion: {_ in (
                                            //let notImage = UIImage(named:"")
                                            UIView.transition(with: cell.likeImageView,
                                                duration: 1,
                                                options: .transitionCrossDissolve,
                                                animations: {
                                                cell.likeImageView.image = UIImage(named: "brokenwhite")
                                                },
                                                    completion: {_ in (
                                                     UIView.transition(with: cell.likeImageView,
                                                     duration: 0.5, options: .transitionCrossDissolve,
                                                     animations: {
                                                     cell.likeImageView.image = UIImage(named: "")
                                                    },
                                                     completion: nil)
                 )})
              )})
            }
        }
        return cell
    }
}

extension FeedViewController: ButtonsTableView{
    func didButtonPressed(postId: String?) {
        if let viewController = UIStoryboard(name: "Comments", bundle: nil).instantiateInitialViewController() as? CommentsViewController {
            viewController.postId = postId
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension FeedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isDeveloping()
    }
}

extension FeedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storieCell", for: indexPath) as! StorieCollectionCell
        cell.setup(storie: arrayCollection[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "currentCell", for: indexPath) as! StoriesReusableView

        if let currentUser = currentUser {
            cell.setup(user: currentUser)
        }

        cell.teste()
        cell.delegate = self

        return cell
    }

    func doSomething() {
        isDeveloping()
    }
}
