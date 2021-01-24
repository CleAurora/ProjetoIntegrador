//
//  StoriesLoadedViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-18.
//

import UIKit
import SegmentedProgressView

class StoriesLoadedViewController: UIViewController, ProgressBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    var items: [ProgressItem] = []
    var storiesRequest = StoriesDownload()
    
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
          
         // items = []
          
          //getStories()
        
    }
    func getStories(){
        if let userID = storiesUser?.userID, let name = storiesUser?.name, let image = storiesUser?.profileUrl {
            
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
        //let cellSize = view.frame.size

        //get current content Offset of the Collection view
        let contentOffset = storiesCollectionView.contentOffset

        if storiesCollectionView.contentSize.width <= storiesCollectionView.contentOffset.x + cellSize.width
        {
            //WIP
//            let r = CGRect(x: 0, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
//            storiesCollectionView.scrollRectToVisible(r, animated: true)
            
            dismiss(animated: true, completion: nil)
            
        } else {
            let r = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
            storiesCollectionView.scrollRectToVisible(r, animated: true);
        }
    }

    func progressSetup(){
        //WIP
//        for _ in storiesRequest.storiesData{
//
//            items.append(ProgressItem(withDuration: 3))
//            print(items.count)
//        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesRequest.storiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesLoaded", for: indexPath) as! StoriesLoadedCollectionViewCell
        cell.setup(stories: storiesRequest.storiesData[indexPath.row])
        return cell
    }
}
