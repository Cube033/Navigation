//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func checkCredentials(login: String, password: String, completion:  @escaping (Result<User,LoginError>) -> Void)
    func signUp(login: String, password: String, completion:  @escaping (User?) -> Void)
}
