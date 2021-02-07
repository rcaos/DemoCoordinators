//
//  NavigationCoordinator.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import UIKit

public protocol NavigationCoordinator: Coordinator {

  var navigationController: UINavigationController { get }

}
