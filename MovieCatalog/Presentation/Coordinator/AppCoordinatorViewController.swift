//
//  AppCoordinatorViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import UIKit

final class AppCoordinatorViewController: UIViewController {

    private let coordinator: AppCoordinator

    // MARK: - Initializer
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        handleAuthorization()
    }

    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .white
        setupLoadingIndicator()
    }

    private func setupLoadingIndicator() {
        let loadingView = UIActivityIndicatorView(style: .large)
        loadingView.center = view.center
        view.addSubview(loadingView)
        loadingView.startAnimating()
    }

    private func handleAuthorization() {
        if coordinatorHasValidToken() {
            coordinator.showMainScene()
        } else {
            coordinator.showAuthScene()
        }
    }

    private func coordinatorHasValidToken() -> Bool {
        do {
            let _ = try coordinator.networkService.keychainService.retrieveToken()
            return true
        } catch {
            return false
        }
    }
}
