//
//  PhotoDetailTableViewCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-25.
//

import UIKit
import Foundation
    
class PhotoDetailTableViewCell: UITableViewCell {
    
        // MARK: - IBOutlets
        @IBOutlet weak var likeImageView: UIImageView!
        @IBOutlet weak var uploadImageView: UIImageView!
        @IBOutlet weak var postImageView: UIImageView!
        @IBOutlet weak var cityLabel: UILabel!
        @IBOutlet weak var subtitlesLabel: UILabel!
        @IBOutlet weak var nameButton: UIButton!
    
        // MARK: - Proprierts
        var delegate: ButtonsTableView?
        var heart: String? = nil
        var nameTap : (() -> ()) = {}
        
        // MARK: - Super Methods
        override func awakeFromNib() {
            super.awakeFromNib()
            likeImageView.isHidden = true
            addSingleAndDoubleTapGesture()
            nameButton.layer.cornerRadius = 10
            cityLabel.layer.cornerRadius = 10 
        }
        
        // MARK: - IBActions
        @IBAction func nameButton(_ sender: Any) {
            nameTap()
        }
        @IBAction func commentsButton(_ sender: Any) {
            delegate?.didButtonPressed()
        }
    
        // MARK: - Methods
        func setupPhoto(photo: PostUser){
            if photo.user.imageProfileUrl.hasPrefix("https") {
                uploadImageView.kf.setImage(with: URL(string: photo.user.imageProfileUrl))
            } else {
                uploadImageView.image = UIImage(named: photo.user.imageProfileUrl)
            }

            if photo.imagePostUrl.hasPrefix("https") {
                uploadImageView.kf.setImage(with: URL(string: photo.imagePostUrl))
            } else {
                uploadImageView.image = UIImage(named: photo.imagePostUrl)
            }

            nameButton.setTitle("\(photo.user.name)", for: .normal)
            cityLabel.text = photo.city

            subtitlesLabel.attributedText = nil

            if let comments = photo.comments {
                let text = "\(photo.user.name): \(comments)".withBoldText(text: "\(photo.user.name)")
                subtitlesLabel.attributedText = text
            }

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

    
        // MARK: - OBJC Methods 
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

