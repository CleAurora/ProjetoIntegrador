//
//  ViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var buttonImageView: extensions!
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "2.jpg")
        buttonImageView.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        setupView()
    }
    func setupView(){
        loginView.layer.shadowPath = UIBezierPath(rect: loginView.bounds).cgPath
        loginView.layer.shadowRadius = 15
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowOpacity = 1
    }
    @IBAction func loginButton(_ sender: Any) {
       
        if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? TabbarController{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
       
    }
    @IBAction func registerButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Registrar", bundle: nil).instantiateInitialViewController() as? RegistrarViewController {
            present(vc, animated: true, completion: nil)
        }
    }
    

}

