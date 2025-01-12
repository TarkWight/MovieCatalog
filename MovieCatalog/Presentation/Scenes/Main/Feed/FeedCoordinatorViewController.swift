//
//  FeedCoordinatorViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//

import UIKit

final class FeedCoordinatorViewController: UIViewController {
    
    private let coordinator: FeedCoordinator
    private let feedFactory: FeedSceneFactory
    
    
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
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
