//
//  UserCoordinator.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public enum UserSteps: Step {
  case main(userId: String)
  case didFinish
}

public protocol UserCoordinatorDelegate: class {
  func userCoordinatorDidFinish()
}

public class UserCoordinator: NavigationCoordinator {
  public var navigationController: UINavigationController

  private let container: UserContainerProtocol

  weak var delegate: UserCoordinatorDelegate?

  // MARK: - Life Cycle
  public init(navigationController: UINavigationController, container: UserContainerProtocol) {
    self.navigationController = navigationController
    self.container = container
  }

  deinit {
    print("Deinit Coordinator 🚀 [\(Self.self)]")
  }

  public func start(with step: Step) {
    navigateTo(step: step)
  }

  private func navigateTo(step: Step) {
    guard let step = step as? UserSteps else { return }

    switch step {
    case .main(let userId):
      showUserProfile(userId: userId)
    case .didFinish:
      stop()
    }
  }

  private func showUserProfile(userId: String) {
    let userView = container.buildUserView(with: userId)
    userView.nextAction = { [weak self] in
      self?.navigationController.popViewController(animated: true)
      self?.navigateTo(step: UserSteps.didFinish)
    }
    userView.viewDidFinish = { [weak self] in
      self?.navigateTo(step: UserSteps.didFinish)
    }
    navigationController.pushViewController(userView, animated: true)
  }

  public func stop() {
    delegate?.userCoordinatorDidFinish()
  }
}
