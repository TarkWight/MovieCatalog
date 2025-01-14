//
//  MoviesViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import UIKit

import UIKit

final class MoviesViewController: BaseViewController {
    private let viewModel: MoviesViewModel
    private let collectionView: UICollectionView

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 160)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.handle(.fetchInitialMovies)
    }

    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Регистрация ячейки
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.onMoviesLoaded = { [weak self] in
            Task { @MainActor in
                self?.collectionView.reloadData()
            }
        }
        viewModel.onError = { [weak self] errorMessage in
            Task { @MainActor in
                self?.showErrorAlert(message: errorMessage)
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moviesBuffer.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configure(with: viewModel.moviesBuffer[indexPath.item])
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.isLoading else { return } 
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        guard let maxIndex = visibleIndexPaths.map({ $0.item }).max() else { return }
        if maxIndex >= viewModel.moviesBuffer.count - 6 {
            viewModel.handle(.fetchMoreMovies)
        }
    }
}
