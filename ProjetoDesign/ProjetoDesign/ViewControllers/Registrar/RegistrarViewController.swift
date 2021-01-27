//
//  RegistrarViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

final class RegistrarViewController: UIViewController{

    // MARK: - IBOutlets
    @IBOutlet weak var registerView: extensions!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet var emailTextField: CustomOutlinedTxtField!
    @IBOutlet var passwordTextField: CustomOutlinedTxtField!
    @IBOutlet var secureTextField: CustomOutlinedTxtField!
    @IBOutlet var nameTextField: CustomOutlinedTxtField!
    @IBOutlet var nicknameTextField: CustomOutlinedTxtField!
    @IBOutlet var floatingView: extensions!
    
    // MARK: - Proprierts

    private lazy var viewModel: RegisterViewModel = RegisterViewModel(view: self)

    // MARK: - Super Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.backgroundColor = UIColor(patternImage: UIImage(named: "borderButton")!)

        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        viewModel.textFieldAppearance()
       
    }

    @IBAction func imageviewButton(_ sender: Any) {
        viewModel.click()
    }

    // MARK: - IBActions

    @IBAction func registerButton(_ sender: Any) {
        viewModel.registerNewUser { success, _ in
            if success {
                if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? SHCircleBarController{
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }

    @IBAction func instagramButton(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    
    }

    @IBAction func facebookButton(_ sender: Any) {
        viewModel.isDeveloping()
    }
}
