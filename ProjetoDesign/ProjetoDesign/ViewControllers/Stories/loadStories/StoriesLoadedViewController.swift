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
    
    
    @IBOutlet var backgroundSegmented: UIView!
    @IBOutlet var storiesCollectionView: UICollectionView!
    @IBOutlet var xibProgressView: SegmentedProgressView!
    //@IBOutlet weak var xibProgressView: SegmentedProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        storiesCollectionView.reloadData()
        
        items = []
        for _ in 0...1 {
            items.append(ProgressItem(withDuration: 3))
        }
        xibProgressView.delegate = self
       
        xibProgressView.progressTintColor = UIColor(red: 180/255.0, green: 124/255.0, blue: 255/255.0, alpha: 1.0)
       // xibProgressView.progressTintColor = UIColor(red: 124/255.0, green: 77/255.0, blue: 255/255.0, alpha: 1.0)
        xibProgressView.trackTintColor = UIColor(red: 237/255.0, green: 231/255.0, blue: 246/255.0, alpha: 1.0)
        xibProgressView.itemSpace = 6.0
        xibProgressView.items = items
        
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoriesLoaded", for: indexPath) as! StoriesLoadedCollectionViewCell
        return cell
    }
}
