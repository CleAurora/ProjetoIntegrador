//
//  imagepickViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-11-22.
//

import UIKit
import Photos
class imagepickViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
           @IBOutlet weak var userImage: UIImageView!

        override func viewDidLoad() {
                   super.viewDidLoad()
                    imagePicker.delegate = self
                   let tap = UITapGestureRecognizer(target: self, action: #selector(imagepickViewController.click))
                   userImage.addGestureRecognizer(tap)
                   userImage.isUserInteractionEnabled = true
               }

               @objc func click()
               {
                   imagePicker.allowsEditing = false
                   imagePicker.sourceType = .photoLibrary
                   present(imagePicker, animated: true, completion: nil)
               }


               @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                if  let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
                   userImage.contentMode = .scaleAspectFit
                   userImage.image = chosenImage
                   }
                   dismiss(animated: true, completion: nil)
               }

               func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                   dismiss(animated: true, completion: nil)
               }
}
