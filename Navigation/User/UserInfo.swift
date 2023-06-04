//
//  UserInfo.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 26.09.2022.
//

import Foundation
import Firebase

class UserInfo {
    
    static let shared = UserInfo()
    
    var user: User
//    var loggedIn = {
//        AccessManager.shared.userLoggedIn()
//    }
    
    private init() {
        self.user = User(uid: "", email: "")
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user == nil {
//                loggedIn = false
//            }
//        }
    }
    
    func setUser(user: User){
        UserInfo.shared.user = user
//        UserInfo.shared.loggedIn = true
    }
    
//    func clearUserInfo() {
//        UserInfo.shared.user = nil
////        UserInfo.shared.loggedIn = false
//    }
    
}
