//
//  SignedContainer.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public protocol SignedContainerProtocol {
  func buildRecentsCoordinator(in navigation: UINavigationController) -> Coordinator

  func buildContactsCoordinator(in navigation: UINavigationController) -> Coordinator
}

public class SignedContainer: SignedContainerProtocol {

  public init() {
    // This is the opportunity for inject dependencies to Signed Coordinator
  }

  /// Here we can inject any dependencies to Recents Coordinator
  public func buildRecentsCoordinator(in navigation: UINavigationController) -> Coordinator {
    let recentsCoordinator = RecentsCoordinator(navigationController: navigation,
                                                container: RecentsContainer())
    return recentsCoordinator
  }

  /// Here we can inject any dependencies to Contacts Coordinator
  public func buildContactsCoordinator(in navigation: UINavigationController) -> Coordinator {
    let contactsCoordinator = ContactsCoordinator(navigationController: navigation, container: ContactsContainer())
    return contactsCoordinator
  }
}
