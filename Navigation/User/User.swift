//
//  User.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 19.09.2022.
//

import Foundation
import UIKit

class User {
    
    let login: String
    var fullName: String = ""
    var avatar: UIImage = UIImage()
    var status: String = ""
    var password = ""
    
    init (login: String) {
        self.login = login
    }
    
}
