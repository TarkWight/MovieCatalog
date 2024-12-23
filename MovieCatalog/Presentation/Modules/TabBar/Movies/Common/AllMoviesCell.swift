//
//  AllMoviesCell.swift
//  MovieCatalog
//
//  Created by Tark Wight on 02.11.2024.
//

import UIKit

final class AllMoviesCell: UICollectionViewCell {
    private let posterImageView = UIImageView()
    private let ratingBadge = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        contentView.addSubview(posterImageView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        // Rating Badge
        ratingBadge.font = UIFont.boldSystemFont(ofSize: 12)
        ratingBadge.textColor = .white
        ratingBadge.textAlignment = .center
        ratingBadge.layer.cornerRadius = 5
        ratingBadge.clipsToBounds = true
        contentView.addSubview(ratingBadge)
        
        ratingBadge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingBadge.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ratingBadge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            ratingBadge.widthAnchor.constraint(equalToConstant: 35),
            ratingBadge.heightAnchor.constraint(equalToConstant: 22)
        ])
    }

    func configure(with model: MovieElementModel) {
        // Загрузка постера
        if let posterURLString = model.poster, let url = URL(string: posterURLString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error loading image: \(error)")
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(named: "placeholder_image")
                    }
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(named: "placeholder_image")
                    }
                }
            }
            task.resume()
        }

        // Отображение рейтинга
        if let averageRating = model.getAverageRating() {
            ratingBadge.text = String(format: "%.1f", averageRating)
            ratingBadge.isHidden = false
            ratingBadge.applyGradient(colors: [.red, .green], frame: ratingBadge.bounds)
        } else {
            ratingBadge.isHidden = true
        }
    }
}
