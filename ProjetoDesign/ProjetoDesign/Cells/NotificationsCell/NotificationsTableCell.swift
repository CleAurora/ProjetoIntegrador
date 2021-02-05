//
//  NotificationsTableCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-20.
//

import UIKit
import Kingfisher
// MARK: - Protocols
protocol buttonsTable {
    func didButtonPressed()
}
class NotificationsTableCell: UITableViewCell {

    // MARK: - IBOtlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: roundImageView!
    @IBOutlet var notificationButton: UIButton!
    var followRequest = FollowRequest()
    // MARK: - Proprierts
    var buttonTapped : (() -> ()) = {}

    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
//        notificationButton.setTitle("Follow", for: .normal)
//        notificationButton.layer.cornerRadius = 10
//        notificationButton.backgroundColor = .clear
//        notificationButton.layer.borderWidth = 1
//        notificationButton.setTitleColor(.black, for: .normal)
    }

    // MARK: - IBActions
    @IBAction func notificationButton(_ sender: Any) {
        buttonTapped()
        let actualText = notificationButton.titleLabel?.text
        notificationButton.layer.cornerRadius = 10
        notificationButton.backgroundColor = .systemIndigo
 
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
    func setup(notifications: Usuario){
        if let name = notifications.name {
            let text = "\(name): started following you".withBoldText(text: "\(name)")
            nameLabel.attributedText = text
        }
        if let photo = notifications.profileUrl {
            userImage.kf.setImage(with: URL(string: photo))
        }
        self.followRequest.userSelected = notifications
        self.followRequest.getFollowingToButton(completionHandler: { success, _ in
            if success {
              
               // if self.followRequest.followingActive == false {
                if self.followRequest.followingArray.contains(notifications.userID){
                    self.notificationButton.setTitle("unfollow", for: .normal)
                    self.notificationButton.layer.cornerRadius = 10
                    self.notificationButton.setTitleColor(.white, for: .normal)
                    self.notificationButton.backgroundColor = UIColor(patternImage: (UIImage(named: "2.jpg")!))
                }else{
                    self.notificationButton.setTitle("Follow", for: .normal)
                    self.notificationButton.layer.cornerRadius = 10
                    self.notificationButton.backgroundColor = .clear
                    self.notificationButton.layer.borderWidth = 1
                    self.notificationButton.setTitleColor(.black, for: .normal)
                }
            }
        })
        
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
