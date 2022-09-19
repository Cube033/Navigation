//
//  UserService.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 19.09.2022.
//

import Foundation
import UIKit

protocol UserService {
    func getUserByLogin (login: String) -> User?
}

class CurrentUserService:UserService {
    
    let user: User
    
    init() {
        self.user = User(login: "cube033")
        self.user.avatar = UIImage(named: "myAvatarImage")!
        self.user.status = "life is good"
        self.user.fullName = "Dmitry Fedotov"
        self.user.password = "Passw0rd"
    }
    
    func getUserByLogin (login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService:UserService {
    
    let user: User
    
    init() {
        self.user = User(login: "test")
        self.user.avatar = UIImage(named: "blue_pixel")!
        self.user.status = "test"
        self.user.fullName = "test"
        self.user.password = "test"
    }
    
    func getUserByLogin (login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}
