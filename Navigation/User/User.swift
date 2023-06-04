//
//  User.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 19.09.2022.
//

import UIKit

struct User {
    
    let uid: String
    let email: String
    var username: String?
    var profilePictureUrl: String?
    
    var dictionary: [String: Any] {
            return [
                "uid": uid,
                "email": email,
                "username": username ?? "",
                "profilePictureUrl": profilePictureUrl ?? ""
            ]
        }
    
}
