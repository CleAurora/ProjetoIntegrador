//
//  infoPostViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-11.
//

import UIKit

class infoPostViewController: UIViewController {
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var settingsTableView: UITableView!
    var settingsArray = ["Report",  "Share to...", "Turn On Post Notifications", "Mute", "Unfollow"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        dismissButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        settingsTableView.reloadData()
        setupTable()
        
        // Do any additional setup after loading the view.
    }
    
    func setupTable(){
        settingsTableView.layer.cornerRadius = 16
    }
    func setupView(){
        view.backgroundColor = .clear
        view.isOpaque = false
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.checkAction))
        self.view.addGestureRecognizer(gesture)
    }
    @objc func checkAction(sender: UITapGestureRecognizer){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
extension infoPostViewController: UITableViewDelegate{
    
}
extension infoPostViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoPostTableCell
        cell.settingsLabel.text = settingsArray[indexPath.row]
        return cell
        
    }
    
    
}
