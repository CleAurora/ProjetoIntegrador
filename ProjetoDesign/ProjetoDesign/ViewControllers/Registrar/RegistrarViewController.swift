//
//  RegistrarViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

final class RegistrarViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var registerView: extensions!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var emailTextField: CustomOutlinedTxtField!
    @IBOutlet weak var passwordTextField: CustomOutlinedTxtField!
    @IBOutlet weak var secureTextField: CustomOutlinedTxtField!
    @IBOutlet weak var nameTextField: CustomOutlinedTxtField!
    @IBOutlet weak var nicknameTextField: CustomOutlinedTxtField!
    @IBOutlet weak var floatingView: extensions!
    
    // MARK: - Proprierts

    lazy var viewModel: RegisterViewModelProtocol = RegisterViewModel(viewController: self)

    // MARK: - Super Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - IBActions

    @IBAction private func imageviewButton(_ sender: Any) {
        viewModel.click()
    }

    @IBAction private func registerButton(_ sender: Any) {
        viewModel.registerNewUser { [self] success, _ in
            if success {
                if let viewController = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() {
                    viewController.modalPresentationStyle = .fullScreen
                    present(viewController, animated: true, completion: nil)
                }
            }
        }
    }

    // MARK: - Private functions

    private func setupView() {
        registerView.backgroundColor = UIColor(patternImage: UIImage(named: "borderButton")!)
        viewModel.textFieldAppearance()
    }
}
