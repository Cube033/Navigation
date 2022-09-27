//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Дмитрий Федотов on 26.09.2022.
//

import Foundation
import StorageService

final class ProfileViewModel {
    enum Action {
        case viewReady
        case cellDidTap
        case getIdle
    }
    
    enum State {
        case initial
        case loading
        case loaded
        case idle
        case error
    }
    
    private let coordinator: ProfileCoordinator
    let user: User
    let postArray = Post.getPostArray()
    
    
    var stateChanged: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }
    
    init(coordinator: ProfileCoordinator,
         user: User)
    {
        self.coordinator = coordinator
        self.user = user
    }
    
    func changeState(action: Action) {
        switch action {
        case .viewReady:
            state = .loaded
        case .cellDidTap:
            coordinator.handleAction(actionType: ProfileActionType.gallery)
            self.changeState(action: .getIdle)
        case .getIdle:
            state = .idle
        }
    }
}
