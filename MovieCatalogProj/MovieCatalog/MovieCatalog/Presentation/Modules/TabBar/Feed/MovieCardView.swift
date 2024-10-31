//
//  MovieCardView.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit
import SwiftUI
import ClientAPI

final class MovieCardView: UIView {
    var movie: MovieElementModel? {
        didSet { updateUI() }
    }
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let detailsLabel = UILabel()
    private let genresLabel = UILabel()
    
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
        // Configure appearance of subviews
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 1
        
        detailsLabel.font = .systemFont(ofSize: 16)
        detailsLabel.textColor = .darkGray
        
        genresLabel.font = .systemFont(ofSize: 14)
        genresLabel.textColor = .gray
        genresLabel.numberOfLines = 1
        
        // Layout
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailsLabel, genresLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(posterImageView)
        addSubview(stackView)
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 345),
            
            stackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func addTapGestureForDetails() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMovieDetails))
        posterImageView.addGestureRecognizer(tapGesture)
        posterImageView.isUserInteractionEnabled = true
    }
    
    @objc private func openMovieDetails() {
        guard let movie = movie else { return }
        let detailsView = MovieDetailsModule.build(movie: movie) // Use the module to create the view
        let hostingController = UIHostingController(rootView: detailsView)
        
        if let topVC = UIApplication.shared.windows.first?.rootViewController {
            topVC.present(hostingController, animated: true, completion: nil)
        }
    }
    
    func configure(with movie: MovieElementModel) {
        self.movie = movie
        updateUI()
    }
    
    private func updateUI() {
        guard let movie = movie else { return }
        
        // Load poster image
        if let posterURL = URL(string: movie.poster ?? "") {
            loadImage(from: posterURL)
        } else {
            posterImageView.image = UIImage(named: "placeholder_image")
        }
        
        titleLabel.text = movie.name ?? "Unknown Title"
        detailsLabel.text = "\(movie.country ?? "Unknown Country") - \(movie.year?.description ?? "Unknown Year")"
        genresLabel.text = movie.genres?.compactMap { $0.name }.joined(separator: ", ")
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
            
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(named: "placeholder_image")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.posterImageView.image = image
            }
        }
        task.resume()
    }
}
