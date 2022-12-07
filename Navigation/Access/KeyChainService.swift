//
//  KeyChain.swift
//  Netology.iosdb
//
//  Created by Дмитрий Федотов on 15.11.2022.
//

import Foundation

enum KeyChainResult {
    case success(String)
    case fault(String)
}

class KeyChainService {
    
    static let shared = KeyChainService()
    
    private init() {}
    
    //String
    func addPassword(login: String, password: String, serviceName: String) -> KeyChainResult {
        
        guard let passData = password.data(using: .utf8) else {
            return .fault("Ошибка преобразования пароля")
        }
        
        let attribute = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: passData,
            kSecAttrAccount: login,
            kSecAttrService: serviceName,
            //kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ] as CFDictionary
        
        let status = SecItemAdd(attribute, nil)
        
        if status == errSecSuccess {
            return .success("Пароль добавлен")
        } else {
            print(SecCopyErrorMessageString(status,nil)!)
            return .fault("Ошибка добавления пароля: \(status)")
        }
    }
    func addPassword(login: String, passData: Data, serviceName: String) -> KeyChainResult {
        
        let attribute = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: passData,
            kSecAttrAccount: login,
            kSecAttrService: serviceName,
            //kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked
        ] as CFDictionary
        
        let status = SecItemAdd(attribute, nil)
        
        if status == errSecSuccess {
            return .success("Пароль добавлен")
        } else {
            print(SecCopyErrorMessageString(status,nil)!)
            return .fault("Ошибка добавления пароля: \(status)")
        }
    }
    
    func getPassword(login: String, serviceName: String) -> KeyChainResult {
        let  query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        
        var extractedData: AnyObject?
        
        let status = SecItemCopyMatching(query, &extractedData)
        
        if status != errSecSuccess {
            return .fault("Ошибка получения пароля: \(status)")
        }
        
        guard let passData = extractedData as? Data,
              let password = String(data: passData, encoding: .utf8) else {
            return .fault("Ошибка преобразования пароля")
        }
        
        if password == "" {
            return .fault("Empty password")
        }
        
        return .success(password)
    }
    
    func getPasswordData(login: String, serviceName: String) -> Data? {
        let  query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login,
            kSecAttrService: serviceName,
            kSecReturnData: true
        ] as CFDictionary
        
        var extractedData: AnyObject?
        
        let status = SecItemCopyMatching(query, &extractedData)
        
        if status != errSecSuccess {
            print("Ошибка получения пароля: \(status)")
            return nil
        }
        
        guard let passData = extractedData as? Data else {
            print("Ошибка извлечения пароля")
            return nil
        }
        
        return passData
    }
    
    
    func updatePassword(login: String, newPassword: String, serviceName: String) -> KeyChainResult {
        
        guard let passData = newPassword.data(using: .utf8) else {
            return .fault("Ошибка преобразования пароля")
        }
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login,
            kSecAttrService: serviceName,
            kSecReturnData: false
        ] as CFDictionary
        
        let attribute = [
            kSecValueData: passData
        ] as CFDictionary
        
        let status = SecItemUpdate(query, attribute)
        
        if status == errSecSuccess {
            return .success("Пароль обновлен")
        } else {
            return .fault("Ошибка обновления пароля: \(status)")
        }
    }
    
    
    func deletePassword(login: String, serviceName: String) -> KeyChainResult {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login,
            kSecAttrService: serviceName,
            kSecReturnData: false
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        
        if status == errSecSuccess {
            return .success("Пароль успешно удален")
        } else {
            return .fault("Пароль не удален, ошибка: \(status)")
        }
    }
    
}
