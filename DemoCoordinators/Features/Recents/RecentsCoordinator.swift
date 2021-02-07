//
//  RecentsCoordinator.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public enum RecentsChildCoordinator: Hashable {
  case userProfile
}

public enum RecentsSteps: Step {
  case main,
       detail,
       userProfile(userId: String)
}

public class RecentsCoordinator: NavigationCoordinator {
  public var navigationController: UINavigationController

  private var childCoordinators = [RecentsChildCoordinator: Coordinator]()

  private let container: RecentsContainerProtocol

  // MARK: - Life Cycle
  public init(navigationController: UINavigationController, container: RecentsContainerProtocol) {
    self.navigationController = navigationController
    self.container = container
  }

  public func start() {
    navigateTo(step: RecentsSteps.main)
  }

  private func navigateTo(step: Step) {
    guard let step = step as? RecentsSteps else { return }

    switch step {
    case .main:
      showRecentsMain()
    case .detail:
      showRecentsDetail()
    case .userProfile(let userId):
      showUserProfile(userId: userId)
    }
  }

  private func showRecentsMain() {
    let mainViewC = container.buildRecentsView()
    mainViewC.nextAction = { [weak self] in
      self?.navigateTo(step: RecentsSteps.detail)
    }
    navigationController.pushViewController(mainViewC, animated: true)
  }

  private func showRecentsDetail() {
    let detailVC = container.buildRecentsDetailView()
    detailVC.nextAction = { [weak self] in
      // Here you can capture Any value that ViewController sends to Coordinator
      self?.navigateTo(step: RecentsSteps.userProfile(userId: "Nelson"))
    }
    navigationController.pushViewController(detailVC, animated: true)
  }

  private func showUserProfile(userId: String) {
    let userCoordinator = container.buildUserCoordinator(in: navigationController)
    childCoordinators[.userProfile] = userCoordinator
    userCoordinator.delegate = self
    userCoordinator.start(with:
                            UserSteps.main(userId: userId))
  }
}

// MARK: - UserCoordinatorDelegate
extension RecentsCoordinator: UserCoordinatorDelegate {

  public func userCoordinatorDidFinish() {
    childCoordinators[.userProfile] = nil
  }
}
