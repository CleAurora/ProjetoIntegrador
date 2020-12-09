//
//  ResizeImage.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-07.
//
import UIKit
import Foundation
public class AdjustsViewBoundsImageView: UIImageView {

   /// The maximum width that you want this imageView to grow to.
   @objc dynamic var maxWidth: CGFloat = 0 {
      didSet {
         invalidateIntrinsicContentSize()
      }
   }

   /// The maximum height that you want this imageView to grow to.
   @objc dynamic var maxHeight: CGFloat = 0 {
      didSet {
         invalidateIntrinsicContentSize()
      }
   }

   private var maxAspectRatio: CGFloat { return maxWidth / maxHeight }

   override public var intrinsicContentSize: CGSize {
      guard let classImage = self.image else { return super.intrinsicContentSize }
      if maxHeight == 0 || maxWidth == 0 {
         return super.intrinsicContentSize
      }

      let imageWidth = classImage.size.width
      let imageHeight = classImage.size.height
      let aspectRatio = imageWidth / imageHeight

      // Width is greater than height, return max width image and new height.
      if imageWidth > imageHeight {
         let newHeight = maxWidth/aspectRatio
         return CGSize(width: maxWidth, height: newHeight)
      }

      // Height is greater than width, return max height and new width.
      if imageHeight > imageWidth {
         // If the aspect ratio is larger than our max ratio, then using max width
         // will be hit before max height.
         if aspectRatio > maxAspectRatio {
            let newHeight = maxWidth/aspectRatio
            return CGSize(width: maxWidth, height: newHeight)
         }
         let newWidth = maxHeight * aspectRatio
         return CGSize(width: newWidth, height: maxHeight)
      }

      // Square image, return the lesser of max width and height.
      let squareMinimumValue = min(maxWidth, maxHeight)
      return CGSize(width: squareMinimumValue, height: squareMinimumValue)
   }
}
