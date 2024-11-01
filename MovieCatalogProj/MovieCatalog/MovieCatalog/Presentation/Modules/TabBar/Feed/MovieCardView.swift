//
//  MovieCardView.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit
import SwiftUI
import ClientAPI
import CommonUI

final class MovieCardView: UIView {
    var movie: MovieElementModel? {
        didSet { updateUI() }
    }
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let genresStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTapGestureForDetails()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        addTapGestureForDetails()
    }
    
    private func setupUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = UIColor(named: "AppWhite")
        titleLabel.numberOfLines = 1
        
        detailsLabel.font = .systemFont(ofSize: 16)
        detailsLabel.textColor = UIColor(named: "AppGray")
        
        genresStackView.axis = .horizontal
        genresStackView.spacing = 4
        genresStackView.alignment = .leading
        
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, detailsLabel, genresStackView])
        textStackView.axis = .vertical
        textStackView.spacing = 4
        textStackView.alignment = .center
        
        addSubview(posterImageView)
        addSubview(textStackView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            textStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    private func addTapGestureForDetails() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMovieDetails))
        posterImageView.addGestureRecognizer(tapGesture)
        posterImageView.isUserInteractionEnabled = true
    }
    
    @objc private func openMovieDetails() {
        guard let movie = movie else { return }
        let detailsView = MovieDetailsModule.build(movie: movie)
        let hostingController = UIHostingController(rootView: detailsView)

        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let topVC = scene.windows.first?.rootViewController {
            topVC.present(hostingController, animated: true, completion: nil)
        }
    }
    
    func configure(with movie: MovieElementModel) {
        self.movie = movie
        updateUI()
    }
    
    private func updateUI() {
        guard let movie = movie else { return }
        
        if let posterURLString = movie.poster, let posterURL = URL(string: posterURLString) {
            loadImage(from: posterURL)
        } else {
            posterImageView.image = UIImage(named: "placeholder_image")
        }
        
        titleLabel.text = movie.name ?? "Unknown Title"
        detailsLabel.text = "\(movie.country ?? "Unknown Country") • \(movie.year?.description ?? "Unknown Year")"
        
        genresStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        movie.genres?.forEach { genre in
            let tag = TagView(text: genre.name ?? "Genre")
            genresStackView.addArrangedSubview(tag)
        }
    }

    private func loadImage(from url: URL) {
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
}
