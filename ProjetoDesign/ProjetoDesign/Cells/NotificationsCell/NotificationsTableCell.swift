//
//  NotificationsTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit
// MARK: - Protocols
protocol buttonsTable {
    func didButtonPressed()
}
class NotificationsTableCell: UITableViewCell {
    
    // MARK: - IBOtlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: roundImageView!
    @IBOutlet var notificationButton: UIButton!
    
    // MARK: - Proprierts
    var buttonTapped : (() -> ()) = {}
    
    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        notificationButton.setTitle("Follow", for: .normal)
        notificationButton.layer.cornerRadius = 10
        notificationButton.backgroundColor = .clear
        notificationButton.layer.borderWidth = 1
        notificationButton.setTitleColor(.black, for: .normal)
    }

    // MARK: - IBActions
    @IBAction func notificationButton(_ sender: Any) {
        buttonTapped()
        let actualText = notificationButton.titleLabel?.text
        notificationButton.layer.cornerRadius = 10
        notificationButton.backgroundColor = .systemIndigo
        print(actualText!)
        
        if actualText == "Follow" {
            notificationButton.setTitle("unfollow", for: .normal)
            notificationButton.setTitleColor(.white, for: .normal)
        }else{
            notificationButton.setTitle("Follow", for: .normal)
            notificationButton.layer.cornerRadius = 10
            notificationButton.backgroundColor = .clear
            notificationButton.layer.borderWidth = 1
            notificationButton.setTitleColor(.black, for: .normal)

        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Methods
    func setup(users: Post){
        let text = "\(users.name): started following you".withBoldText(text: "\(users.name)")
        nameLabel.attributedText = text
        userImage.image = UIImage(named: users.imageProfile)
    }
}

// MARK: - Extensions 
extension String {
    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
      let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
      let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: _font])
      let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
      let range = (self as NSString).range(of: text)
      fullString.addAttributes(boldFontAttribute, range: range)
      return fullString
    }}
