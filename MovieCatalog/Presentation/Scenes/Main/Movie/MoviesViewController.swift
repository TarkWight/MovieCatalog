//
//  MoviesViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import UIKit

final class MoviesViewController: BaseViewController {
    private let viewModel: MoviesViewModel

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle("Movies")
        viewModel.handle(.fetchMovies)
    }
}
