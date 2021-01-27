//
//  RegisterViewModel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-03.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

import MaterialComponents.MaterialTextControls_FilledTextAreas
import MaterialComponents.MaterialTextControls_FilledTextFields
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields

final class RegisterViewModel: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    let ref: DatabaseReference = Database.database().reference()
    var register = RegistrarViewController()
    var imageSelected: UIImage?
    var uid: String? { Auth.auth().currentUser?.uid }

    init(view: RegistrarViewController) {
        self.register = view
    }

    @objc func click() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        register.present(imagePicker, animated: true, completion: nil)

   }
    func textFieldAppearance(){
        
        let estimatedFrame = self.register.nameTextField.frame
        let textField = MDCOutlinedTextField(frame: estimatedFrame)
        textField.setOutlineColor(.systemIndigo, for: .editing)
        textField.setOutlineColor(.lightGray, for: .normal)
        
        textField.setTextColor(.gray, for: .editing)
        textField.setFloatingLabelColor(.systemIndigo, for: .editing)
        textField.setFloatingLabelColor(.systemIndigo, for: .editing)
        
        textField.label.text = "Name"
        textField.sizeToFit()
        self.register.floatingView.addSubview(textField)
        
        let emailEstimatedFrame = self.register.emailTextField.frame
        let emailTextField = MDCOutlinedTextField(frame: emailEstimatedFrame)
        emailTextField.setOutlineColor(.systemIndigo, for: .editing)
        emailTextField.setOutlineColor(.lightGray, for: .normal)
        
        emailTextField.setTextColor(.gray, for: .editing)
        emailTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        emailTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        
        emailTextField.label.text = "Email"
        emailTextField.sizeToFit()
        self.register.floatingView.addSubview(emailTextField)
        
        let nickEstimatedFrame = self.register.nicknameTextField.frame
        let nickTextField = MDCOutlinedTextField(frame: nickEstimatedFrame)
        nickTextField.setOutlineColor(.systemIndigo, for: .editing)
        nickTextField.setOutlineColor(.lightGray, for: .normal)
        
        nickTextField.setTextColor(.gray, for: .editing)
        nickTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        nickTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        
        nickTextField.label.text = "Nickname"
        nickTextField.sizeToFit()
        self.register.floatingView.addSubview(nickTextField)
        
        let PasswordEstimatedFrame = self.register.passwordTextField.frame
        let passwordTextField = MDCOutlinedTextField(frame: PasswordEstimatedFrame)
        passwordTextField.setOutlineColor(.systemIndigo, for: .editing)
        passwordTextField.setOutlineColor(.lightGray, for: .normal)
        
        passwordTextField.setTextColor(.gray, for: .editing)
        passwordTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        passwordTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        
        passwordTextField.label.text = "Password"
        passwordTextField.sizeToFit()
        self.register.floatingView.addSubview(passwordTextField)
        
        let ConfirmEstimatedFrame = self.register.secureTextField.frame
        let confirmTextField = MDCOutlinedTextField(frame: ConfirmEstimatedFrame)
        confirmTextField.setOutlineColor(.systemIndigo, for: .editing)
        confirmTextField.setOutlineColor(.lightGray, for: .normal)
        
        confirmTextField.setTextColor(.gray, for: .editing)
        confirmTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        confirmTextField.setFloatingLabelColor(.systemIndigo, for: .editing)
        
        confirmTextField.label.text = "Confirm Password"
        confirmTextField.sizeToFit()
        self.register.floatingView.addSubview(confirmTextField)
        
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if  let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
        register.userImage.contentMode = .scaleAspectFill
        register.userImage.image = chosenImage
        imageSelected = chosenImage
    }

    register.dismiss(animated: true, completion: nil)
   }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        register.dismiss(animated: true, completion: nil)
    }

    func isDeveloping(){
        let alert = UIAlertController(title: "This option still under development", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        register.present(alert, animated: true, completion: nil)
    }

    func registerNewUser(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if register.emailTextField.text! != nil && register.emailTextField.text! != "" && register.passwordTextField.text! != nil && register.passwordTextField.text! != "" && register.secureTextField.text! != nil && register.secureTextField.text! != "" {

            if register.passwordTextField.text == register.secureTextField.text {
                Auth.auth().createUser(withEmail: register.emailTextField.text!, password: register.passwordTextField.text!) { authResult, error in
                    if error != nil {
                        completionHandler(false, error)
                    } else {
                        self.saveFIRData(completionHandler: completionHandler)
                    }
                }
            }
        } else {
            completionHandler(false, nil)
        }
    }

    func saveFIRData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        uploadImage(register.userImage.image!) { (url, error) in
            if url != nil {
                return self.saveImage(name: "", profileURL: url!) { (url, error) in
                    completionHandler(url != nil, error)
                }
            }

            completionHandler(false, error)
        }
    }
}
extension RegisterViewModel {
    func uploadImage(_ image:UIImage, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void){
        let storageRef = Storage.storage().reference().child("\(register.nicknameTextField.text!).png")
        let imgData = register.userImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) {(metadata, error) in
            if error == nil{
                print("success")
                storageRef.downloadURL(completion: { (url, error) in
                    completionHandler(url, nil)
                })
            }else {
                print("error in save image")
                completionHandler(nil, error)
            }
        }
    }

    func saveImage(name: String, profileURL:URL, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void) {
        if let currentUserID = uid {
            let dict: [String: Any] = [
                "Name": register.nameTextField.text!,
                "Email": register.emailTextField.text!,
                "profileUrl": profileURL.absoluteString,
                "UserID": currentUserID,
                "Nickname": register.nicknameTextField.text!,
                "Bio": "",
                "Followers": 0,
                "Following": 0,
                "followers": [
                    "first": " "
                ],
                "following": [
                    "first": " "
                ]
            ]

            ref.child("users").child(currentUserID).setValue(dict) { (error, _) in
                if let error = error {
                    return completionHandler(nil, error)
                }

                completionHandler(profileURL, nil)
            }
        }
    }
}
