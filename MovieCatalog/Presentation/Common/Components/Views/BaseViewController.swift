//
//  BaseViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 08.01.2025.
//


import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    private var shouldShowBackButton: Bool = true
    
    // MARK: - UI Elements
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ChevronLeft")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        
        if !shouldShowBackButton {
            hideCustomBackButton()
        }
        
        hideSystemBackButton()
    }
    
    // MARK: - Public Methods
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func hideBackButton() {
        shouldShowBackButton = false
    }
    
    // MARK: - Private Methods
    private func hideSystemBackButton() {
        navigationItem.hidesBackButton = true
    }
    
    private func hideCustomBackButton() {
        backButton.isHidden = true
    }
    
    private func setupBaseUI() {
        view.backgroundColor = UIColor(named: "AppDark")
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 78),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16)
        ])
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
