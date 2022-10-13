//
//  CheckerService.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 10.10.2022.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol{
    func checkCredentials(login: String, password: String, completion:  @escaping (Result<User,LoginError>) -> Void)
    func signUp(login: String, password: String, completion: @escaping (User?) -> Void)
}

class CheckerService: CheckerServiceProtocol {
    func checkCredentials(login: String, password: String, completion:  @escaping (Result<User, LoginError>) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) {authResult, error in
            if let error = error {
                let authError = error as NSError
                //print("🐠 Ошибка авторизации. Error: \(authError.debugDescription)")
                if authError.code == AuthErrorCode.invalidEmail.rawValue {
                    completion(.failure(.invalidEmail))
                } else if authError.code == AuthErrorCode.userNotFound.rawValue {
                    completion(.failure(.userNotFound))
                } else if authError.code == AuthErrorCode.wrongPassword.rawValue {
                    completion(.failure(.wrongPassword))
                }
            } else {
                let currentUser = FirebaseAuth.Auth.auth().currentUser
                if let userEmail = currentUser?.email {
                    let navUser = User(login: userEmail)
                    completion(.success(navUser))
                } else {
                    completion(.failure(.loginFailed))
                }
            }
        }
    }
    
    func signUp(login: String, password: String, completion: @escaping (User?) -> Void) {
        Auth.auth().createUser(withEmail: login, password: password, completion: { authResult, error in
            if let user = authResult?.user, error == nil, let userEmail = user.email {
                let navUser = User(login: userEmail)
                completion(navUser)
            } else {
                completion(nil)
            }
        })
    }
}
