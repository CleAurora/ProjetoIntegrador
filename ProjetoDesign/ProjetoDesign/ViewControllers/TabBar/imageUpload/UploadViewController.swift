//
//  UploadViewController.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class UploadViewController: UIViewController {
    

    @IBOutlet weak var resizeImageView: UIImageView!
    @IBOutlet weak var uploadCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    
    var uploadArray = [Upload]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        uploadArray.append(Upload(image: "post1.jpg"))
        uploadArray.append(Upload(image: "post2.jpg"))
        uploadArray.append(Upload(image: "post3.jpg"))
        uploadArray.append(Upload(image: "instagram.png"))
        uploadArray.append(Upload(image: "facebook.png"))
        uploadArray.append(Upload(image: "mel1.jpeg"))
        nextButton.isHidden = true
        uploadCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    func setupCollection(){
        uploadCollectionView.delegate = self
        uploadCollectionView.dataSource = self
        uploadCollectionView.reloadData()
    }
    
}
extension UploadViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = uploadArray[indexPath.row].image
        
        resizeImageView.image = UIImage(named: image)
        nextButton.isHidden = false
    }
}
extension UploadViewController: UICollectionViewDataSource{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return uploadArray.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uploadCell", for: indexPath) as! UploadCollectionCell
    cell.setup(upload: uploadArray[indexPath.row])
    return cell
}
}
