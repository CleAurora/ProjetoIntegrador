//
//  BorderImage.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import Foundation
import UIKit

class BorderView: UIView{
    @IBInspectable var borderWidth: CGFloat = 0.0{

        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clear {

        didSet {

            self.layer.borderColor = borderColor.cgColor

        }
    }

    override func prepareForInterfaceBuilder() {

        super.prepareForInterfaceBuilder()
    }

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
               return self.layer.cornerRadius
           }
           set {
               self.layer.cornerRadius = newValue

               // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
               if shadow == false {
                   self.layer.masksToBounds = true
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
}
