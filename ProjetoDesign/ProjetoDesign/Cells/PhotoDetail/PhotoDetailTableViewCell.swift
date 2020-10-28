//
//  PhotoDetailTableViewCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit
import Foundation
    
class PhotoDetailTableViewCell: UITableViewCell {
    
        @IBOutlet weak var likeImageView: UIImageView!
        @IBOutlet weak var uploadImageView: UIImageView!
        @IBOutlet weak var postImageView: UIImageView!
        @IBOutlet weak var cityLabel: UILabel!
        @IBOutlet weak var subtitlesLabel: UILabel!
        @IBOutlet weak var nameButton: UIButton!
        var delegate: ButtonsTableView?
        var heart: String? = nil
        var nameTap : (() -> ()) = {}
        
        override func awakeFromNib() {
            super.awakeFromNib()
            likeImageView.isHidden = true
            addSingleAndDoubleTapGesture()
                    // Initialization code
        }
        
        @IBAction func nameButton(_ sender: Any) {
            nameTap()
    //        delegate?.nameTapped()
        }
        @IBAction func commentsButton(_ sender: Any) {
            delegate?.didButtonPressed()
        }
        func setupPhoto(photo: PostUser){
            uploadImageView.image = UIImage(named: photo.imageProfile)
            postImageView.image = UIImage(named: photo.imagePost)
            nameButton.setTitle("\(photo.name)", for: .normal)
            cityLabel.text = photo.city
            let text = "\(photo.name): \(photo.comments)".withBoldText(text: "\(photo.name)")
            subtitlesLabel.attributedText = text
        }
      
        private func addSingleAndDoubleTapGesture() {
            let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
            singleTapGesture.numberOfTapsRequired = 1
            likeImageView.addGestureRecognizer(singleTapGesture)

            let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
            doubleTapGesture.numberOfTapsRequired = 2
            likeImageView.addGestureRecognizer(doubleTapGesture)

            singleTapGesture.require(toFail: doubleTapGesture)
        }

        @objc private func handleSingleTap(_ tapGesture: UITapGestureRecognizer) {
            likeImageView.isHidden = true
        }

        @objc private func handleDoubleTap(_ tapGesture: UITapGestureRecognizer) {
            print("clicked")
            if heart != nil {
                likeImageView.image = UIImage(named: "heart0.png")
                
                heart = nil
                likeImageView.isHidden = false
                
            }else {
                likeImageView.image = UIImage(named: "heart1.png")
                heart = "Item"
                likeImageView.isHidden = false
                
            }
        }
    }

