//
//  FeedViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

final class FeedViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: FeedViewModel
    private var currentCardView = MovieCardView()
    private var nextCardView = MovieCardView()

    // MARK: - UI Elements
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.Images.logo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Layout.movieInfoStackSpacing
        stackView.alignment = .center
        return stackView
    }()

    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.movieTitle
        label.textColor = UIColor(named: Constants.Colors.movieTitle)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let movieSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.movieSubtitle
        label.textColor = UIColor(named: Constants.Colors.movieSubtitle)
        label.textAlignment = .center
        return label
    }()

    private let tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.Layout.tagsSpacing
        stackView.alignment = .center
        return stackView
    }()

    private let loadingView = UIActivityIndicatorView(style: .large)

    // MARK: - Initializer
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        hideBackButton()
        super.viewDidLoad()
        setupUI()
        setupGestures()
        bindViewModel()
        viewModel.handle(.fetchInitialMovies)
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: Constants.Colors.background)

        view.addSubview(logoImageView)
        view.addSubview(nextCardView)
        view.addSubview(currentCardView)
        view.addSubview(movieInfoStackView)
        view.addSubview(loadingView)

        movieInfoStackView.addArrangedSubview(movieTitleLabel)
        movieInfoStackView.addArrangedSubview(movieSubtitleLabel)
        movieInfoStackView.addArrangedSubview(tagsStackView)

        setupConstraints()

        loadingView.center = view.center
        loadingView.startAnimating()
        currentCardView.isHidden = true
        nextCardView.isHidden = true
    }

    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        currentCardView.translatesAutoresizingMaskIntoConstraints = false
        nextCardView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Layout.logoTopPadding),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.logoWidth),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.logoHeight),

            currentCardView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.Layout.cardTopPadding),
            currentCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            currentCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            currentCardView.heightAnchor.constraint(equalTo: currentCardView.widthAnchor, multiplier: Constants.Layout.cardHeightMultiplier),

            nextCardView.topAnchor.constraint(equalTo: currentCardView.topAnchor),
            nextCardView.leadingAnchor.constraint(equalTo: currentCardView.leadingAnchor),
            nextCardView.trailingAnchor.constraint(equalTo: currentCardView.trailingAnchor),
            nextCardView.bottomAnchor.constraint(equalTo: currentCardView.bottomAnchor),

            movieInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            movieInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            movieInfoStackView.topAnchor.constraint(equalTo: currentCardView.bottomAnchor, constant: Constants.Layout.movieInfoTopPadding),

            tagsStackView.heightAnchor.constraint(equalToConstant: 28),
            tagsStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            tagsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            tagsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Layout.tagsBottomPadding)
        ])
    }

    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        currentCardView.addGestureRecognizer(panGesture)
    }

    // MARK: - ViewModel Binding
    private func bindViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            self.loadingView.isHidden = !isLoading
            self.currentCardView.isHidden = isLoading
            self.nextCardView.isHidden = isLoading
        }

        viewModel.onViewDataUpdated = { [weak self] viewData in
            guard let self else { return }
            guard let movie = viewData.cardItems.first else { return }
            self.configureCards(with: movie)
        }
    }

    // MARK: - Card Configuration
    private func configureCards(with movie: MovieDetailsItemViewModel) {
        logoImageView.isHidden = true
        
        currentCardView.configure(with: movie.posterURL ?? "")
        movieTitleLabel.text = movie.title
        movieSubtitleLabel.text = "\(movie.country) • \(movie.year)"

        if let nextMovie = viewModel.getNextMovie() {
            nextCardView.configure(with: nextMovie.poster ?? "")
        }

        tagsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for genre in movie.genres {
            let tagView = TagView(text: genre.name ?? "")
            tagsStackView.addArrangedSubview(tagView)
        }
    }

    // MARK: - Swipe Handling
    @objc private func handleSwipe(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let progress = min(max(abs(translation.x / view.bounds.width), 0), 1)

        switch gesture.state {
        case .changed:
            currentCardView.applySwipeEffect(direction: translation.x > 0 ? .right : .left, progress: progress)
            nextCardView.transform = CGAffineTransform(translationX: translation.x * 0.2, y: 0)
        case .ended:
            let currentMovie = viewModel.getCurrentMovie()
            let velocity = gesture.velocity(in: view).x
            let shouldDismiss = abs(translation.x) > view.bounds.width * 0.5 || abs(velocity) > 500

            if shouldDismiss, let currentMovie = currentMovie {
                let direction: UISwipeGestureRecognizer.Direction = translation.x > 0 ? .right : .left
                currentCardView.animateCardFall(direction: direction) { [weak self] in
                    guard let self = self else { return }
                    if direction == .right {
                        self.viewModel.handle(.addFavorite(currentMovie.id))
                    } else {
                        self.viewModel.handle(.hideMovie(currentMovie.id))
                    }
                    self.swapCards()
                    
                    Task {
                        await self.viewModel.fetchMoviesIfNeeded()
                        self.updateUI()
                    }
                }
            } else {
                currentCardView.resetSwipeEffect()
                nextCardView.transform = .identity
            }
        default:
            currentCardView.resetSwipeEffect()
            nextCardView.transform = .identity
        }
    }
    
    private func updateUI() {
        if viewModel.isPlaceholderNeeded() {
            showPlaceholder()
        } else if let currentMovie = viewModel.getCurrentMovie() {
            let currentMovieViewModel = MovieDetailsItemViewModel(movie: currentMovie)
            configureCards(with: currentMovieViewModel)
        }
    }

    private func showPlaceholder() {
        currentCardView.isHidden = true
        nextCardView.isHidden = true
        movieTitleLabel.text = nil
        movieSubtitleLabel.text = nil
        tagsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        logoImageView.isHidden = false
    }

    private func swapCards() {
        let temp = currentCardView
        currentCardView.transform = .identity
        currentCardView = nextCardView
        nextCardView = temp
    }
}

// MARK: - Constants
extension FeedViewController {
    enum Constants {
        enum Fonts {
            static let movieTitle = UIFont(name: "Manrope-Bold", size: 24) ?? .boldSystemFont(ofSize: 24)
            static let movieSubtitle = UIFont(name: "Manrope-Regular", size: 16) ?? .systemFont(ofSize: 16)
        }

        enum Colors {
            static let background = "AppDark"
            static let movieTitle = "AppWhite"
            static let movieSubtitle = "AppGray"
        }

        enum Layout {
            static let logoWidth: CGFloat = 60.72
            static let logoHeight: CGFloat = 32
            static let logoTopPadding: CGFloat = 24
            static let cardTopPadding: CGFloat = 16
            static let cardHeightMultiplier: CGFloat = 1.4
            static let movieInfoTopPadding: CGFloat = 16
            static let movieInfoStackSpacing: CGFloat = 8
            static let tagsSpacing: CGFloat = 4
            static let sidePadding: CGFloat = 24
            static let tagsBottomPadding: CGFloat = 32
        }

        enum Images {
            static let logo = "Logo"
        }
    }
}
