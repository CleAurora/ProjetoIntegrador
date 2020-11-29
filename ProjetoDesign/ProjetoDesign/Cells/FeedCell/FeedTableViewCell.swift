//
//  FeedTableViewCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit
import Foundation
// MARK: - Protocols
protocol ButtonsTableView{
    func didButtonPressed()
}

class FeedTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var subtitlesLabel: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var viewLiked: extensions!
    
    // MARK: - Proprierts
    var delegate: ButtonsTableView?
    var heart: String? = nil
    var nameTap : (() -> ()) = {}
    var heartTap : (() -> ()) = {}
    
    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImageView.isHidden = true
        addSingleAndDoubleTapGesture()
                // Initialization code
    }
    
    // MARK: - IBActions
    @IBAction func nameButton(_ sender: Any) {
        nameTap()
    }
    @IBAction func commentsButton(_ sender: Any) {
        delegate?.didButtonPressed()
    }
    @IBAction func likedButton(_ sender: Any) {
        heartTap()
    }
    @IBAction func commentsViewButton(_ sender: Any) {
        delegate?.didButtonPressed()
    }
    
    @IBAction func heartLikeButton(_ sender: Any) {
        heartTap()
    }
    
    // MARK: - Methods
    func setupPhoto(photo: PhotoDetail){
        uploadImageView.image = UIImage(named: photo.imageProfile)
        postImageView.image = UIImage(named: photo.imagePost)
        nameButton.setTitle("\(photo.name)", for: .normal)

        var cityAndTemperature = ""

        if let city = photo.city {
            cityAndTemperature = city
        }

        cityLabel.text = cityAndTemperature

        let text = "\(photo.name): \(photo.comments)".withBoldText(text: "\(photo.name)")
        subtitlesLabel.attributedText = text
    }
    func setup(post: PostUser){
        uploadImageView.image = UIImage(named: post.imageProfile)
        postImageView.image = UIImage(named: post.imagePost)
        nameButton.setTitle("\(post.name)", for: .normal)

        var cityAndTemperature = ""

        if let city = post.city {
            cityAndTemperature = city
        }

        if let temperature = post.temperature {
            cityAndTemperature += String(format: " %.2fºC", arguments: [temperature])
        }

        cityLabel.text = cityAndTemperature

        let text = "\(post.name): \(post.comments)".withBoldText(text: "\(post.name)")
        subtitlesLabel.attributedText = text
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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



