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
    var currentUser = [Profile]()
    var postagem = [PostUser]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollection()
        self.navigationController?.navigationBar.isHidden = true
        postagem.append(PostUser(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel2.jpg",comments: " Eu sou simplesmente apaixonada em misturar peças mais femininas com outras mais pesadas ou retas!", allImages: ["mel2.jpg", "mel1.jpeg"]))
        postagem.append(PostUser(name: "Brendon", city: "Los Angeles", imageProfile: "brendon.jpg", imagePost: "post1.jpg", comments: "I like it in the city when the air is so thick and opaque", allImages: ["post1.jpg", "gwen"]))
        postagem.append(PostUser(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel1.jpeg",comments: "I just took a DNA test, turns out I'm 100% that bitch", allImages: ["mel2.jpg", "mel1.jpeg"]))
        postagem.append(PostUser(name: "Miles", city: "Vancouver, BC", imageProfile: "miles1.jpeg", imagePost: "miles0.jpeg",comments: "Needless to say, I keep her in check", allImages: ["miles0.jpeg", "gwen"]))

        
        currentUser.append(Profile(name: "Melissa", profileImage: "mel0.jpg"))
        
        arrayCollection.append(stories(storieImageView: "gwen"))
        arrayCollection.append(stories(storieImageView: "miles1.jpeg"))
        arrayCollection.append(stories(storieImageView: "brendon.jpg"))
        seeArray()
        feedTableView.reloadData()
        storieCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    func seeArray(){
        let searchValue = "Melissa"
        print("fooooooooor")
     
       
        for item in postagem{
        if let i = postagem.firstIndex(where: { $0.name == "Miles" }) {
                print("\(postagem[i])")
            print(i)
                print("\(postagem[i].imagePost)")
        }
        }
        
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
    @IBAction func infoButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "InfoPost", bundle: nil).instantiateInitialViewController() as? infoPostViewController {
        vc.modalPresentationStyle = . overCurrentContext
            present(vc, animated: true, completion: nil)
            
        }
    }
}

extension FeedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postagem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.setup(post: postagem[indexPath.row])
        cell.delegate = self
        cell.nameTap = {
        if let viewcontroller = UIStoryboard(name: "User", bundle: nil).instantiateInitialViewController() as? UserViewController{
            viewcontroller.post = self.postagem[indexPath.row]
        self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
        return cell
    }
}
extension FeedViewController: ButtonsTableView{

    func didButtonPressed() {
        
        if let viewcontroller = UIStoryboard(name: "Comments", bundle: nil).instantiateInitialViewController() as? CommentsViewController{
        
            present(viewcontroller, animated: true, completion: nil)
    }
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

    func collectionView(_ collectionView: UICollectionView,viewForSupplementaryElementOfKind kind: String,at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "currentCell", for: indexPath) as! StoriesReusableView
        cell.setup(user: currentUser[indexPath.row])
        return cell
    }
}

