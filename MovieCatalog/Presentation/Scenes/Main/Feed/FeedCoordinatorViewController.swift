//
//  FeedCoordinatorViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//

import UIKit

final class FeedCoordinatorViewController: UIViewController {
    
    // MARK: - Properties
    private let coordinator: FeedCoordinator
    private let feedFactory: FeedSceneFactory
    private var feedViewController: FeedViewController?
    
    // MARK: - Initializer
    init(
        coordinator: FeedCoordinator,
        feedFactory: FeedSceneFactory
    ) {
        self.coordinator = coordinator
        self.feedFactory = feedFactory
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
        let feedViewController = feedFactory.makeFeedScene(coordinator: coordinator)
        self.feedViewController = feedViewController
        
        addChild(feedViewController)
        view.addSubview(feedViewController.view)
        feedViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            feedViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        feedViewController.didMove(toParent: self)
    }
}
