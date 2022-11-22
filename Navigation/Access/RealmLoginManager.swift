//
//  RealmLoginManager.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 21.11.2022.
//

import Foundation

class RealmLoginManager {
    
    static let shared = RealmLoginManager()
    
    init() {}
    
    func authrization(login: String, password: String) {
        if !checkLogin(login: login) {
            RealmManager.shared.addAuthorization(login: login, password: password, authorized: true)
        }
    }
    
    func getFirstAuthorized() -> RealmLoginModel? {
        let authorizationArray = RealmManager.shared.authorizationArray
        let firstAuthorizedUser = authorizationArray.first(where: {
            $0.authorized == true
        })
        return firstAuthorizedUser
    }
    
    func checkLogin(login: String) -> Bool {
        let authorizationArray = RealmManager.shared.authorizationArray
        let userOpt = authorizationArray.first(where: {
            $0.login == login
        })
        if let user = userOpt {
            if !user.authorized {
                user.authorize(isAuthorized: true)
            }
        } else {
            return false
        }
        return true
    }
}
