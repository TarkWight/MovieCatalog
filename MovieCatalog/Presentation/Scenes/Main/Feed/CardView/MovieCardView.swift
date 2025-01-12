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
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = Constants.Layout.cornerRadius
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor(named: Constants.Colors.iconTint)
        imageView.alpha = 0
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
        addSubview(overlayView)
        overlayView.addSubview(iconImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.iconSize)
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
                    if self.currentPosterURL == posterURL { // Проверка для предотвращения некорректного отображения
                        self.posterImageView.image = image
                    }
                }
            }
        }
    }
    
    // MARK: - Swipe Effects
    func applySwipeEffect(direction: UISwipeGestureRecognizer.Direction, progress: CGFloat) {
        let overlayColor = direction == .right
            ? UIColor.systemOrange.withAlphaComponent(Constants.Animation.overlayAlpha)
            : UIColor.systemGray.withAlphaComponent(Constants.Animation.overlayAlpha)
        let iconName = direction == .right ? Constants.Images.likeIcon : Constants.Images.dislikeIcon

        overlayView.backgroundColor = overlayColor
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.alpha = progress
    }
    
    func resetSwipeEffect() {
        UIView.animate(withDuration: Constants.Animation.resetDuration) {
            self.overlayView.backgroundColor = .clear
            self.iconImageView.alpha = 0
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
            static let iconSize: CGFloat = 125
        }
        
        enum Colors {
            static let overlayBackground = "AppDarkFaded"
            static let iconTint = "AppGray"
        }
        
        enum Images {
            static let likeIcon = "heart.fill"
            static let dislikeIcon = "heart.slash.fill"
        }
        
        enum Animation {
            static let overlayAlpha: CGFloat = 0.5
            static let dismissDuration: TimeInterval = 0.4
            static let resetDuration: TimeInterval = 0.2
        }
    }
}
