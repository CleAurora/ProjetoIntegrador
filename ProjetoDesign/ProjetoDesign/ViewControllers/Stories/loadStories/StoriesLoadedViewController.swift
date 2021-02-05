//
//  StoriesLoadedViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-18.
//

import UIKit
import SegmentedProgressView
import Firebase
class StoriesLoadedViewController: UIViewController, ProgressBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
 
    var items: [ProgressItem] = []
    var storiesRequest = StoriesDownload()
    var profileID: Profile?
    @IBOutlet var backgroundSegmented: UIView!
    @IBOutlet var storiesCollectionView: UICollectionView!
    @IBOutlet var xibProgressView: SegmentedProgressView!
    
    var images: [UIImage] = []
    var storiesUser: Usuario?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
          storiesCollectionView.delegate = self
          storiesCollectionView.dataSource = self
          storiesCollectionView.reloadData()
    }
    
    func getStories(){
        if let userID = storiesUser?.userID ?? profileID?.uid , let name = storiesUser?.name ?? profileID?.name, let image = storiesUser?.profileUrl ?? profileID?.profileImage {
            
            storiesRequest.downloadStories(User: userID, UserName: name, UserProfile: image, completionHandler: { success, _ in
                if success {
                   self.progressSetup()
                }
            })
        }
    }
    
    func startTimer() {

        let timer =  Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextCell(){

        //get cell size
        let cellSize = storiesCollectionView.frame.size

        //get current content Offset of the Collection view
        let contentOffset = storiesCollectionView.contentOffset

        if storiesCollectionView.contentSize.width <= storiesCollectionView.contentOffset.x + cellSize.width
        {

        } else {
            let r = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
            storiesCollectionView.scrollRectToVisible(r, animated: true);
        }
    }

    func progressSetup(){
        
        items.append(ProgressItem(withDuration: 3))
        xibProgressView.delegate = self
       
        xibProgressView.progressTintColor = UIColor(red: 180/255.0, green: 124/255.0, blue: 255/255.0, alpha: 1.0)
        xibProgressView.trackTintColor = UIColor(red: 237/255.0, green: 231/255.0, blue: 246/255.0, alpha: 1.0)
        xibProgressView.itemSpace = 6.0
        xibProgressView.items = items
        
        startTimer()
        storiesCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func progressBar(willDisplayItemAtIndex index: Int) {
        print("willDisplayItemAtIndex \(index)")
    }
    
    func progressBar(didDisplayItemAtIndex index: Int) {
        print("didDisplayItemAtIndex \(index)")
    }
    @IBAction func closedButton(_ sender: Any) {
     
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addNewStories(_ sender: Any) {
        let uid = Auth.auth().currentUser?.uid
        if uid == profileID?.uid {
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesRequest.storiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesLoaded", for: indexPath) as! StoriesLoadedCollectionViewCell
        cell.setup(stories: storiesRequest.storiesData[indexPath.row])

        return cell
    }
    
}
