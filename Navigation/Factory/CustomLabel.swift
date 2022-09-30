//
//  CustomLabel.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 29.09.2022.
//

import UIKit

class CustomLabel: UILabel {
    
    var fontSizeOpt:CGFloat?
    
    lazy var fontSize:CGFloat = fontSizeOpt ?? 18.0
    lazy var nameLabelFont = UIFont(name:"HelveticaNeue-Bold", size: fontSize)
    
    init (fontSize:CGFloat?) {
        super.init(frame: .zero)
        self.fontSizeOpt = fontSize
        textColor = .black
        font = nameLabelFont
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
