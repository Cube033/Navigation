//
//  StringExtension.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 17.01.2023.
//

import Foundation

extension String {
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
}
