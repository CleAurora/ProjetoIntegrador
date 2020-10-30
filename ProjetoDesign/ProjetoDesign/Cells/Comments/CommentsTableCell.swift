//
//  CommentsTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit

class CommentsTableCell: UITableViewCell {
    @IBOutlet weak var profileImageView: roundImageView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var CommentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet var likeImage: UIImageView!
    var likedButton : (() -> ()) = {}
    var imageString = "suit.heart"
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.image = UIImage(systemName: "suit.heart")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButton(_ sender: Any) {
        likedButton()
    }
    func changeImage(){
        print("change image executed")
        if imageString == "suit.heart" {
            imageString = "suit.heart.fill"
            print(imageString)
        }else if imageString == "suit.heart.fill"{
            imageString = "suit.heart"
            print(imageString)
        }else {
            imageString = "suit.heart"
            print(imageString)
        }
    }
    func setup(comments: comments){
        profileImageView.image = UIImage(named: comments.image)
        let text = "\(comments.name): \(comments.comment)".withBoldText(text: "\(comments.name)")
        CommentsLabel.attributedText = text
    }

}
