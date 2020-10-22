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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(comments: comments){
        profileImageView.image = UIImage(named: comments.image)
        let text = "\(comments.name): \(comments.comment)".withBoldText(text: "\(comments.name)")
        CommentsLabel.attributedText = text
    }

}
