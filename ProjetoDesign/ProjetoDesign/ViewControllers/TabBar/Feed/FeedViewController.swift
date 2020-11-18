//
//  FeedViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class FeedViewController: UIViewController, HeaderDelegate {
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
        postagem.append(PostUser(name: "Melissa ", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel1.jpeg",comments: "I just took a DNA test, turns out I'm 100% that bitch", allImages: ["mel2.jpg", "mel1.jpeg"]))
        postagem.append(PostUser(name: "Miles", city: "Vancouver, BC", imageProfile: "miles1.jpeg", imagePost: "miles0.jpeg",comments: "Needless to say, I keep her in check", allImages: ["miles0.jpeg", "gwen"]))

        
        currentUser.append(Profile(name: "Melissa", profileImage: "mel0.jpg", bio: ""))
        
        arrayCollection.append(stories(storieImageView: "gwen"))
        arrayCollection.append(stories(storieImageView: "miles1.jpeg"))
        arrayCollection.append(stories(storieImageView: "brendon.jpg"))
        arrayCollection.append(stories(storieImageView: "Connor"))
        
        feedTableView.reloadData()
        storieCollectionView.reloadData()
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
               self.feedTableView.reloadData()
            print("reload")
           }
    }
    func seeArray(){
        let searchValue = "Melissa"
        for item in postagem{
        if let i = postagem.firstIndex(where: { $0.name == "Melissa" }) {
            print("\(postagem[i].imagePost)")
            print(i)
            
        }
        }
        
    }
    func isDeveloping(){
        let alert = UIAlertController(title: "This option still under development", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        self.present(alert, animated: true, completion: nil)
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
            vc.modalPresentationStyle = .overFullScreen
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

    func didButtonPressed() {
        
        if let viewcontroller = UIStoryboard(name: "Comments", bundle: nil).instantiateInitialViewController() as? CommentsViewController{
            
            present(viewcontroller, animated: true, completion: nil)
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
        cell.setup(user: currentUser[indexPath.row])
        cell.teste()
        cell.delegate = self
        return cell
    }
    func doSomething() {
        isDeveloping()
    }
    
    
}


