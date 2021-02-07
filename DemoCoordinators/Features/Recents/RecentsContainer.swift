//
//  RecentsContainer.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public protocol RecentsContainerProtocol {
  func buildRecentsView() -> NextViewController

  func buildRecentsDetailView() -> NextViewController

  func buildUserCoordinator(in navigation: UINavigationController) -> UserCoordinator
}

public class RecentsContainer: RecentsContainerProtocol {

  public init() {
    // This is the opportunity for inject dependencies from AppDiContainer to RecentsContainer
  }

  public func buildRecentsView() -> NextViewController {
    // MARK: - here Inject dependencies to ViewController
    let mainViewC = NextViewController(captionMessage: "Recents View 1",
                                       actionMessage: "Got to Recents Details",
                                       backGroundColor: .cyan)
    return mainViewC
  }

  public func buildRecentsDetailView() -> NextViewController {
    // MARK: - here Inject dependencies to ViewController
    let detailVC = NextViewController(captionMessage: "Detail view 2",
                                      actionMessage: "Go to User Profile",
                                      backGroundColor: .cyan)
    return detailVC
  }

  public func buildUserCoordinator(in navigation: UINavigationController) -> UserCoordinator {
    return UserCoordinator(navigationController: navigation, container: UserContainer())
  }
}
