//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func successLogin()
    func loginFailed(result: Result<Bool, LoginError>)
    func userNameRequest(uid: String)
}
