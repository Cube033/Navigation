//
//  Palette.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 19.01.2023.
//

import UIKit

struct Palette {
    static var viewControllerBackgroundColor = UIColor.createColor(lightMode: .white, darkMode: .systemGray4)
    static var textFieldBackgroundColor = UIColor.createColor(lightMode: .systemGray6, darkMode: .systemGray2)
    static var textFieldBorderColor = UIColor.createColor(lightMode: .lightGray, darkMode: .systemGray).cgColor
    static var placeholderColor = UIColor.createColor(lightMode: .lightGray, darkMode: .white)
    static var collectionViewBackgroundColor = UIColor.createColor(lightMode: .systemGray5, darkMode: .systemGray4)
}
