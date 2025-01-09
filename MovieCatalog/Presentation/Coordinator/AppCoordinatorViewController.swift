//  AppCoordinatorViewController.swift
//  MovieCatalog
//  Created by Tark Wight on 07.01.2025.

import UIKit

class AppCoordinatorViewController: UIViewController, AppCoordinatorDelegate {

    private let coordinator: AppCoordinator

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        coordinator.delegate = self
        coordinator.start()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    // MARK: - AppCoordinatorDelegate

    func didTransitionToAuthScene() {
        let authCoordinator = AuthCoordinator(
            navigationController: coordinator.navigationController,
            sceneFactory: SceneFactory(appFactory: AppFactory())
        )
        authCoordinator.start()
    }

    func didTransitionToLoading() {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.center = view.center
        view.addSubview(loadingView)
        loadingView.startAnimating()
    }
}
