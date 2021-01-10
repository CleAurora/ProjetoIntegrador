//
//  CommentsTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import UIKit

class CommentsTableCell: UITableViewCell {

    // MARK: - IBOtlets
    @IBOutlet weak var profileImageView: roundImageView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet var likeImage: UIImageView!

    // MARK: - Proprierts
    var likedButton : (() -> ()) = {}
    var imageString = "suit.heart"

    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.image = UIImage(systemName: "suit.heart")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - IBActions
    @IBAction func likeButton(_ sender: Any) {
        likedButton()
    }

    // MARK: - Methods

    func changeImage() {
        if imageString == "suit.heart" {
            imageString = "suit.heart.fill"
        } else if imageString == "suit.heart.fill" {
            imageString = "suit.heart"
        } else {
            imageString = "suit.heart"
        }
    }

    func setup(comments: CommentViewModel) {
        let userName = comments.user.name ?? ""
        let text = "\(userName): \(comments.text)".withBoldText(text: "\(userName)")

        commentsLabel.attributedText = text
        profileImageView.kf.setImage(with: comments.user.photoUrl)
    }

}
