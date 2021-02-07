//
//  UserContainer.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public protocol UserContainerProtocol {
  func buildUserView(with userId: String) -> NextViewController
}

public class UserContainer: UserContainerProtocol {

  public init() {
    // This is the opportunity for inject dependencies from AppDiContainer to User Feature
  }

  public func buildUserView(with userId: String) -> NextViewController {
    // MARK: - here you can Inject dependencies to ViewController
    let mainViewC = NextViewController(captionMessage: "User View id: [\(userId)]",
                                       actionMessage: "Back to Coordinator",
                                       backGroundColor: .groupTableViewBackground,
                                       imageName: userId)
    return mainViewC
  }
}
