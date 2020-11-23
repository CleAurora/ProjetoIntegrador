//
//  RegistrarViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class RegistrarViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var registerView: extensions!
    
     let imagePicker = UIImagePickerController()
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    var controller: Alert?
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        registerView.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        controller = Alert()
        imagePicker.delegate = self
        
       let tap = UITapGestureRecognizer(target: self, action: #selector(RegistrarViewController.click))
       userImage.addGestureRecognizer(tap)
        
       userImage.isUserInteractionEnabled = true
    }
            @objc func click()
               {
                   imagePicker.allowsEditing = false
                   imagePicker.sourceType = .photoLibrary
                    imagePicker.modalPresentationStyle = .fullScreen
                   present(imagePicker, animated: true, completion: nil)
               }


               @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                if  let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
                    userImage.contentMode = .scaleAspectFill
                   userImage.image = chosenImage
                   }
                   dismiss(animated: true, completion: nil)
               }

               func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                   dismiss(animated: true, completion: nil)
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
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? TabbarController{
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func instagramButton(_ sender: Any) {
        isDeveloping()
        print("click")
    }
    @IBAction func facebookButton(_ sender: Any) {
        isDeveloping()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
