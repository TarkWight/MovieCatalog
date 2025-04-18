//
//  AuthCoordinatorViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//


import UIKit

class AuthCoordinatorViewController: UIViewController {

    private let coordinator: AuthCoordinator

    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        coordinator.showWelcome()
    }

    private func setupView() {
        view.backgroundColor = .white
    }
}
