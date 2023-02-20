//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 20.02.2023.
//

import LocalAuthentication

enum TypeOfBiometric {
    case FaceID
    case TouchID
}

enum AuthorizationResult {
    case success
    case failure(String)
}

class LocalAuthorizationService {
    
    let context = LAContext()
    var error: NSError?
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (AuthorizationResult) -> Void){
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            var errorText: String
            if let errorExist = error {
                errorText = errorExist.description
            } else {
                errorText = "biometric_authorization_denied".localized
            }
            authorizationFinished(.failure(errorText))
            return
        }
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "biometric_authorization_reason".localized) { success, error in
            if success {
                DispatchQueue.main.async {
                    authorizationFinished(.success)
                }
            } else {
                DispatchQueue.main.async {
                    authorizationFinished(.failure(error?.localizedDescription ?? ""))
                }
            }
        }
    }
    
    func getTypeOfBiometric() -> TypeOfBiometric? {
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            switch context.biometryType {
            case .faceID:
                return .FaceID
            case .touchID:
                return .TouchID
            case .none:
                return nil
            @unknown default:
                return nil
            }
        } else {
            return nil
        }
    }

}
