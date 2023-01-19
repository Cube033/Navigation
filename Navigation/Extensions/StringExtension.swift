//
//  StringExtension.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 17.01.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var attributedPlaceholder: NSAttributedString {
        return NSAttributedString(string: self,
                                  attributes: [NSAttributedString.Key.foregroundColor: Palette.placeholderColor])
    }
}
