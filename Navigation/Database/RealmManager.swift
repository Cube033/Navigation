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
        do {
            let realm = try Realm()
            authorizationArray = Array(realm.objects(RealmLoginModel.self))
        } catch {
            authorizationArray = []
        }
        
    }


    func addAuthorization(login: String, password: String, authorized: Bool) {
        do {
            let realm = try Realm()
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
            let realm = try Realm()
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
    
}
