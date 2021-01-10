//
//  RoundedImage.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//
import Foundation
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
    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width

            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}
