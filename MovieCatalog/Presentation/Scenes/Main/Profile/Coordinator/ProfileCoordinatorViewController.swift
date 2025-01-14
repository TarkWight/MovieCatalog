//
//  ProfileCoordinatorViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//

import UIKit

final class ProfileCoordinatorViewController: UIViewController {
    // MARK: - Properties
    private let coordinator: ProfileCoordinatorProtocol
    private let profileFactory: ProfileSceneFactory
    private var profileViewController: ProfileViewController?

    // MARK: - Initializer
    init(
        coordinator: ProfileCoordinatorProtocol,
        profileFactory: ProfileSceneFactory
    ) {
        self.coordinator = coordinator
        self.profileFactory = profileFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupChildViewController()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: "AppDark")
    }

    private func setupChildViewController() {
        let profileViewController = profileFactory.makeProfileScene(coordinator: coordinator)
        self.profileViewController = profileViewController

        addChild(profileViewController)
        view.addSubview(profileViewController.view)
        profileViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            profileViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        profileViewController.didMove(toParent: self)
    }
}
