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

    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loginView: UIView!
    @IBOutlet private weak var faceButtonTapped: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    // MARK: - Lazy variables

    lazy var loginModel: LoginViewModelProtocol = LoginViewModel()
    lazy var signInViewModel: SignInViewModelProtocol = SignInViewModel.shared

    // MARK: - Super Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        signInViewModel.set(presentingViewController: self)
    }

    // MARK: - IBActions functions

    @IBAction private func loginButton(_ sender: Any) {
        loginModel.doLogin(email: emailTextField.text, password: passwordTextField.text) { [self] result in
            if let success = try? result.get(), success {
                redirectToLoggedArea()
            }
        }
    }

    @IBAction private func registerButton(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Registrar", bundle: nil).instantiateInitialViewController() {
            present(viewController, animated: true, completion: nil)
        }
    }

    @IBAction private func faceButtonTapped(_ sender: Any) {
        signInViewModel.signInWithFacebook(on: self)
    }

    @IBAction private func googleButtonTapped(_ sender: Any) {
        signInViewModel.signInWithGoogle()
    }

    // MARK: - Private functions

    private func redirectToLoggedArea() {
        if let tabBarController = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() {
            UIApplication.shared.keyWindow?.rootViewController = tabBarController
        }
    }

    private func setupUI() {
        loginButton.setTitle(loginModel.titleBtnLogin, for: .normal )
        registerButton.setTitle(loginModel.titleBtnRegister, for: .normal)
        faceButtonTapped.setImage(UIImage(named: loginModel.imageBtnFaceBook), for: .normal)
    }

    private func setupView() {
        backgroundImageView.image = UIImage(named: "login2")
        backgroundImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner([.bottomLeft, .bottomRight]).rawValue
        )

        loginButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)

        loginView.layer.shadowPath = UIBezierPath(rect: loginView.bounds).cgPath
        loginView.layer.shadowRadius = 15
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowOpacity = 1
    }
}
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
}
