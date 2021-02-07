//
//  SignedCoordinator.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public enum SignedChildCoordinator {
  case
    recents,
    contacts
}

public enum SignedSteps: Step {
  case main
       //showUserProfile(userId: String)  // From a Notification Maybe?
}

public class SignedCoordinator: Coordinator {

  private var tabBarController: UITabBarController

  private var childCoordinators = [SignedChildCoordinator: Coordinator]()

  private let signedContainer: SignedContainerProtocol

  // MARK: - Life Cycle
  public init(tabBarController: UITabBarController, signedContainer: SignedContainerProtocol) {
    self.tabBarController = tabBarController
    self.signedContainer = signedContainer
  }

  public func start() {
    navigateTo(step: SignedSteps.main)
  }

  private func navigateTo(step: Step) {
    guard let step = step as? SignedSteps else { return }

    switch step {
    case .main:
      showMainFeatures()
    }
  }

  private func showMainFeatures() {
    let recentsNavigation = UINavigationController()
    recentsNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
    let recentsCoordinator = signedContainer.buildRecentsCoordinator(in: recentsNavigation)
    childCoordinators[.recents] = recentsCoordinator

    let contactsNavigation = UINavigationController()
    contactsNavigation.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
    let contactsCoordinator = signedContainer.buildContactsCoordinator(in: contactsNavigation)
    childCoordinators[.contacts] = contactsCoordinator

    tabBarController.setViewControllers([recentsNavigation, contactsNavigation],
                                        animated: true)
    recentsCoordinator.start()
    contactsCoordinator.start()
  }
}
