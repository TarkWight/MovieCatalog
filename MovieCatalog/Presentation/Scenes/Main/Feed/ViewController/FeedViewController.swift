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
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: Constants.Images.logo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let movieCardView = MovieCardView()

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
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        movieCardView.translatesAutoresizingMaskIntoConstraints = false
        movieInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Layout.logoTopPadding),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.logoWidth),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.logoHeight),

            movieCardView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Constants.Layout.cardTopPadding),
            movieCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            movieCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            movieCardView.heightAnchor.constraint(equalTo: movieCardView.widthAnchor, multiplier: Constants.Layout.cardHeightMultiplier),

            movieInfoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            movieInfoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
//            movieInfoStackView.bottomAnchor.constraint(equalTo: tagsStackView.topAnchor, constant: Constants.Layout.movieInfoStackSpacing * 2),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            tagsStackView.heightAnchor.constraint(equalToConstant: 28),
            tagsStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            tagsStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            tagsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Layout.tagsBottomPadding)
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

        var availableWidth = view.bounds.width - 2 * Constants.Layout.sidePadding
        for genre in movie.genres {
            let isFavorite = GlobalFavoriteTagsManager.shared.isFavorite(tagId: genre.id)
            let tagView = TagView(text: genre.name ?? "", isActive: isFavorite) { [weak self] in
                GlobalFavoriteTagsManager.shared.toggleFavorite(tagId: genre.id)
                self?.updateTagViews(for: movie)
            }

            tagView.translatesAutoresizingMaskIntoConstraints = false
            tagView.heightAnchor.constraint(equalToConstant: 28).isActive = false

            let tagWidth = tagView.label.intrinsicContentSize.width + 16
            if tagWidth > availableWidth {
                break
            }

            tagsStackView.addArrangedSubview(tagView)
            availableWidth -= (tagWidth + Constants.Layout.tagsSpacing)
        }
    }

    private func updateTagViews(for movie: MovieDetailsItemViewModel) {
        for case let tagView as TagView in tagsStackView.arrangedSubviews {
            if let genreName = tagView.text,
               let genre = movie.genres.first(where: { $0.name == genreName }) {
                tagView.isActive = GlobalFavoriteTagsManager.shared.isFavorite(tagId: genre.id)
            }
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
