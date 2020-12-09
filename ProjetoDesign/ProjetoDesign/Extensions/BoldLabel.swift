//
//  BoldLabel.swift
//  ProjetoDesign
//
//  Created by Lestad on 2020-10-22.
//

import Foundation
import UIKit

public class boldLabel: NSString{

    func withBoldText(text: String, font: UIFont? = nil) -> NSAttributedString {
      let _font = font ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        let fullString = NSMutableAttributedString(string: self as String, attributes: [NSAttributedString.Key.font: _font])
      let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: _font.pointSize)]
      let range = (self as NSString).range(of: text)
      fullString.addAttributes(boldFontAttribute, range: range)
      return fullString
    }}
