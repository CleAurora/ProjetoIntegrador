//
//  PhotoDetailViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit

final class PhotoDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var photoTableView: UITableView!

    // MARK: - Proprierts
    var user: searchModel?
    
    var post: PostUser?
    var photoDetail = [PostUser]()
    var name: String?
    var image: String?
    var comments: String?

    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        name = post?.user.name
        photoTableView.delegate = self
        photoTableView.dataSource = self

        photoDetail.append(
            PostUser(
                userId: UUID().uuidString,
                userName: name ?? "",
                userProfileUrl: post?.user.imageProfileUrl ?? "",
                city: post?.city,
                temperature: post?.temperature,
                weatherType: post?.weatherType,
                imagePostUrl: post?.imagePostUrl ?? ""
            )
        )
    }

    // MARK: - Methods
    func textInfo(){

    }
}

// MARK: - Extensions
extension PhotoDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension PhotoDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photoDetail.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! PhotoDetailTableViewCell
        cell.setupPhoto(photo: photoDetail[indexPath.row])
        return cell
    }

}
