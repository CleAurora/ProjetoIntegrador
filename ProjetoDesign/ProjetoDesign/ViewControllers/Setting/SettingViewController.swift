//
//  SettingViewController.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 12/10/20.
//

import UIKit

final class SettingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var settingImageView: UIImageView!
    @IBOutlet var bioTextView: UITextView!
    @IBOutlet var nameTextView: UITextView!
    @IBOutlet var userNameTextView: UITextView!
    @IBOutlet var webSiteTextView: UITextView!
    var nickname = "@melissa"

    var userModel = ViewRequest()
    var profileView: editProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        self.title = "Edit Profile"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addTapped))
        
        settingImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
    }
    
    @objc func addTapped(){
        self.profileView = editProfileViewModel(userModel: userModel, view: self)
        profileView?.editProfile(completionHandler: { success, _ in
            if success {
                print("dados atualizados")
            }
        })
    }
    @IBAction func changePictureButtonTapped() {
        self.profileView = editProfileViewModel(userModel: userModel, view: self)
        userModel.loadData(completionHandler: { success, _ in
            if success {
              //  self.profileView?.changePictureButtonTapped()
            }
        })
        self.profileView?.changePictureButtonTapped()
    }

}
