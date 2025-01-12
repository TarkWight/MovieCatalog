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
        imageView.backgroundColor = UIColor(named: "AddDarkFaded")
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
        imageView.tintColor = UIColor(named: "AddDarkFaded")
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

    func applySwipeEffect(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
        case .left:
            overlayView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
            iconImageView.image = UIImage(systemName: "heart.slash.fill")
            iconImageView.tintColor = .systemGray
        case .right:
            overlayView.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.5)
            iconImageView.image = UIImage(systemName: "heart.fill")
            iconImageView.tintColor = .systemOrange
        default:
            overlayView.backgroundColor = .clear
            iconImageView.image = nil
        }
        
        UIView.animate(withDuration: 0.2) {
            self.iconImageView.alpha = 1.0
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
}
