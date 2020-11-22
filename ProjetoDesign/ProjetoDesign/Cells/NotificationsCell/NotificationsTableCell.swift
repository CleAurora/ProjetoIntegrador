//
//  NotificationsTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit
protocol buttonsTable {
    func didButtonPressed()
}
class NotificationsTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: roundImageView!
    @IBOutlet var notificationButton: UIButton!
    
    var buttonTapped : (() -> ()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func notificationButton(_ sender: Any) {
        buttonTapped()
        let actualText = notificationButton.titleLabel?.text
        print(actualText)
        
        if actualText == "Follow" {
            notificationButton.setTitle("Following", for: .normal)
        }else{
            notificationButton.setTitle("Follow", for: .normal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func setup(users: Post){
        let text = "\(users.name): started following you".withBoldText(text: "\(users.name)")
        nameLabel.attributedText = text
        userImage.image = UIImage(named: users.imageProfile)
    }
}
extension String {
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
      let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
      let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
      let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
      let range = (self as NSString).range(of: text)
      fullString.addAttributes(boldFontAttribute, range: range)
      return fullString
    }}
