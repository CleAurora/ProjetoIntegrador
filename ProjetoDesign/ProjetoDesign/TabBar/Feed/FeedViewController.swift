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
    var arrayCollection = ["Teste","Teste","Teste","Teste"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollection()
        arrayTable.append(Post(name: "Brendon", city: "Los Angeles", imageProfile: "brendon.jpg", imagePost: "post1.jpg"))
        feedTableView.reloadData()
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
        return cell
    }
}
