//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) -> Bool {
        let checker = Checker.shared
        return checker.check(login: login, password: password)
    }
}
