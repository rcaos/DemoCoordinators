//
//  Coordinator.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 7/02/21.
//  Copyright © 2021 Jeans. All rights reserved.
//

import Foundation

public protocol Coordinator: class {

  func start(with step: Step)

  func start()

  func stop()
}

public extension Coordinator {

  func start(with step: Step) { }

  func start() { }

  func stop() { }
}

public protocol Step { }

public struct DefaultStep: Step {
  public init() { }
}
