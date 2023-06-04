//
//  FirebaseDatabaseManager.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 04.06.2023.
//

import Firebase

class FirebaseDatabaseManager {
    
    private let db = Database.database().reference()
    
    // Создание нового пользователя в базе данных после регистрации
    func createUser(user: User, completion: @escaping (Bool) -> Void) {
        db.child("users/\(user.uid)").setValue(user.dictionary) { error, _ in
            completion(error == nil)
        }
    }

    // Получение данных пользователя
    func getUserData(uid: String, completion: @escaping (User?) -> Void) {
        db.child("users/\(uid)").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any],
                  let email = value["email"] as? String else {
                completion(nil)
                return
            }

            let username = value["username"] as? String
            let profilePictureUrl = value["profilePictureUrl"] as? String

            let user = User(uid: uid, email: email, username: username, profilePictureUrl: profilePictureUrl)
            completion(user)
        }
    }
    
    // Обновление данных пользователя
    func updateUserData(user: User, completion: @escaping (Bool) -> Void) {
        db.child("users/\(user.uid)").updateChildValues(user.dictionary) { error, _ in
            completion(error == nil)
        }
    }
    
    // Получение массива пользователей
    func getAllUsers(completion: @escaping ([User]?) -> Void) {
            db.child("users").observeSingleEvent(of: .value) { snapshot in
                var users: [User] = []

                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let value = childSnapshot.value as? [String: Any],
                       let email = value["email"] as? String {
                        
                        let uid = childSnapshot.key
                        let username = value["username"] as? String
                        let profilePictureUrl = value["profilePictureUrl"] as? String
                        
                        let user = User(uid: uid, email: email, username: username, profilePictureUrl: profilePictureUrl)
                        users.append(user)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(users)
                }
            }
        }
}
