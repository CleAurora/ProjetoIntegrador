//
//  LegendService.swift
//  ProjetoDesign
//
//  Created by Cleís Aurora Pereira on 06/12/20.
//

import UIKit

protocol LegendService {
    func add(legend: PostUser, for image: UIImage, usingWeather weatherType: String, then handler: @escaping (Result<PostUser, Error>) -> ())
}
