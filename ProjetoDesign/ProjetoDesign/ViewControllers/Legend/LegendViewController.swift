//
//  LegendViewController.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 21/10/20.
//

import UIKit

class LegendViewController: UIViewController {
    @IBOutlet weak var imageSelected: UIImageView!

    @IBOutlet weak var legendTextField: UITextField!

    @IBOutlet weak var postButton: RoundedButton!
    
    @IBOutlet weak var localSwitch: UISwitch!

    @IBOutlet weak var weatherSwitch: UISwitch!

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!

    var upload: Upload?
    var postagem = [PostUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let upload = upload {
            imageSelected.image = UIImage(named: upload.image)
        }

        imageSelected.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
        postButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    func infoText(){
        if let image = upload?.image {
            if let tabBarController = tabBarController, let viewControllers = tabBarController.viewControllers,
               let navController = viewControllers.first as? UINavigationController,
               let feedViewController = navController.viewControllers.first as? FeedViewController {
                tabBarController.selectedIndex = 0
                feedViewController.postagem.insert(PostUser(name: "Melissa", city: "Toronto, ON", imageProfile: "mel0.jpg", imagePost: "\(image)", comments: legendTextField.text ?? "", allImages: ["",""]), at: 0)
                feedViewController.feedTableView.reloadData()
            }
           
            navigationController?.popViewController(animated: true)
          
            
        }
      
    }
    @IBAction func postButtonTapped() {
       // navigationController?.popViewController(animated: true)
        infoText()
    }

    @IBAction func localSwitchChanged(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.6) {
            self.localLabel.isHidden = !sender.isOn
        }
    }

    @IBAction func weatherSwitchChanged(_ sender: UISwitch) {
        UIView.animate(withDuration: 0.6) {
            self.weatherLabel.isHidden = !sender.isOn
        }
    }
}
