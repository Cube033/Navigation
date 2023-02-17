//
//  ProfileCoordinatorTests.swift
//  NavigationTests
//
//  Created by Дмитрий Федотов on 17.02.2023.
//

import XCTest
@testable import Navigation

class ProfileCoordinatorTests: XCTestCase {
    
    let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    
    func testGetStartViewController() {
        XCTAssert(setMockUser())
        let rootController = profileCoordinator.getStartViewController()
        XCTAssert(rootController is ProfileViewController)
    }
    
    func setMockUser() -> Bool {
        let currentUser: User?
        let userSevice = CurrentUserService()
        currentUser = userSevice.getUserByLogin(login: "cube033")
        if let mockUser = currentUser {
            UserInfo.shared.user = mockUser
            return true
        } else {
            return false
        }
    }
    
    func testHandleAction() {
        profileCoordinator.handleAction(actionType: ProfileActionType.gallery)
        XCTAssert(profileCoordinator.currentViewController is PhotosViewController)
        profileCoordinator.handleAction(actionType: ProfileActionType.profile)
        XCTAssert(profileCoordinator.currentViewController is ProfileViewController)
    }
}
