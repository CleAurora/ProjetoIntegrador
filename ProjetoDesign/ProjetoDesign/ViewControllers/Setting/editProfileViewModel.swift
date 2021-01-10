//
//  editProfileViewModel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-04.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
class editProfileViewModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var userModel = ViewRequest()
    var view = SettingViewController()
    var ref: DatabaseReference!

    init(userModel: ViewRequest, view: SettingViewController) {
        self.userModel = userModel
        self.view = view
    }
    
    func changePictureButtonTapped(){
            let imagePicker = UIImagePickerController()

            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.delegate = self

            view.present(imagePicker, animated: true, completion: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            view.settingImageView.contentMode = .scaleAspectFill
            view.settingImageView.image = chosenImage
        }
        saveFIRData()
        view.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        view.dismiss(animated: true, completion: nil)
    }

    func saveFIRData() {
        self.uploadImage(view.settingImageView.image!) { url in
            if url != nil {
                self.saveImage(name: "", profileURL: url!) { success in
                    if success != nil{
                    }
                }
            }
        }
    }
}
extension editProfileViewModel {
    func uploadImage(_ image:UIImage, completion: @escaping ((_ url: URL?) -> ())){
        let storageRef = Storage.storage().reference().child("\(view.nickname).png")
        let imgData = view.settingImageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) {(metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else {
                completion(nil)
            }
        }
    }
    func saveImage(name: String, profileURL:URL, completion: @escaping ((_ url: URL?) -> ())) {
        if let currentUserID = Auth.auth().currentUser?.uid{
            self.ref = Database.database().reference()
            let dict = ["profileUrl":profileURL.absoluteString] as [String: Any]
            ref.child("users").child(currentUserID).updateChildValues(dict)

        }
    }
    
    func editProfile(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        if let currentUserID = Auth.auth().currentUser?.uid{
            self.ref = Database.database().reference()
            let dict = ["Bio": view.bioTextView.text, "Name": view.nameTextView.text, "Website": view.webSiteTextView.text, "Nickname": view.userNameTextView.text]
            ref.child("users").child(currentUserID).updateChildValues(dict)
        }
    }
}
