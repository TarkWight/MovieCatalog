//
//  FavoriteCarouselCell.swift
//  MovieCatalog
//
//  Created by Tark Wight on 02.11.2024.
//

import UIKit

final class FavoriteCarouselCell: UICollectionViewCell {
    private let posterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        posterImageView.contentMode = .scaleAspectFill
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with model: MovieElementModel) {
        // Настройка изображения постера
    }
}
