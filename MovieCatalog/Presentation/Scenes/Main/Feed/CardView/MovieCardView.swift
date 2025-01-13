//
//  MovieCardView.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//

import UIKit

final class MovieCardView: UIView {
    // MARK: - UI Elements
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.Layout.cornerRadius
        imageView.backgroundColor = UIColor(named: Constants.Colors.overlayBackground)
        return imageView
    }()
    
    // MARK: - Properties
    private var currentPosterURL: String?
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(posterImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    func configure(with posterURL: String) {
        currentPosterURL = posterURL
        guard let url = URL(string: posterURL) else {
            print("Invalid URL: \(posterURL)")
            return
        }
        
        Task {
            if let image = await ImageManagerActor.shared.loadImage(from: url) {
                DispatchQueue.main.async {
                    if self.currentPosterURL == posterURL {
                        self.posterImageView.image = image
                    }
                }
            }
        }
    }
    
    func animateCardDismiss(direction: UISwipeGestureRecognizer.Direction, completion: @escaping () -> Void) {
        let translationX: CGFloat = direction == .right ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width
        
        UIView.animate(
            withDuration: Constants.Animation.dismissDuration,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.transform = CGAffineTransform(translationX: translationX, y: 0)
                self.alpha = 0
            },
            completion: { _ in
                self.transform = .identity
                self.alpha = 1
                completion()
            }
        )
    }
}

// MARK: - Constants
extension MovieCardView {
    enum Constants {
        enum Layout {
            static let cornerRadius: CGFloat = 8
        }
        
        enum Colors {
            static let overlayBackground = "AppDarkFaded"
        }
        
        enum Animation {
            static let dismissDuration: TimeInterval = 0.4
        }
    }
}
