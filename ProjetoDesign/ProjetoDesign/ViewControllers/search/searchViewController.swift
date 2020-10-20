//
//  searchViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class searchViewController: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var userSearchView: UISearchBar!
    var searchIn = ""
    var userArray = [Post]()
    var filteredArray = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        userArray.append(Post(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel2.jpg"))
        userArray.append(Post(name: "Brendon", city: "Los Angeles", imageProfile: "brendon.jpg", imagePost: "post1.jpg"))
        userArray.append(Post(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "mel1.jpeg"))
        userArray.append(Post(name: "Miles", city: "Vancouver, BC", imageProfile: "miles1.jpeg", imagePost: "miles0.jpeg"))
        filteredArray = userArray
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        userSearchView.delegate = self
        // Do any additional setup after loading the view.
    }
    func filter() {
        if searchIn.isEmpty {
            searchIn = ""
        }else{
            
            let searchText = searchIn.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil)
            filteredArray = userArray.filter({(name) -> Bool in
                let canAppear = true

                return canAppear
            })
            .filter({(name) -> Bool in
                if searchText.isEmpty {
                    return true
                }
                return name.name.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: nil).contains(searchText)
            })
            
        }
        searchTableView.reloadData()
    }
}
extension searchViewController: UITableViewDelegate{
    
}
extension searchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableCell
        cell.setup(user: filteredArray[indexPath.row])
        return cell
    }
}
extension searchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchIn = searchText
        print(searchIn)
        filter()
    }
    
}
