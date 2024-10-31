//
//  FeedViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

final class FeedViewController: UIViewController {
    private let viewModel: FeedViewModel
    
    public init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.title = NSLocalizedString("feed", comment: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
