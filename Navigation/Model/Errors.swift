//
//  Errors.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 28.09.2022.
//

import Foundation

enum LoginError: Error {
    case loginFailed
    case wrongPassword
    case invalidEmail
    case userNotFound
}
