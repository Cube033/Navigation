//
//  Errors.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 28.09.2022.
//

import Foundation

enum LoginError: Error {
    case emptyLoginField
    case emptyPasswordField
    case loginFailed
}
