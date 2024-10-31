//
//  MoviesViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

final class MoviesViewController: UIViewController {
    private let viewModel: MoviesViewModel
    
    public init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.title = NSLocalizedString("movies", comment: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
