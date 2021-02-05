//
//  StoriesViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2021-01-17.
//

import UIKit
import AVFoundation
import SwiftyCam
import FirebaseStorage
import FirebaseAuth
import Firebase
import PKHUD
class StoriesViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, SwiftyCamViewControllerDelegate {
    
    let ref: DatabaseReference = Database.database().reference()
    
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var switchCameraButton: UIButton!
    @IBOutlet var sendToView: extensions!
    @IBOutlet var GaleriaButton: UIButton!
    @IBOutlet var sendToButton: UIButton!
    @IBOutlet var storieImageView: UIImageView!
    var isImageSelected: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendToButton.isHidden = true
        sendToView.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let captureButton = SwiftyCamButton(frame: recordButton.frame)
           // captureButton.delegate = self
           // defaultCamera = .front
            if storieImageView == nil {
                openCamera()
            }else {
                //do not open camera
            }
        }else{
            if isImageSelected == true {

            }else{
                noCamera()
            }
        }
    }
    
    func openCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func switchCameraButton(_ sender: Any) {
        //switchCamera()
    }
    @IBAction func recordButton(_ sender: Any) {
       // takePhoto()
    }
    @IBAction func sendTo(_ sender: Any) {
        HUD.show(.progress)
        self.saveFIRData(completionHandler: { success, _ in
            if success {
                HUD.hide()
                self.closeLeftToRight()
            }
        })
    }
    
    func noCamera(){
        let alert = UIAlertController(title: "We could not access your camera", message: "anyhow you can access your Photos and share it", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true, completion: nil)
    }
    @IBAction func GaleriaButton(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    if  let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
        storieImageView.contentMode = .scaleAspectFill
        storieImageView.image = chosenImage
        storieImageView.image = chosenImage
    }
        GaleriaButton.isHidden = true
        switchCameraButton.isHidden = true
        sendToButton.isHidden = false
        sendToView.isHidden = false
        recordButton.isHidden = true
        
        isImageSelected = true
        dismiss(animated: true, completion: nil)
   }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closedButton(_ sender: Any) {
        closeLeftToRight()
    }
    
    func closeLeftToRight(){
        if let presentedVC = presentedViewController {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            presentedVC.view.window!.layer.add(transition, forKey: kCATransition)
        }
        
        dismiss(animated: false, completion: nil)
        
    }
    
    func saveFIRData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        uploadImage(storieImageView.image!) { (url, error) in
            if url != nil {
                return self.saveImage(name: "", profileURL: url!) { (url, error) in
                    completionHandler(url != nil, error)
                }
            }
            completionHandler(false, error)
        }
    }
    func uploadImage(_ image:UIImage, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void){
        let newChild = ref.childByAutoId()
        let storageRef = Storage.storage().reference().child("\(newChild).png")
        let imgData = storieImageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) {(metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completionHandler(url, nil)
                })
            }else {
                completionHandler(nil, error)
            }
        }
    }
    func saveImage(name: String, profileURL:URL, completionHandler: @escaping (_ result: URL?, _ error: Error?) -> Void) {
        let uid = Auth.auth().currentUser?.uid
        if let currentUserID = uid {
            
            let reference = ref.child("stories").childByAutoId()
            
            let dict: [String: Any] = [
                "userID": uid,
                "TimeStamp": Date().timeIntervalSince1970,
                "StorieImage": profileURL.absoluteString,
                "Duration": 86400,
                "childID": reference.key
            ]
                reference.updateChildValues(dict) { (error, _) in
                if let error = error {
                    return completionHandler(nil, error)
                }
                completionHandler(profileURL, nil)
            }
        }
    }
}
