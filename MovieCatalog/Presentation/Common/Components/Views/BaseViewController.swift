//
//  BaseViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 08.01.2025.
//


import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - UI Elements
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "AppDarkFaded")
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    
    // MARK: - Public Methods
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func configureBackButton(action: Selector?) {
        backButton.addTarget(self, action: action ?? #selector(didTapBackButton), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup Methods
    private func setupBaseUI() {
        view.backgroundColor = UIColor(named: "AppDark")
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        
        setupBaseConstraints()
    }
    
    private func setupBaseConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16)
        ])
    }
    
    
}
