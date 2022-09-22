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
    
    init() {}
    
    func check(login: String, password: String) -> Bool {
        return login == self.login && password == self.password
    }
}
