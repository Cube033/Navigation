//
//  Checker.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

class Checker {
    
    static var shared = Checker()
    
    private let login = "cube033"
    private let password = "Passw0rd"
    
    private init() {}
    
    func check(login: String, password: String) -> Result<Bool, LoginError> {
        
        if login == "" {
            return .failure(.emptyLoginField)
        } else if password == "" {
            return .failure(.emptyPasswordField)
        } else if login == self.login && password == self.password {
            return .success(true)
        } else {
            return .failure(.loginFailed)
        }
    }
}
