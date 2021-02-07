//
//  NextViewController.swift
//  DemoCoordinators
//
//  Created by Jeans Ruiz on 2/07/21.
//  Copyright © 2020 Jeans. All rights reserved.
//

import UIKit

public class NextViewController: UIViewController {

  var nextAction: (() -> Void)?

  var viewDidFinish: (() -> Void)?

  private let captionMessage: String

  private let actionMessage: String

  private let backGroundColor: UIColor

  private let imageName: String?

  // MARK: - UI elements
  private lazy var captionLabel: UILabel = {
    let captionLabel = UILabel(frame: .zero)
    captionLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    captionLabel.textAlignment = .center
    return captionLabel
  }()

  private lazy var imageAvatar: UIImageView? = {
    guard let imageName = imageName else { return nil }
    let image = UIImage(named: imageName)
    let imageView = UIImageView(image: image)
    return imageView
  }()

  private lazy var nextButton: UIButton = {
    let nextButton = UIButton(frame: .zero)
    nextButton.backgroundColor = .systemBlue
    return nextButton
  }()

  // MARK: - Initializers
  init(captionMessage: String, actionMessage: String, backGroundColor: UIColor, imageName: String? = nil) {
    self.captionMessage = captionMessage
    self.actionMessage = actionMessage
    self.backGroundColor = backGroundColor
    self.imageName = imageName
    super.init(nibName: nil, bundle: nil)
  }

  deinit {
    print("Deinit 🔥 \(Self.self)")
    viewDidFinish?()
  }

  required init?(coder: NSCoder) {
    fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
  }

  public override func loadView() {
    view = UIView(frame: .zero)
    view.backgroundColor = backGroundColor
    setupUI()
  }

  private func setupUI() {
    addHierarchy()
    addConstraints()
    setupLabel()
    setupNextButton()
  }

  private func addHierarchy() {
    view.addSubview(captionLabel)
    if let image = imageAvatar {
      view.addSubview(image)
    }
    view.addSubview(nextButton)
  }

  private func addConstraints() {
    addConstraintsForLabel()
    addConstrainsImageAvatar()
    addConstraintsForButton()
  }

  private func addConstraintsForLabel() {
    captionLabel.translatesAutoresizingMaskIntoConstraints = false

    var bottomAnchor = NSLayoutConstraint.init()
    if let image = imageAvatar {
      bottomAnchor = captionLabel.bottomAnchor.constraint(equalTo: image.topAnchor, constant: -20)
    } else {
      bottomAnchor = captionLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -50)
    }

    NSLayoutConstraint.activate([
      captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      bottomAnchor
    ])
  }

  private func addConstrainsImageAvatar() {
    guard let image = imageAvatar else { return }
    image.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      image.heightAnchor.constraint(equalToConstant: 113),
      image.widthAnchor.constraint(equalToConstant: 150),
      image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      image.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20)
    ])
  }

  private func addConstraintsForButton() {
    nextButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nextButton.heightAnchor.constraint(equalToConstant: 50),
      nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
      nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
      nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }

  private func setupLabel() {
    captionLabel.text = captionMessage
  }

  private func setupNextButton() {
    nextButton.setTitle(actionMessage, for: .normal)
    nextButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
  }

  @objc private func buttonAction() {
    nextAction?()
  }
}
