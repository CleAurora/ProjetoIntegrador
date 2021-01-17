//
//  ViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var googleButtonTapped: GIDSignInButton!
    @IBOutlet weak var faceButtonTapped: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    var loginModel: LoginViewModel?
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "login2")
        backgroundImageView.layer.maskedCorners = CACornerMask(rawValue: UIRectCorner([.bottomLeft, .bottomRight]).rawValue)
        loginButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        
        googleButtonTapped.isHidden = true
        
        setupView()
        setupUI()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

    }
    override func viewDidAppear(_ animated: Bool) {
        self.loginModel = LoginViewModel(view: self)
        loginModel?.isAlreadyLogged(completionHandler: { success, _ in
            if success {
                if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? SHCircleBarController{
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
    }

    func setupUI(){
        self.loginModel = LoginViewModel(view: self)
        self.loginButton.setTitle(loginModel?.titleBtnLogin, for: .normal )
        self.registerButton.setTitle(loginModel?.titleBtnRegister, for: .normal)
        self.faceButtonTapped.setImage(UIImage(named: loginModel!.imageBtnFaceBook), for: .normal)
    }

    // MARK: - Methods
    func setupView(){
        loginView.layer.shadowPath = UIBezierPath(rect: loginView.bounds).cgPath
        loginView.layer.shadowRadius = 15
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowOpacity = 1
    }

    // MARK: - IBActions

    @IBAction func loginButton(_ sender: Any) {
        self.loginModel = LoginViewModel(view: self)
        loginModel?.doLogin(completionHandler: { success, _ in
            if success {
                if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? SHCircleBarController{
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
    }

    @IBAction func registerButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Registrar", bundle: nil).instantiateInitialViewController() as? RegistrarViewController {
            present(vc, animated: true, completion: nil)
        }
    }

    @IBAction func faceButtonTapped(_ sender: Any) {
        
    }

    @IBAction func googleButtonTapped(_ sender: Any) {
        print("pressionado")
        GIDSignIn.sharedInstance()?.signIn()
    }

    private func showUnderDevelopment(){
        let alert = UIAlertController(
            title: "This option still under development", message: nil, preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }

}
