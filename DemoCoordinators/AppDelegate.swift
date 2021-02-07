//
//  AppDelegate.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 2/07/21.
//  Copyright © 2020 Jeans. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  var appCoordinator: AppCoordinator?

  let appContainer = AppDIContainer()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    appCoordinator = AppCoordinator(window: window!, appDIContainer: appContainer)
    window?.makeKeyAndVisible()
    appCoordinator?.start()
    return true
  }

}
