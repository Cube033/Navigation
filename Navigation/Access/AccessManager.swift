//
//  Checker.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.09.2022.
//

import Foundation
import Firebase
import FirebaseAuth

class AccessManager {
    
    static var shared = AccessManager()
    
    weak var delegate: LoginViewControllerDelegate?
    weak var mainCoordinatorDelegate: MainCoordinatorProtokol?
    
    private init() {}
    
    func check(login: String, password: String) {
        
        if login == "" {
            delegate?.loginFailed(result: .failure(.emptyLoginField))
        } else if password == "" {
            delegate?.loginFailed(result: .failure(.emptyPasswordField))
        } else {
            Auth.auth().signIn(withEmail: login, password: password) { authResult, error in
                DispatchQueue.main.async {
                    if let error = error as NSError? {
                        if let errorCode = error.userInfo["FIRAuthErrorUserInfoNameKey"] as? String {
                            if errorCode == "ERROR_INVALID_EMAIL" {
                                self.delegate?.loginFailed(result: .failure(.emailFormatError))
                            } else if errorCode == "ERROR_USER_NOT_FOUND" {
                                self.delegate?.loginFailed(result: .failure(.userNotExist))
                            } else if errorCode == "ERROR_WRONG_PASSWORD" {
                                self.delegate?.loginFailed(result: .failure(.loginFailed))
                            } else {
                                self.delegate?.loginFailed(result: .failure(.errorNotDefined))
                            }
                        }
                        
                    } else {
                        print(authResult!)
                        self.delegate?.successLogin()
                    }
                }
            }
        }
    }
    
    func userLoggedIn() -> Bool {
        
        if let uid = Auth.auth().currentUser?.uid  {
            FirebaseDatabaseManager().getUserData(uid: uid, completion: {(user) in
                if let user = user {
                    UserInfo.shared.setUser(user: user)
                }
            })
            return true
        } else {
            return false
        }
    }
    
    func createUser(userLogin: String, userPassword: String) {
        
        if userLogin == "" {
            delegate?.loginFailed(result: .failure(.emptyLoginField))
        } else if userPassword == "" {
            delegate?.loginFailed(result: .failure(.emptyPasswordField))
        } else {
            Auth.auth().createUser(withEmail: userLogin, password: userPassword) { authResult, error in
                DispatchQueue.main.async {
                    if let error = error as NSError? {
                        if let errorCode = error.userInfo["FIRAuthErrorUserInfoNameKey"] as? String {
                            if errorCode == "ERROR_WEAK_PASSWORD" {
                                self.delegate?.loginFailed(result: .failure(.weakPassword))
                            } else {
                                self.delegate?.loginFailed(result: .failure(.errorNotDefined))
                            }
                        }
                    } else if let authResultData = authResult {
                        // Пользователь успешно создан
                        let user = User(uid: authResultData.user.uid, email: userLogin)
                        FirebaseDatabaseManager().createUser(user: user) { success in
                            if success {
                                print("User added to database")
                            } else {
                                print("Failed to add user to database")
                            }
                        }
                        print("Пользователь создан: \(authResult?.user.uid ?? "")")
                        self.delegate?.userNameRequest(uid: authResult?.user.uid ?? "")
                        //                        self.delegate?.successLogin()
                    } else {
                        self.delegate?.loginFailed(result: .failure(.errorNotDefined))
                    }
                }
            }
        }
    }
    
    func updateUsername(uid: String, newUsername: String) {
        let firebaseDatabaseManager = FirebaseDatabaseManager()
        firebaseDatabaseManager.getUserData(uid: uid) { user in
            guard var user = user else {
                print("User not found")
                return
            }
            
            user.username = newUsername
            
            firebaseDatabaseManager.updateUserData(user: user) { success in
                if success {
                    print("Username updated successfully")
                } else {
                    print("Failed to update username")
                }
            }
        }
    }
    
    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                completion(.success(()))
                self.mainCoordinatorDelegate?.startApplication()
            }
        } catch let signOutError {
            DispatchQueue.main.async {
                completion(.failure(signOutError))
            }
        }
    }
}
