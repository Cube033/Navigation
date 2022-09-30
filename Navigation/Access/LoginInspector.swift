//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, password: String) throws -> Bool {
        let checker = Checker.shared
        let chekResult: Result<Bool, LoginError> = checker.check(login: login, password: password)
        switch chekResult {
        case .success(let checkIsSuccess):
            return checkIsSuccess
        case .failure(let loginError):
            throw loginError
        }
    }
}
