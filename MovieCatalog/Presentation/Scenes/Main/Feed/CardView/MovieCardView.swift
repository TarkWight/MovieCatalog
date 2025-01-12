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
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = UIColor(named: "AppDarkFaded")
        return imageView
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = UIColor(named: "AppDarkFaded")
        imageView.alpha = 0
        return imageView
    }()

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
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    // MARK: - Configuration
    func configure(with posterURL: String) {
        guard let url = URL(string: posterURL) else {
            print("Invalid URL: \(posterURL)")
            return
        }

        Task {
            if let image = await ImageManagerActor.shared.loadImage(from: url) {
                DispatchQueue.main.async {
                    self.posterImageView.contentMode = .scaleAspectFill
                    self.posterImageView.image = image
                    self.backgroundColor = .clear
                }
            }
        }
    }

    func applySwipeEffect(direction: UISwipeGestureRecognizer.Direction, progress: CGFloat) {
        let rotation = progress * Constants.Animation.rotationAngle * (direction == .right ? 1 : -1)
        self.transform = CGAffineTransform(rotationAngle: rotation * (.pi / 180))

        if abs(rotation) > Constants.Animation.rotationAngle {
            overlayView.backgroundColor = direction == .right
            ? UIColor.systemOrange.withAlphaComponent(Constants.Animation.overlayEndAlpha)
            : UIColor.systemGray.withAlphaComponent(Constants.Animation.overlayEndAlpha)
            iconImageView.image = direction == .right
                ? UIImage(systemName: "heart.fill")
                : UIImage(systemName: "heart.slash.fill")
            iconImageView.alpha = progress
        } else {
            overlayView.backgroundColor = .clear
            iconImageView.image = nil
            iconImageView.alpha = 0
        }
    }

    func resetSwipeEffect() {
        UIView.animate(withDuration: 0.2, animations: {
            self.overlayView.backgroundColor = .clear
            self.iconImageView.alpha = 0
        }, completion: { _ in
            self.iconImageView.image = nil
        })
    }

    func animateCardFall(direction: UISwipeGestureRecognizer.Direction, completion: @escaping () -> Void) {
        let rotationAngle: CGFloat = direction == .right ? .pi / 6 : -.pi / 6
        let translationX: CGFloat = direction == .right ? 200 : -200
        let translationY: CGFloat = 300

        let originalAnchorPoint = layer.anchorPoint
        let originalPosition = layer.position
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        layer.position = CGPoint(x: bounds.midX, y: bounds.maxY)

        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(rotationAngle: rotationAngle)
                .concatenating(CGAffineTransform(translationX: translationX, y: translationY))
            self.alpha = 0
        }, completion: { _ in
            self.layer.anchorPoint = originalAnchorPoint
            self.layer.position = originalPosition
            self.transform = .identity
            self.alpha = 1
            completion()
        })
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
            static let likeOverlay = "LikeOverlay"
            static let dislikeOverlay = "DislikeOverlay"
        }
        
        enum Images {
            static let likeIcon = "Like"
            static let dislikeIcon = "Dislike"
        }
        
        enum Animation {
            static let overlayStartAlpha: CGFloat = 0
            static let overlayEndAlpha: CGFloat = 0.5
            static let rotationAngle: CGFloat = 3
            static let duration: TimeInterval = 2
        }
    }
}
