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
            guard let realm = RealmManager.shared.getRealmObject() else { return }
            try realm.write {
                authorized = isAuthorized
            }
        } catch {
            return
        }
    }
}
