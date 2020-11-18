//
//  Alert.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-11-17.
//

import Foundation
import UIKit

class Alert {
    var controller: RegistrarViewController?
    func isDeveloping(completionHandler: (_ result: Bool, _ error: Error?) -> Void){
        controller = RegistrarViewController()
        do{
            
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")

                  case .cancel:
                        print("cancel")

                  case .destructive:
                        print("destructive")


            }}))
            controller?.present(alert, animated: true, completion: nil)
            
            completionHandler(true,nil)
        }catch{
            completionHandler(false,nil)
        }
        
    }
}
