//
//  editTextField.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import Foundation

import UIKit
@IBDesignable
open class customUITextField: UITextField {
    func setup() {
        let border = CALayer()
        let width = CGFloat(2.0)

        border.borderColor = UIColor.darkGray.cgColor

        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}
