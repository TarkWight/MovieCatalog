//
//  MovieCarouselCell.swift
//  MovieCatalog
//
//  Created by Tark Wight on 02.11.2024.
//

import UIKit
import ClientAPI

final class MovieCarouselCell: UICollectionViewCell {
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let genresTagView = UIView()
    private let watchButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Poster Image View
        posterImageView.contentMode = .scaleAspectFill
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        // Title Label
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        posterImageView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Genres Tag View
        genresTagView.layer.cornerRadius = 4
        genresTagView.clipsToBounds = true
        genresTagView.applyGradient(colors: [UIColor.gray, UIColor.darkGray], frame: genresTagView.bounds)
        posterImageView.addSubview(genresTagView)
        genresTagView.translatesAutoresizingMaskIntoConstraints = false

        // Watch Button
        watchButton.setTitle("Смотреть", for: .normal)
        watchButton.setTitleColor(.white, for: .normal)
        watchButton.backgroundColor = .gray
        watchButton.layer.cornerRadius = 5
        posterImageView.addSubview(watchButton)
        watchButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -40),

            genresTagView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 8),
            genresTagView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            genresTagView.heightAnchor.constraint(equalToConstant: 28),
            genresTagView.trailingAnchor.constraint(lessThanOrEqualTo: watchButton.leadingAnchor, constant: -8),

            watchButton.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -8),
            watchButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -8),
            watchButton.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    func configure(with model: MovieElementModel) {
        // Настройка изображения постера и данных для модели
    }
}
