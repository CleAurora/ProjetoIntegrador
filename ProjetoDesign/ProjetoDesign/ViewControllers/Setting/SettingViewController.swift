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
    var nickname = "@melissa"
    
    var userModel = ViewRequest()
    var profileView: editProfileViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        settingImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
    }
    

    @IBAction func changePictureButtonTapped() {
        self.profileView = editProfileViewModel(userModel: userModel, view: self)
        userModel.loadData(completionHandler: { success, _ in
            if success {
                self.profileView?.changePictureButtonTapped()
            }
        })
    }

}



