//
//  ContactsContainer.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public protocol ContactsContainerProtocol {
  func buildContactsView() -> NextViewController

  func buildContactsDetailView() -> NextViewController

  func buildUserCoordinator(in navigation: UINavigationController) -> UserCoordinator
}

public class ContactsContainer: ContactsContainerProtocol {

  public init() {
    // This is the opportunity for inject dependencies from AppDiContainer to ContactsContainer
  }

  public func buildContactsView() -> NextViewController {
    // MARK: - Here Inject dependencies to ViewController
    let mainViewC = NextViewController(captionMessage: "Contacts View",
                                       actionMessage: "Got to Contacts Details",
                                       backGroundColor: .systemGreen)
    return mainViewC
  }

  public func buildContactsDetailView() -> NextViewController {
    // MARK: - Here Inject dependencies to ViewController
    let detailVC = NextViewController(captionMessage: "Detail Contacts view 2",
                                      actionMessage: "Go Back User Profile",
                                      backGroundColor: .systemGreen)
    return detailVC
  }

  public func buildUserCoordinator(in navigation: UINavigationController) -> UserCoordinator {
    return UserCoordinator(navigationController: navigation, container: UserContainer())
  }
}
