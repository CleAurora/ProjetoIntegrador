//
//  FeedViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var storieCollectionView: UICollectionView!
    
    var arrayTable = [Post]()
    var arrayCollection = [stories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollection()
        
        
        arrayTable.append(Post(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel2.jpg"))
        arrayTable.append(Post(name: "Brendon", city: "Los Angeles", imageProfile: "brendon.jpg", imagePost: "post1.jpg"))
        arrayTable.append(Post(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel1.jpeg"))
        arrayTable.append(Post(name: "Miles", city: "Vancouver, BC", imageProfile: "miles1.jpeg", imagePost: "miles0.jpeg"))
        
        arrayCollection.append(stories(storieImageView: "mel0.jpg"))
        arrayCollection.append(stories(storieImageView: "miles1.jpeg"))
        arrayCollection.append(stories(storieImageView: "brendon.jpg"))
        
        feedTableView.reloadData()
        storieCollectionView.reloadData()
        // Do any additional setup after loading the view.
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let arquive = arquiveAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [arquive])
    }
    func arquiveAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Arquive") {(action, view, completion) in
            
        }
        action.image = #imageLiteral(resourceName: "tag.png")
        action.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        return action
    }
    
}

extension FeedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(arrayTable[indexPath.row].imagePost)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedViewController: UITableViewDataSource{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //        //   get number of section
        var pathToLastRow: IndexPath
        var firstRow: IndexPath
        var secondRow: IndexPath
        
        let indexOfLastSection = self.feedTableView.numberOfSections - 1
        // Then get the number of rows in the last section
        if indexOfLastSection >= 0{
            let indexOfLastRow = self.feedTableView.numberOfRows(inSection: indexOfLastSection) - 1
            let indexOfSecondLastRow = self.feedTableView.numberOfRows(inSection: indexOfLastSection) - 2
            if indexOfLastRow >= 0{
                pathToLastRow = IndexPath.init(row: indexOfLastRow, section: indexOfLastSection)
                secondRow = IndexPath.init(row: indexOfSecondLastRow, section: indexOfLastSection)
                for cell in feedTableView.visibleCells {
                    let indexPath = feedTableView.indexPath(for: cell)
                    firstRow = IndexPath.init(row: 0, section: 0)
                    
                    
                    
                    if indexPath == firstRow{
                        
                        feedTableView.setContentOffset(.zero, animated: true)
                        break
                    }
                    if indexPath == secondRow {
                        feedTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
                        print("second last")
                        break
                    }
                    if indexPath != pathToLastRow || indexPath != firstRow{
                        feedTableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
                        print("here")
                        break
                        
                    }
                    
                    
                    if indexPath == pathToLastRow{
                        break
                    }
                    
                    
                    
                    
                    
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.setup(post: arrayTable[indexPath.row])
        return cell
    }
}
extension FeedViewController: UICollectionViewDelegate{
    
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
}
