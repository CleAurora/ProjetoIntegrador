//
//  FeedTableViewCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var heart: String? = nil
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImageView.isHidden = true
        addSingleAndDoubleTapGesture()
                // Initialization code
    }
   
    func setup(post: Post){
        uploadImageView.image = UIImage(named: post.imageProfile)
        postImageView.image = UIImage(named: post.imagePost)
        nameLabel.text = post.name
        cityLabel.text = post.city
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func addSingleAndDoubleTapGesture() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(singleTapGesture)

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTapGesture)

        singleTapGesture.require(toFail: doubleTapGesture)
    }

    @objc private func handleSingleTap(_ tapGesture: UITapGestureRecognizer) {
        likeImageView.isHidden = true
    }

    @objc private func handleDoubleTap(_ tapGesture: UITapGestureRecognizer) {
        
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
