//
//  RealmModel.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 21.11.2022.
//

import Foundation
import RealmSwift

class RealmLoginModel: Object {
    @Persisted var login: String = ""
    @Persisted var password: String = ""
    @Persisted var authorized: Bool = false
    
    func authorize(isAuthorized: Bool) {
        do{
            let realm = try Realm()
            try realm.write {
                authorized = isAuthorized
            }
        } catch {
            return
        }
    }
}
