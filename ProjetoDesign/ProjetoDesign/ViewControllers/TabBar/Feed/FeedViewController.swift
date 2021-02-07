//
//  FeedViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import Reachability
import SwiftMessages
import Firebase
import PKHUD
import SwiftGifOrigin

final class FeedViewController: UIViewController, HeaderDelegate {
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var storieCollectionView: UICollectionView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var withoutPostImage: UIImageView!

    // MARK: - Proprierts

    var arrayTable = [Post]()
    var arrayCollection = [stories]()
    var currentUser: Profile?
    var ref: DatabaseReference!
    var gameTimer: Timer?
    var storiesArray = [StoriesModel]()
    var storiesRequest = StoriesRequest()
    var storiesUsario = [Usuario]()
    private let reachability = try! Reachability()

    private lazy var viewModel = FeedViewModel(for: self)

    deinit {
        reachability.stopNotifier()
    }

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        checkStories()
        
        tabBarView.roundCorners(.topLeft, radius: 33)
        
        navigationController?.navigationBar.isHidden = true
        viewModel.load { [weak self] in
            self?.feedTableView.reloadData()
        }

        viewModel.getCurrentUser { [weak self] profile in
            self?.currentUser = profile
            self?.storieCollectionView.reloadData()
        }

        setupReachability()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(removeOldStories), userInfo: nil, repeats: true)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(checkStories), userInfo: nil, repeats: true)
        gameTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(showAlertWithoutPost), userInfo: nil, repeats: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "activateTab"), object: .none)
        self.tabBarController?.tabBar.isHidden = false
        feedTableView.reloadData()
        storieCollectionView.reloadData()
       
    }
    @objc func showAlertWithoutPost(){
        withoutPostImage.image = UIImage.gif(name: "withoutPost")
    }
    @objc func checkStories(){
        
        storiesRequest.checkFollowing(completionHandler: { success, _ in
            if success {
                self.setupCollection()
            }
        })
    }
    // MARK: - Methods
    @objc func removeOldStories(){
        self.ref = Database.database().reference()
        
        let reference = self.ref.child("stories")

            reference.observe(.value) { (snapshot) in

            if let stories = snapshot.value as? [String: AnyObject] {
                for (_, value) in stories {

                    let storiesToshow = StoriesModel()

                    let image = value["StorieImage"] as? String
                    let userID = value["userID"] as? String
                    let timeStamp = value["TimeStamp"] as? Double
                    let duration = value["Duration"] as? Int
                    let childID = value["childID"] as? String

                    storiesToshow.image = image
                    storiesToshow.timeStamp = timeStamp
                    storiesToshow.userID = userID
                    storiesToshow.duration = duration
                    storiesToshow.childID = childID

                    if let time = storiesToshow.timeStamp {
                        let exampleDate = time + 86400
                        let dateNow = Date().timeIntervalSince1970

                        if let childKey = storiesToshow.childID {
                            
                            if exampleDate <= dateNow {
                                self.ref.child("stories").child(childKey).removeValue()
                                self.checkStories()
                            }
                        }
                    }
                }
            }
                self.storieCollectionView.reloadData()
        }
    }
    private func setupReachability() {
        reachability.whenReachable = { [weak self] _ in
            self?.hideToastMessage()
        }

        reachability.whenUnreachable = { [weak self] _ in
            self?.showToastMessage()
        }

        try? reachability.startNotifier()
    }

    private func showToastMessage() {
        var config = SwiftMessages.Config()

        // Slide up from the bottom.
        config.presentationStyle = .top

        // Display in a window at the specified window level.
        config.presentationContext = .window(windowLevel: .statusBar)

        // Note that, as of iOS 13, it is no longer possible to cover the status bar
        // regardless of the window level. A workaround is to hide the status bar instead.
        config.prefersStatusBarHidden = true

        // Disable the default auto-hiding behavior.
        config.duration = .forever

        // Dim the background like a popover view. Hide when the background is tapped.
        config.dimMode = .gray(interactive: true)

        // Disable the interactive pan-to-hide gesture.
        config.interactiveHide = false

        // Specify a status bar style to if the message is displayed directly under the status bar.
        config.preferredStatusBarStyle = .lightContent

        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: .cardView)

        // Theme message elements with the warning style.
        view.configureTheme(backgroundColor: .black, foregroundColor: .white)

        // Add a drop shadow.
        view.configureDropShadow()

        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
        view.configureContent(
            title: "No internet", body: "Check your connection", iconText: iconText
        )

        view.button?.setTitle("ok", for: .normal)
        view.buttonTapHandler = { [weak self] _ in self?.hideToastMessage() }

        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10

        SwiftMessages.show(config: config, view: view)
    }

    private func hideToastMessage() {
        SwiftMessages.hide()
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

    private func showUserDetail(for indexPath: IndexPath) {
        if let viewcontroller = UIStoryboard(name: "User", bundle: nil).instantiateInitialViewController() as? UserViewController {
            viewcontroller.post = viewModel.posts[indexPath.row]
            navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genericCell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)

        guard let cell = genericCell as? FeedTableViewCell else {
            return genericCell
        }

        cell.setup(post: viewModel.posts[indexPath.row])
        cell.delegate = self

        cell.nameTap = { [weak self] in
            self?.showUserDetail(for: indexPath)
        }

        cell.heartTap = { [weak self] in
            self?.onHeartTapped(for: cell)
        }

        return cell
    }

    private func onHeartTapped(for cell: FeedTableViewCell) {
        if let postId = cell.postId {
            if cell.hasHeart {
                viewModel.dislike(postId: postId) { [weak self] in
                    cell.hasHeart = false
                    self?.heartAnimation(for: cell)
                }
            } else {
                viewModel.like(postId: postId) { [weak self] in
                    cell.hasHeart = true
                    self?.heartAnimation(for: cell)
                }
            }
        }
    }

    private func heartAnimation(for cell: FeedTableViewCell) {
        if cell.hasHeart {
            cell.likeImageView.isHidden = false
            cell.viewLiked.backgroundColor = UIColor.systemIndigo
            cell.likeImageView.image = UIImage(named: "heart1.png")
            let toImage = UIImage(named:"heart1.png")

            UIView.transition(
                with: cell, duration: 0.3, options: .transitionCrossDissolve,
                animations: {
                    cell.likeImageView.image = toImage
                },
                completion: { _ in
                    UIView.transition(
                        with: cell.likeImageView, duration: 2, options: .transitionCrossDissolve,
                        animations: {
                            cell.likeImageView.image = UIImage(named: "")
                        },
                        completion: nil
                    )
                }
            )
        } else {
            cell.likeImageView.isHidden = false
            cell.viewLiked.backgroundColor = UIColor.lightGray

            let toImage = UIImage(named:"broken")

            UIView.transition(
                with: cell.likeImageView, duration: 0.3, options: .transitionCrossDissolve,
                animations: {
                    cell.likeImageView.image = toImage
                },
                completion: { _ in
                    UIView.transition(
                        with: cell.likeImageView, duration: 1, options: .transitionCrossDissolve,
                        animations: {
                            cell.likeImageView.image = UIImage(named: "brokenwhite")
                        },
                        completion: {_ in
                             UIView.transition(
                                with: cell.likeImageView,
                                duration: 0.5, options: .transitionCrossDissolve,
                                animations: {
                                    cell.likeImageView.image = UIImage(named: "")
                                },
                                completion: nil
                             )
                        }
                    )
                }
            )
        }
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
        if let vc = UIStoryboard(name: "StoriesLoaded", bundle: nil).instantiateInitialViewController() as? StoriesLoadedViewController {
            vc.modalPresentationStyle = .fullScreen
            vc.storiesUser = self.storiesRequest.storiesUser[indexPath.row]
            present(vc, animated: true, completion: nil)
        }
    }
    
}

extension FeedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.storiesRequest.storiesUser.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storieCell", for: indexPath) as! StorieCollectionCell
        cell.setupUser(stories: self.storiesRequest.storiesUser[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "currentCell", for: indexPath) as! StoriesReusableView

        if let currentUser = currentUser {
            cell.setup(user: currentUser)
        }
        
        if self.storiesRequest.currentUserStories.count != 0 {
            cell.addNewItemButton.isHidden = true
            cell.borderView.backgroundColor = UIColor(patternImage: UIImage(named: "stories2.jpg")!)
        }else{
            cell.addNewItemButton.isHidden = false
            cell.borderView.backgroundColor = UIColor.clear
        }
        cell.teste()
        cell.delegate = self
        return cell
    }

    func doSomething() {
    
        if self.storiesRequest.currentUserStories.count != 0 {
            if let vc = UIStoryboard(name: "StoriesLoaded", bundle: nil).instantiateInitialViewController() as? StoriesLoadedViewController {
                
                if let currentUser = currentUser {
                    vc.profileID = currentUser
                }

                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                view.window?.layer.add(transition, forKey: kCATransition)
                vc.modalPresentationStyle = .fullScreen
                vc.view.window?.layer.add(transition, forKey: kCATransition)
                self.present(vc, animated: true, completion: nil)
            }
        }else {
            if let vc = UIStoryboard(name: "Stories", bundle: nil).instantiateInitialViewController() as? StoriesViewController {

                let transition = CATransition()
                transition.duration = 0.5
                transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromLeft
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                view.window?.layer.add(transition, forKey: kCATransition)
                vc.modalPresentationStyle = .fullScreen
                vc.view.window?.layer.add(transition, forKey: kCATransition)
                self.present(vc, animated: true, completion: nil)
            }
        }
       
    }
}
extension UIImage {

    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

    func resize(scaledToWidth desiredWidth: CGFloat) -> UIImage {
        let oldWidth = size.width
        let scaleFactor = desiredWidth / oldWidth

        let newHeight = size.height * scaleFactor
        let newWidth = oldWidth * scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)

        return resize(targetSize: newSize)
    }

    func resize(scaledToHeight desiredHeight: CGFloat) -> UIImage {
        let scaleFactor = desiredHeight / size.height
        let newWidth = size.width * scaleFactor
        let newSize = CGSize(width: newWidth, height: desiredHeight)

        return resize(targetSize: newSize)
    }
}
