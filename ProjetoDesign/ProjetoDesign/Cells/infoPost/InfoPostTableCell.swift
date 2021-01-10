//
//  InfoPostTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-11.
//

import UIKit

class InfoPostTableCell: UITableViewCell {
    // MARK: - IBOtlets
    @IBOutlet weak var settingsLabel: UILabel!

    // MARK: - Super Methods 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
