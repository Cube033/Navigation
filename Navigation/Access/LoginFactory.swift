//
//  Factory.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation

protocol LoginFactory {
    static func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    static func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
