//
//  FeedTableViewCell.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import UIKit

// MARK: - Protocols

protocol ButtonsTableView: AnyObject {
    func didButtonPressed(postId: String?)
}

final class FeedTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var subtitlesLabel: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var viewLiked: extensions!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!

    // MARK: - Proprierts
    weak var delegate: ButtonsTableView?
    var hasHeart: Bool = false
    var postId: String? = nil
    var nameTap : (() -> ()) = {}
    var heartTap : (() -> ()) = {}

    // MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()

        likeImageView.isHidden = true
        addSingleAndDoubleTapGesture()
    }

    // MARK: - IBActions

    @IBAction func nameButton(_ sender: Any) {
        nameTap()
    }

    @IBAction func commentsButton(_ sender: Any) {
        delegate?.didButtonPressed(postId: postId)
    }

    @IBAction func likedButton(_ sender: Any) {
        heartTap()
    }

    @IBAction func commentsViewButton(_ sender: Any) {
        delegate?.didButtonPressed(postId: postId)
    }

    @IBAction func heartLikeButton(_ sender: Any) {
        heartTap()
    }

    // MARK: - Methods
    func setupPhoto(photo: PhotoDetail){
        uploadImageView.image = UIImage(named: photo.imageProfile)
        postImageView.image = UIImage(named: photo.imagePost)
        nameButton.setTitle("\(photo.name)", for: .normal)

        var cityAndTemperature = ""

        if let city = photo.city {
            cityAndTemperature = city
        }

        cityLabel.text = cityAndTemperature

        let text = "\(photo.name): \(photo.comments)".withBoldText(text: "\(photo.name)")
        subtitlesLabel.attributedText = text
    }

    func setup(post: PostUser) {
        postId = post.id
        numberOfLikesLabel.text = "\(post.numberOfLikes)"
        numberOfCommentsLabel.text = "\(post.numberOfComments)"

        if post.user.imageProfileUrl.hasPrefix("https") {
            uploadImageView.kf.setImage(with: URL(string: post.user.imageProfileUrl))
        } else {
            uploadImageView.image = UIImage(named: post.user.imageProfileUrl)
        }

        if post.imagePostUrl.hasPrefix("https") {
            postImageView.kf.setImage(with: URL(string: post.imagePostUrl))
        } else {
            postImageView.image = UIImage(named: post.imagePostUrl)
        }

        nameButton.setTitle(post.user.name, for: .normal)

        var cityAndTemperature = ""

        if let city = post.city {
            cityAndTemperature = city
        }

        if let temperature = post.temperature?.trimmingCharacters(in: .whitespacesAndNewlines),
           !temperature.isEmpty {
            cityAndTemperature += String(format: " %@ºC", arguments: [temperature])
        }

        cityLabel.text = cityAndTemperature

        subtitlesLabel.attributedText = nil

        if let comments = post.comments {
            let text = "\(post.user.name): \(comments)".withBoldText(text: "\(post.user.name)")
            subtitlesLabel.attributedText = text
        }

        hasHeart = post.isLiked
        likeImageView.isHidden = post.isLiked
        viewLiked.backgroundColor = post.isLiked ? .systemIndigo : .lightGray
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func addSingleAndDoubleTapGesture() {
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTapGesture.numberOfTapsRequired = 1
        likeImageView.addGestureRecognizer(singleTapGesture)

        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        likeImageView.addGestureRecognizer(doubleTapGesture)

        singleTapGesture.require(toFail: doubleTapGesture)
    }

    // MARK: - OBJC Methods 
    @objc private func handleSingleTap(_ tapGesture: UITapGestureRecognizer) {
        likeImageView.isHidden = true
    }

    @objc private func handleDoubleTap(_ tapGesture: UITapGestureRecognizer) {
        heartTap()
    }
}
