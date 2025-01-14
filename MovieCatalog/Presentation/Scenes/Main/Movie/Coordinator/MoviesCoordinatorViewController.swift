//
//  MoviesCoordinatorViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 14.01.2025.
//


import UIKit

final class MoviesCoordinatorViewController: UIViewController {
    // MARK: - Properties
    private let coordinator: MoviesCoordinatorProtocol
    private let moviesFactory: MoviesSceneFactory
    private var moviesViewController: MoviesViewController?

    // MARK: - Initializer
    init(
        coordinator: MoviesCoordinatorProtocol,
        moviesFactory: MoviesSceneFactory
    ) {
        self.coordinator = coordinator
        self.moviesFactory = moviesFactory
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
        let moviesViewController = moviesFactory.makeMoviesScene(coordinator: coordinator)
        self.moviesViewController = moviesViewController

        addChild(moviesViewController)
        view.addSubview(moviesViewController.view)
        moviesViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            moviesViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            moviesViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        moviesViewController.didMove(toParent: self)
    }
}