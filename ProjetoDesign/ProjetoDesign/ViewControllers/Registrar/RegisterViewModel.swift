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

class RegisterViewModel: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    var ref: DatabaseReference!
    var register = RegistrarViewController()
    var imageSelected: UIImage?
    
    var uid = Auth.auth().currentUser?.uid
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
            imageSelected = chosenImage
            
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
    func registerNewUser(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if register.emailTextField.text! != nil && register.emailTextField.text! != "" && register.passwordTextField.text! != nil && register.passwordTextField.text! != "" && register.secureTextField.text! != nil && register.secureTextField.text! != "" {
            
            if register.passwordTextField.text == register.secureTextField.text {
                Auth.auth().createUser(withEmail: register.emailTextField.text!, password: register.passwordTextField.text!) { authResult, error in

                    if error != nil {
                        print("erro ao registrar")
                        
                    }else{
                        self.saveFIRData()
                        completionHandler(true,nil)
                    }
                }
            }
        }else {
            completionHandler(false,nil)
        }

    }
    func saveFIRData() {
        self.uploadImage(register.userImage.image!) { url in
            if url != nil {
                self.saveImage(name: "", profileURL: url!) { success in
                    if success != nil{
                        print("Yeah")
                    }
                }
            }
        }
    }
}
extension RegisterViewModel {
    func uploadImage(_ image:UIImage, completion: @escaping ((_ url: URL?) -> ())){
        let storageRef = Storage.storage().reference().child("\(register.nicknameTextField.text!).png")
        let imgData = register.userImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) {(metadata, error) in
            if error == nil{
                print("success")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else {
                print("error in save image")
                completion(nil)
            }
        }
    }
    func saveImage(name: String, profileURL:URL, completion: @escaping ((_ url: URL?) -> ())) {
        if let currentUserID = Auth.auth().currentUser?.uid{
            self.ref = Database.database().reference()
            let dict = ["Name": register.nameTextField.text!,"Email": register.emailTextField.text!, "profileUrl":profileURL.absoluteString,"UserID": currentUserID,"Nickname": register.nicknameTextField.text!, "Bio": "", "Followers": 0, "Following": 0] as [String: Any]
            ref.child("users").child(currentUserID).setValue(dict)
            
            self.setFollower()
            self.setFollowing()
        }
    }
    func setFollower(){
        if let currentUser = Auth.auth().currentUser?.uid{
            self.ref = Database.database().reference()
            let followers = ref.child("users").child(currentUser).child("followers")
            let dict = ["first": ""]
            followers.updateChildValues(dict)
    
        }
    }
    func setFollowing(){
        if let currentUser = Auth.auth().currentUser?.uid{
            self.ref = Database.database().reference()
            let following = ref.child("users").child(currentUser).child("following")
            let dict = ["first": ""]
            following.updateChildValues(dict)
    
        }
    }
}

