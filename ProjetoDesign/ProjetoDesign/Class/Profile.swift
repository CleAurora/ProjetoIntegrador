//
//  Profile.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-04.
//

import Foundation
class Profile{
    // MARK: - Proprierts 
    var name: String
    var profileImage: String
    var bio: String
    var uid: String

    // MARK: - Constructors
    init(name: String, profileImage: String, bio: String, uid: String) {
        self.name = name
        self.profileImage = profileImage
        self.bio = bio
        self.uid = uid

    }
}
