//
//  LegendViewController.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 21/10/20.
//

import UIKit

class LegendViewController: UIViewController {
    @IBOutlet weak var imageSelected: UIImageView!

    @IBOutlet weak var legendTextField: UITextField!

    @IBOutlet weak var postButton: RoundedButton!
    
    @IBOutlet weak var localSwitch: UISwitch!

    @IBOutlet weak var weatherSwitch: UISwitch!

    var upload: Upload?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let upload = upload {
            imageSelected.image = UIImage(named: upload.image)
        }

        imageSelected.layer.maskedCorners = CACornerMask(
            rawValue: UIRectCorner(
                [UIRectCorner.bottomLeft, UIRectCorner.bottomRight]
            ).rawValue
        )
        postButton.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func postButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
