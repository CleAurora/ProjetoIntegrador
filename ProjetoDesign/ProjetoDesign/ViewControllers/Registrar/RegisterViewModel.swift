//
//  RegisterViewModel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-03.
//

import Foundation
import UIKit
class RegisterViewModel: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    var register = RegistrarViewController()
    
    init(view: RegistrarViewController) {
        self.register = view
    }
    
    @objc func click()
       {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        register.present(imagePicker, animated: true, completion: nil)
        
       }
       @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if  let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
            register.userImage.contentMode = .scaleAspectFill
            register.userImage.image = chosenImage
            
           }
        register.dismiss(animated: true, completion: nil)
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        register.dismiss(animated: true, completion: nil)
       }
    
    func isDeveloping(){
        let alert = UIAlertController(title: "This option still under development", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        register.present(alert, animated: true, completion: nil)
    }
}
