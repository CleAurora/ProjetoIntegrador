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
        if let vc = UIStoryboard(name: "imagePick", bundle: nil).instantiateInitialViewController() as? imagepickViewController {
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
