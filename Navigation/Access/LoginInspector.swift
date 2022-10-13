//
//  LoginInspector.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

struct LoginInspector: LoginViewControllerDelegate {
    func checkCredentials(login: String, password: String, completion: @escaping (Result<User, LoginError>) -> Void) {
        let checkerService = CheckerService()
        checkerService.checkCredentials(login: login, password: password, completion: completion)
    }
    
    func signUp(login: String, password: String, completion: @escaping (User?) -> Void) {
        let checkerService = CheckerService()
        checkerService.signUp(login: login, password: password, completion: completion)
    }
}
