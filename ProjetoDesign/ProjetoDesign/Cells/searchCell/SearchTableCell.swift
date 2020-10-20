//
//  SearchTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit

class SearchTableCell: UITableViewCell {
    @IBOutlet weak var userImageView: roundImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(user: Post){
        userNameLabel.text = user.name
        userImageView.image = UIImage(named: user.imageProfile)
    }
}
