//
//  SignInViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import FirebaseAuth

final class SignInViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var faceButtonTapped: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - Private constants & variables

    private lazy var loginModel: LoginViewModel = LoginViewModel(view: self)
    private lazy var signInViewModel = SignInViewModel.shared

    // MARK: - Super Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "login2")
        backgroundImageView.layer.maskedCorners = CACornerMask(rawValue: UIRectCorner([.bottomLeft, .bottomRight]).rawValue)
        loginButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)

        setupView()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        signInViewModel.set(presentingViewController: self)
    } 

    func setupUI(){
        loginButton.setTitle(loginModel.titleBtnLogin, for: .normal )
        registerButton.setTitle(loginModel.titleBtnRegister, for: .normal)
        faceButtonTapped.setImage(UIImage(named: loginModel.imageBtnFaceBook), for: .normal)
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
        loginModel.doLogin { [self] success, _ in
            if success {
                redirectToLoggedArea()
            }
        }
    }

    private func redirectToLoggedArea() {
        if let tabBarController = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() {
            UIApplication.shared.keyWindow?.rootViewController = tabBarController
        }
    }

    @IBAction func registerButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Registrar", bundle: nil).instantiateInitialViewController() as? RegistrarViewController {
            present(vc, animated: true, completion: nil)
        }
    }

    @IBAction func faceButtonTapped(_ sender: Any) {
    }

    @IBAction func googleButtonTapped(_ sender: Any) {
        signInViewModel.signInWithGoogle()
    }

    private func showUnderDevelopment(){
        let alert = UIAlertController(
            title: "This option still under development", message: nil, preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }

}
