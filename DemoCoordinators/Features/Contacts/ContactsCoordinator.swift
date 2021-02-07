//
//  ContactsCoordinator.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public enum ContactsChildCoordinator {
  case
    userProfile
}

public enum ContactsSteps: Step {
  case main,
       detail,
       userProfile(userId: String),
       userProfileFromNotification(userId: String)
}

public class ContactsCoordinator: NavigationCoordinator {
  public var navigationController: UINavigationController

  private var childCoordinators = [ContactsChildCoordinator: Coordinator]()

  private let container: ContactsContainerProtocol

  // MARK: - Life Cycle
  public init(navigationController: UINavigationController, container: ContactsContainerProtocol) {
    self.navigationController = navigationController
    self.container = container
  }

  public func start() {
    navigateTo(step: ContactsSteps.main)
  }

  public func start(with step: Step) {
    navigateTo(step: step)
  }

  private func navigateTo(step: Step) {
    guard let step = step as? ContactsSteps else { return }

    switch step {
    case .main:
      showContactsMain()
    case .detail:
      showContactsDetail()
    case .userProfile(let userId):
      showUserProfile(userId: userId)
    case .userProfileFromNotification(userId: let userId):
      break
      // navigateToUserProfile()
    }
  }

  private func showContactsMain() {
    let mainViewC = container.buildContactsView()
    mainViewC.nextAction = { [weak self] in
      self?.navigateTo(step: ContactsSteps.detail)
    }
    navigationController.pushViewController(mainViewC, animated: true)
  }

  private func showContactsDetail() {
    let detailVC = container.buildContactsDetailView()
    detailVC.nextAction = { [weak self] in
      // Here you can capture Any value that ViewController sends to Coordinator
      self?.navigateTo(step: ContactsSteps.userProfile(userId: "Milhouse"))
    }
    navigationController.pushViewController(detailVC, animated: true)
  }

  private func showUserProfile(userId: String) {
    let userCoordinator = container.buildUserCoordinator(in: navigationController)
    userCoordinator.delegate = self
    childCoordinators[.userProfile] = userCoordinator
    userCoordinator.start(with:
                            UserSteps.main(userId: userId))
  }
}

// MARK: - UserCoordinatorDelegate
extension ContactsCoordinator: UserCoordinatorDelegate {

  public func userCoordinatorDidFinish() {
    childCoordinators[.userProfile] = nil
  }
}
