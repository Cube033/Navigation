//
//  RealmManager.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 21.11.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    init() {
        migrate()
        refreshDatabase()
    }
    
    var authorizationArray: [RealmLoginModel] = []
    
    
    private func refreshDatabase() {
        guard let realm = getRealmObject() else { return }
        authorizationArray = Array(realm.objects(RealmLoginModel.self))
    }


    func addAuthorization(login: String, password: String, authorized: Bool) {
        do {
            guard let realm = getRealmObject() else { return }
            try realm.write {
                let authorization = RealmLoginModel()
                authorization.login = login
                authorization.password = password
                authorization.authorized = authorized
                realm.add(authorization)
            }
            refreshDatabase()
        } catch {
            return
        }
        
    }
    
    func deleteAuthorization(authorization: RealmLoginModel) {
        do {
            guard let realm = getRealmObject() else { return }
            try realm.write{
                realm.delete(authorization)
            }
            refreshDatabase()
        } catch {
            return
        }
    }
    
    private func migrate() {
        let config = Realm.Configuration(schemaVersion: 0)
        Realm.Configuration.defaultConfiguration = config
    }
    
    func getRealmObject() -> Realm? {
        // Создаем конфигурацию для зашифрованной базы данных
        let key = Helpers.shared.getKey(targetName: "realmEncryptKey")
        let config = Realm.Configuration(encryptionKey: key)
        do {
        // Открываем зашифрованную базу
            let realm = try Realm(configuration: config)
            // работаем с данными как обычно
            return realm
        } catch let error as NSError {
            print(error)
            // обрабатываем ошибку
        }
        return nil
    }
}
