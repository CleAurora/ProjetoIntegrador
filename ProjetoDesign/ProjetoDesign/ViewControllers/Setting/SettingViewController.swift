//
//  SettingViewController.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 12/10/20.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        settingImageView.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
    }
}



