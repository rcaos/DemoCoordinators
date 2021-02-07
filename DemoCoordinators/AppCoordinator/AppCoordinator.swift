//
//  AppCoordinator.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public enum AppChildCoordinator {
  case signed
  // case signUp,
  // case onboarding, etc
}

class AppCoordinator: Coordinator {

  private let window: UIWindow

  private var childCoordinators = [AppChildCoordinator: Coordinator]()

  private let appDIContainer: AppDIContainer

  // MARK: - Initializer
  public init(window: UIWindow, appDIContainer: AppDIContainer) {
    self.window = window
    self.appDIContainer = appDIContainer
  }

  func start() {
    nagivateToSignedFlow()
  }

  private func nagivateToSignedFlow() {
    let tabBar = UITabBarController()
    let coordinator = SignedCoordinator(tabBarController: tabBar,
                                        signedContainer: SignedContainer())

    self.window.rootViewController = tabBar
    self.window.makeKeyAndVisible()

    childCoordinators[.signed] = coordinator
    coordinator.start()
  }
}
