//
//  UserInfo.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 26.09.2022.
//

import Foundation

class UserInfo {
    
    static let shared: UserInfo = {
        let userInfo = UserInfo()
        userInfo.user = nil
        userInfo.loggedIn = false
        return userInfo
    }()
    
    var user: User?
    var loggedIn = false
    
    private init() {}
    
    func setUser(user: User){
        UserInfo.shared.user = user
        UserInfo.shared.loggedIn = true
    }
    
    func clearUserInfo() {
        UserInfo.shared.user = nil
        UserInfo.shared.loggedIn = false
    }
    
}
