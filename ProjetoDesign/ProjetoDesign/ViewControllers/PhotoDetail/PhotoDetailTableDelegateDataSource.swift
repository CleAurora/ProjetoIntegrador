//
//  PhotoDetailTableDelegateDataSource.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-12-17.
//

import Foundation
import UIKit

final class PhotoDetailTableDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var photoArray = [PhotoDetailModel]()
    var view = PhotoDetailViewController()
    var userRequest = ViewRequest()

    init(view: PhotoDetailViewController, request: ViewRequest) {
        self.view = view
        self.userRequest = request

    }
    func loadData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        photoArray.append(
            PhotoDetailModel(name: view.name ?? "",
                             city: view.postDetail?.city ?? "",
                             imageProfile: view.image ?? "",
                             imagePost: view.postDetail?.imagePost ?? "",
                             caption: view.postDetail?.caption ?? "",
                             comments: "",
                             liked: "",
                             weather: view.postDetail?.weather ?? ""
            ))
        print(photoArray.count)
        completionHandler(true, nil)
    }
    
    func passData(completionHandler: @escaping (_ result: Bool, _ error: Error?) -> Void){
        photoArray.append(
            PhotoDetailModel(name: userRequest.userName ?? "",
                             city: view.user?.city ?? "",
                             imageProfile: userRequest.imageProfile ?? "",
                             imagePost: view.user?.imagePostUrl ?? "",
                             caption: view.user?.caption ?? "",
                             comments: view.user?.comments ?? "",
                             liked: "",
                             weather: view.user?.weather ?? ""
            ))
        
        completionHandler(true, nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! PhotoDetailTableViewCell
        cell.setup(photo: photoArray[indexPath.row])
        print("cell: \(photoArray[indexPath.row].name)")
        return cell
    }
}
