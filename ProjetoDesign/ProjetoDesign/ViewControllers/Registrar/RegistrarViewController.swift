//
//  RegistrarViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class RegistrarViewController: UIViewController {
    @IBOutlet weak var registerView: extensions!
    @IBOutlet weak var registerLabel: UILabel!
    var controller: Alert?
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        registerView.backgroundColor = UIColor(patternImage: UIImage(named: "2.jpg")!)
        controller = Alert()
//        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func keyboardWillChange(notification: NSNotification){
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    @objc func keyboardWillHide(notification: NSNotification){
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
