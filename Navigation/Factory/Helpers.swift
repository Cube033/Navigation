//
//  Helpers.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 07.12.2022.
//

import Foundation

class Helpers {
    
    static var shared = Helpers()
    
    func getKey(targetName: String) -> Data {
        if let passData = KeyChainService.shared.getPasswordData(login: "default", serviceName: "VK.\(targetName)") {
            return passData
        } else {
            let newKey = getRandomDataKey()
            _ = KeyChainService.shared.addPassword(login: "default", passData: newKey, serviceName: "VK.\(targetName)")
            return newKey
        }
    }
    
    func getRandomDataKey() -> Data {
        // Генерируем случайный ключ
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }
        return key
    }
    
    func getStringFromBytes(from bytes: [UInt8]) -> String {
        String(bytes: bytes, encoding: .utf8)!
    }
    
    func getBytesFromString(from string: String) {
        if let data = string.data(using: .utf8) {
            var array: [UInt8] = []
            for byte in data {
                array.append(byte)
            }
            print(array)
        }
    }
    
    func getBytesArrayFromData(from data: Data) {
        var array: [UInt8] = []
        for byte in data {
            array.append(byte)
        }
        print(array)
    }
}
