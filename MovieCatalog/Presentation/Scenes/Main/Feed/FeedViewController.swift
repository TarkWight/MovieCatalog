//
//  FeedViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

final class FeedViewController: BaseViewController {
    private let viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Лента"
        
    }
    
    private func bindViewModel() {
        viewModel.handle(.fetchFeed)
    }
}
