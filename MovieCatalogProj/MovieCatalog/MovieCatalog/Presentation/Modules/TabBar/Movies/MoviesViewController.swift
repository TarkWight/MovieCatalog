//
//  MoviesViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

final class MoviesViewController: UIViewController {
    private let viewModel: MoviesViewModel
    private let moviesCarousel: UICollectionView
    private let favoritesCarousel: UICollectionView
    private let allMoviesList: UICollectionView
    private let randomMovieButton = UIButton()
    private let progressBarStack = UIStackView()
    private var autoScrollTimer: Timer?
    private var currentCarouselIndex = 0

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel

        // Инициализация каруселей
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        moviesCarousel = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        
        favoritesCarousel = UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
        
        let gridLayout = UICollectionViewFlowLayout()
        gridLayout.scrollDirection = .vertical
        allMoviesList = UICollectionView(frame: .zero, collectionViewLayout: gridLayout)

        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.title = NSLocalizedString("movies", comment: "")

        setupUI()
        setupBindings()
        viewModel.loadInitialMovies()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        setupProgressBar()
        setupCarousel(moviesCarousel, cellType: MovieCarouselCell.self, identifier: "movieCell")
        setupCarousel(favoritesCarousel, cellType: FavoriteCarouselCell.self, identifier: "favoriteCell")
        setupAllMoviesList()
        setupRandomMovieButton()
        setupConstraints()
    }

    private func setupProgressBar() {
        progressBarStack.axis = .horizontal
        progressBarStack.spacing = 4
        for _ in 0..<5 {
            let bar = UIView()
            bar.layer.cornerRadius = 2
            bar.clipsToBounds = true
            progressBarStack.addArrangedSubview(bar)
        }
        view.addSubview(progressBarStack)
    }

    private func setupCarousel(_ carousel: UICollectionView, cellType: UICollectionViewCell.Type, identifier: String) {
        carousel.register(cellType, forCellWithReuseIdentifier: identifier)
        carousel.dataSource = self
        carousel.delegate = self
        carousel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(carousel)
    }

    private func setupAllMoviesList() {
        allMoviesList.register(AllMoviesCell.self, forCellWithReuseIdentifier: "allMoviesCell")
        allMoviesList.dataSource = self
        allMoviesList.delegate = self
        allMoviesList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(allMoviesList)
    }

    private func setupRandomMovieButton() {
        randomMovieButton.setImage(UIImage(named: "game_die"), for: .normal)
        randomMovieButton.setTitle(NSLocalizedString("random_movie", comment: ""), for: .normal)
        randomMovieButton.addTarget(self, action: #selector(showRandomMovie), for: .touchUpInside)
        view.addSubview(randomMovieButton)
    }

    private func setupConstraints() {
        progressBarStack.translatesAutoresizingMaskIntoConstraints = false
        randomMovieButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressBarStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressBarStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            progressBarStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            progressBarStack.heightAnchor.constraint(equalToConstant: 4),
            
            moviesCarousel.topAnchor.constraint(equalTo: progressBarStack.bottomAnchor, constant: 10),
            moviesCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesCarousel.heightAnchor.constraint(equalToConstant: 180),
            
            favoritesCarousel.topAnchor.constraint(equalTo: moviesCarousel.bottomAnchor, constant: 20),
            favoritesCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesCarousel.heightAnchor.constraint(equalToConstant: 180),

            randomMovieButton.topAnchor.constraint(equalTo: favoritesCarousel.bottomAnchor, constant: 20),
            randomMovieButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            allMoviesList.topAnchor.constraint(equalTo: randomMovieButton.bottomAnchor, constant: 20),
            allMoviesList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            allMoviesList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            allMoviesList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupBindings() {
        viewModel.onMoviesUpdate = { [weak self] movies in
            DispatchQueue.main.async {
                self?.moviesCarousel.reloadData()
                self?.allMoviesList.reloadData()
                self?.startAutoScroll()
            }
        }
        
        viewModel.onFavoriteMoviesUpdate = { [weak self] movies in
            DispatchQueue.main.async {
                self?.favoritesCarousel.reloadData()
            }
        }
        
        viewModel.onError = { [weak self] error in
            print("Error: \(error)")
        }
    }

    private func startAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.autoScrollMoviesCarousel()
        }
    }

    private func autoScrollMoviesCarousel() {
        guard viewModel.allMovies.count > 1 else { return }
        
        currentCarouselIndex = (currentCarouselIndex + 1) % viewModel.allMovies.count
        let nextIndexPath = IndexPath(item: currentCarouselIndex, section: 0)
        
        // Проверка, что индекс не выходит за границы items в коллекции
        if currentCarouselIndex < moviesCarousel.numberOfItems(inSection: 0) {
            moviesCarousel.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            updateProgressBar()
        }
    }




    private func updateProgressBar() {
        progressBarStack.arrangedSubviews.enumerated().forEach { index, bar in
            if let barView = bar as? UIView {
                let isActive = index == currentCarouselIndex
                barView.applyGradient(
                    colors: isActive ? [UIColor.red, UIColor.orange] : [UIColor.lightGray, UIColor.lightGray],
                    frame: barView.bounds
                )
            }
        }
    }


    @objc private func showRandomMovie() {
        // Ваш код для показа случайного фильма
        print("Random Movie button tapped")
    }
    
    deinit {
        autoScrollTimer?.invalidate()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesCarousel {
            return min(viewModel.allMovies.count, 5)
        } else if collectionView == favoritesCarousel {
            return viewModel.favoriteMovies.count
        } else {
            return viewModel.allMovies.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == moviesCarousel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCarouselCell
            cell.configure(with: viewModel.allMovies[indexPath.item])
            return cell
        } else if collectionView == favoritesCarousel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCarouselCell
            cell.configure(with: viewModel.favoriteMovies[indexPath.item])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allMoviesCell", for: indexPath) as! AllMoviesCell
            cell.configure(with: viewModel.allMovies[indexPath.item])
            return cell
        }
    }
}
