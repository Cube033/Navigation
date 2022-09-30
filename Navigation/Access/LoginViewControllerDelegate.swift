//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) throws -> Bool
}
