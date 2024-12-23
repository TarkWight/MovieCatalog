//
//  WelcomeViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 27.10.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel: WelcomeViewModel
    
    // MARK: - Initializers
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(named: "AppDark")

        let welcomeLabel = UILabel()
        welcomeLabel.text = NSLocalizedString("welcome", comment: "Welcome message")
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: "Manrope-Bold", size: 36)
        welcomeLabel.textColor = UIColor(named: "AppWhite")
        welcomeLabel.textAlignment = .left
        welcomeLabel.numberOfLines = 0
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)

        let signInButton = CustomButton()
        signInButton.setTitle(NSLocalizedString("welcome_sign_in", comment: "Sign in button title"), for: .normal)
        signInButton.configure(for: .default)
        signInButton.setSize(width: 345, height: 48)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        let signUpButton = CustomButton()
        signUpButton.setTitle(NSLocalizedString("register", comment: "Register button title"), for: .normal)
        signUpButton.configure(for: .secondary)
        signUpButton.setSize(width: 345, height: 48)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            welcomeLabel.widthAnchor.constraint(equalToConstant: 345),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 100),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),

            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        navigationController?.navigationBar.barTintColor = .white
    }
    
    // MARK: - Actions
    
    @objc private func didTapSignIn() {
        viewModel.didTapSignIn()
    }

    @objc private func didTapSignUp() {
        viewModel.didTapSignUp()
    }
}
