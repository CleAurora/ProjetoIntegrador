//
//  SearchTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit
import Kingfisher

class SearchTableCell: UITableViewCell {
    // MARK: - IBOtlets
    @IBOutlet weak var userImageView: roundImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methods 
    func setup(user: Usuario){
        userNameLabel.text = user.name
        let url = URL(string: user.profileUrl)
        userImageView.kf.setImage(with: url)
        //userImageView.image = UIImage(named: user.imageProfile)
    }
}
