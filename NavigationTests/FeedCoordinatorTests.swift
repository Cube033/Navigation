//
//  FeedCoordinatorTests.swift
//  NavigationTests
//
//  Created by Дмитрий Федотов on 17.02.2023.
//

import XCTest
@testable import Navigation

class FeedCoordinatorTests: XCTestCase {
    
    let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
    
    func testGetStartViewController() {
        let rootController = feedCoordinator.getStartViewController()
        XCTAssert(rootController is FeedNavigationController)
    }
    
    func testHandleAction() {
        feedCoordinator.handleAction(actionType: FeedActionType.feed)
        XCTAssert(feedCoordinator.currentViewController is FeedNavigationController)
        feedCoordinator.handleAction(actionType: FeedActionType.post)
        XCTAssert(feedCoordinator.currentViewController is PostViewController)
        feedCoordinator.handleAction(actionType: FeedActionType.alert)
        XCTAssert(feedCoordinator.currentViewController is InfoViewController)
        feedCoordinator.handleAction(actionType: FeedActionType.videoPlayer)
        XCTAssert(feedCoordinator.currentViewController is VideoPlayerViewController)
        feedCoordinator.handleAction(actionType: FeedActionType.mapViewController)
        XCTAssert(feedCoordinator.currentViewController is MapViewController)
    }
}
