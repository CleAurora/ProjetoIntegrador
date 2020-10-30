//
//  RoundedTextField.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-27.
//

import Foundation
import UIKit

@IBDesignable
class RoundedTextField: UIView {

    @IBInspectable var placeholder: String = "" {
        didSet {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        }
    }

    let textField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func prepareForInterfaceBuilder() {
        commonInit()
    }

    func commonInit() -> Void {

        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.masksToBounds = true

        addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 12.0),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            ])

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height * 0.5
    }

}
