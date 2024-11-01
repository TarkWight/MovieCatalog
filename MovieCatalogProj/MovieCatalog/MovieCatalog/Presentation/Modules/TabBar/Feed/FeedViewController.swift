//
//  FeedViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

final class FeedViewController: UIViewController {
    private let viewModel = FeedViewModel()
    
    private let loadingView = UIActivityIndicatorView(style: .large)
    private let movieCardView = MovieCardView()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.fetchRandomMovie()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "AppDark")
        
        view.addSubview(logoImageView)
        view.addSubview(loadingView)
        view.addSubview(movieCardView)
        
        loadingView.center = view.center
        loadingView.startAnimating()
        
        movieCardView.isHidden = true
        movieCardView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:))))
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        movieCardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 78),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 60.72),
            logoImageView.heightAnchor.constraint(equalToConstant: 32),
            
            movieCardView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            movieCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            movieCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            movieCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        ])
    }
    
    private func setupBindings() {
        viewModel.onLoading = { [weak self] isLoading in
            self?.loadingView.isHidden = !isLoading
            self?.movieCardView.isHidden = isLoading
        }
        
        viewModel.onMoviesFetched = { [weak self] movie in
            self?.movieCardView.configure(with: movie)
        }
        
        viewModel.onError = { error in
            print("Error: \(error)")
        }
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let movie = movieCardView.movie, let movieId = movie.id else {
            print("Movie ID is nil.")
            return
        }
        
        if gesture.direction == .right {
            print("direction == .right, id is \(movieId)")
            viewModel.addFavoriteMovie(movieId)
        } else if gesture.direction == .left {
            print("direction == .left, id is \(movieId)")
            viewModel.hideMovie(movieId)
        }
    }
}
