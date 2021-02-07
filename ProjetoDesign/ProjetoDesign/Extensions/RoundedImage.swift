//
//  RoundedImage.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//


import UIKit

class roundImageView: UIImageView {

    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue

            if shadow == false {
                layer.masksToBounds = true
            }
        }
    }

    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }

    override var intrinsicContentSize: CGSize {
        guard let image = image else {
            return CGSize(width: -1.0, height: -1.0)
        }

        let myImageWidth = image.size.width
        let myImageHeight = image.size.height
        let myViewWidth = frame.size.width

        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio

        return CGSize(width: myViewWidth, height: scaledHeight)
    }
}
