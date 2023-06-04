//
//  Errors.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 28.09.2022.
//

import Foundation

enum LoginError: Error {
    case emptyLoginField
    case emailFormatError
    case emptyPasswordField
    case loginFailed
    case userNotExist
    case errorNotDefined
    case weakPassword
}
