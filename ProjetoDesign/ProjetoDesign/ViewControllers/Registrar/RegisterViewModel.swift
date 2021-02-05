//
//  RegisterViewModel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-03.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

protocol RegisterViewModelProtocol {
    func click()
    func textFieldAppearance()
    func registerNewUser(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void)
}

final class RegisterViewModel: NSObject, RegisterViewModelProtocol, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private let ref: DatabaseReference = Database.database().reference()
    private weak var register: RegistrarViewController?
    private var imageSelected: UIImage?
    private var uid: String? { Auth.auth().currentUser?.uid }

    // MARK: - Initializer

    init(viewController: RegistrarViewController) {
        register = viewController
    }

    // MARK: - RegisterViewModelProtocol conforms

    func click() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self

        register?.present(imagePicker, animated: true, completion: nil)
    }

    func textFieldAppearance() {
        if let register = register {
            register.nameTextField.textField.placeholderLabel.text = "Name"
            register.emailTextField.textField.placeholderLabel.text = "Email"

            register.nicknameTextField.textField.placeholderLabel.text = "Nickname"
            register.passwordTextField.textField.placeholderLabel.text = "Password"
            register.passwordTextField.textField.isSecureTextEntry = true
            register.passwordTextField.textField.textContentType = .oneTimeCode
            register.secureTextField.textField.placeholderLabel.text = "Confirm Password"
            register.secureTextField.textField.textContentType = .oneTimeCode
            register.secureTextField.textField.isSecureTextEntry = true
        }
    }

    func registerNewUser(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        guard let register = register else {
            return completionHandler(false, NSError(domain: #function, code: 0, userInfo: [:]))
        }

        if register.emailTextField.textField.text != nil && register.emailTextField.textField.hasText && register.passwordTextField.textField.text != nil && register.passwordTextField.textField.hasText && register.secureTextField.textField.text != nil && register.secureTextField.textField.hasText {

            if register.passwordTextField.textField.text! == register.secureTextField.textField.text! {
                Auth.auth().createUser(withEmail: register.emailTextField.textField.text!, password: register.passwordTextField.textField.text!) { authResult, error in
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

    // MARK: - UIImagePickerControllerDelegate conforms

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if  let chosenImage = info[.originalImage] as? UIImage {
            register?.userImage.contentMode = .scaleAspectFill
            register?.userImage.image = chosenImage
            imageSelected = chosenImage
        }

        register?.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        register?.dismiss(animated: true, completion: nil)
    }

    // MARK: - Private functions

    private func saveFIRData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        guard let register = register else {
            return completionHandler(false, NSError(domain: #function, code: 0, userInfo: [:]))
        }

        uploadImage(register.userImage.image!) { (url, error) in
            if url != nil {
                return self.saveImage(name: "", profileURL: url!) { (url, error) in
                    completionHandler(url != nil, error)
                }
            }

            completionHandler(false, error)
        }
    }

    private func uploadImage(_ image:UIImage, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void){
        guard let register = register else {
            return completionHandler(nil, NSError(domain: #function, code: 0, userInfo: [:]))
        }

        let storageRef = Storage.storage().reference().child("\(register.nicknameTextField.textField.text!).png")
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

    private func saveImage(name: String, profileURL:URL, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void) {
        guard let register = register else {
            return completionHandler(nil, NSError(domain: #function, code: 0, userInfo: [:]))
        }

        if let currentUserID = uid {
            let dict: [String: Any] = [
                "Name": register.nameTextField.textField.text!,
                "Email": register.emailTextField.textField.text!,
                "profileUrl": profileURL.absoluteString,
                "UserID": currentUserID,
                "Nickname": register.nicknameTextField.textField.text!,
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
