//
//  RegistrarViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class RegistrarViewController: UIViewController{
    
    // MARK: - IBOutlets
    @IBOutlet weak var registerView: extensions!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    // MARK: - Proprierts
    var viewModel: RegisterViewModel?
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
    }
    
    @IBAction func imageviewButton(_ sender: Any) {
        self.viewModel = RegisterViewModel(view: self)
        viewModel?.click()
    }
    // MARK: - IBActions 
    @IBAction func registerButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? TabbarController{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func instagramButton(_ sender: Any) {
        self.viewModel = RegisterViewModel(view: self)
        viewModel?.isDeveloping()
    }
    @IBAction func facebookButton(_ sender: Any) {
        self.viewModel = RegisterViewModel(view: self)
        viewModel?.isDeveloping()
    }
}
