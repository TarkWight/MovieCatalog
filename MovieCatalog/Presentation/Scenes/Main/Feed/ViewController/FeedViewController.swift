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

    // MARK: - UI Elements
    private let movieCardView = MovieCardView()
    private let movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: "AppWhite")
        label.numberOfLines = 0
        return label
    }()
    private let movieSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "AppGray")
        return label
    }()
    private let tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
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
        super.viewDidLoad()
        setupUI()
        setupGestures()
        bindViewModel()
        viewModel.handle(.fetchInitialMovies)
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: "AppDark")
        
        view.addSubview(movieCardView)
        view.addSubview(movieInfoStackView)
        view.addSubview(loadingView)

        movieInfoStackView.addArrangedSubview(movieTitleLabel)
        movieInfoStackView.addArrangedSubview(movieSubtitleLabel)
        movieInfoStackView.addArrangedSubview(tagsStackView)

        setupConstraints()

        loadingView.center = view.center
        loadingView.startAnimating()
        movieCardView.isHidden = true
    }

    private func setupConstraints() {
        movieCardView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movieCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            movieCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            movieCardView.heightAnchor.constraint(equalTo: movieCardView.widthAnchor, multiplier: 1.4),
            
            movieInfoStackView.topAnchor.constraint(equalTo: movieCardView.bottomAnchor, constant: 16),
            movieInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        movieCardView.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        movieCardView.addGestureRecognizer(swipeLeft)
    }

    // MARK: - ViewModel Binding
    private func bindViewModel() {
        viewModel.onLoading = { [weak self] isLoading in
            guard let self else { return }
            self.loadingView.isHidden = !isLoading
            self.movieCardView.isHidden = isLoading
        }

        viewModel.onViewDataUpdated = { [weak self] viewData in
            guard let self else { return }
            guard let movie = viewData.cardItems.first else { return }
            self.configureCard(with: movie)
        }

        viewModel.onError = { [weak self] errorMessage in
            guard let self else { return }
            // Show an error alert
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    // MARK: - Card Configuration
    private func configureCard(with movie: MovieDetailsItemViewModel) {
        movieCardView.configure(with: movie.posterURL ?? "")
        movieTitleLabel.text = movie.title
        movieSubtitleLabel.text = "\(movie.country) • \(movie.year)"

        tagsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for genre in movie.genres {
            let tagView = TagView(text: genre)
            tagsStackView.addArrangedSubview(tagView)
        }
    }

    // MARK: - Swipe Handling
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        guard let movie = viewModel.getCurrentMovie() else { return }

        if gesture.direction == .right {
            movieCardView.applySwipeEffect(direction: .right)
            animateSwipe(direction: .right) { [weak self] in
                self?.viewModel.handle(.addFavorite(movie.id))
            }
        } else if gesture.direction == .left {
            movieCardView.applySwipeEffect(direction: .left)
            animateSwipe(direction: .left) { [weak self] in
                self?.viewModel.handle(.hideMovie(movie.id))
            }
        }
    }

    private func animateSwipe(direction: UISwipeGestureRecognizer.Direction, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            let translation = direction == .right ? self.view.bounds.width : -self.view.bounds.width
            self.movieCardView.transform = CGAffineTransform(translationX: translation, y: 0)
        }, completion: { _ in
            self.movieCardView.transform = .identity
            self.movieCardView.resetSwipeEffect()
            completion()
        })
    }
}
