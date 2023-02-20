//
//  MainCoordinatorTests.swift
//  NavigationTests
//
//  Created by Дмитрий Федотов on 16.02.2023.
//

import XCTest
@testable import Navigation

class MainCoordinatorTests: XCTestCase{
    
    func testStartApplication() {
        let mockWindow = UIWindow()
        let mainCoordinator = MainCoordinator(window: mockWindow)
        
        UserInfo.shared.loggedIn = true
        mainCoordinator.startApplication()
        XCTAssertNotNil(mainCoordinator.window)
        XCTAssert(mainCoordinator.window?.rootViewController is MainTabBarViewController)
        
        UserInfo.shared.loggedIn = false
        mainCoordinator.startApplication()
        XCTAssertNotNil(mainCoordinator.window)
        XCTAssert(mainCoordinator.window?.rootViewController is LogInViewController)
    }
}
