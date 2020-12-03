//
//  uploadTableDelegateDataSource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-02.
//

import Foundation
import UIKit
protocol ImagePickerDelegate {
    func pickImage()
}
class uploadTableDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var delegate : ImagePickerDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "uploadCell") as! UploadTableViewCell
        
        return cell
    }
    
    
}
