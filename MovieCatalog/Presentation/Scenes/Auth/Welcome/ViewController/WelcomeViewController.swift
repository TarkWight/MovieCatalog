//
//  WelcomeViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
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
        backgroundImage.image = UIImage(named: Constants.backgroundImageName)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)

        view.backgroundColor = .clear

        let welcomeLabel = UILabel()
        welcomeLabel.text = LocalizedKey.Welcome.title
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: Constants.welcomeFontName, size: Constants.welcomeFontSize)
        welcomeLabel.textColor = UIColor(named: Constants.labelTextColorName)
        welcomeLabel.textAlignment = .left
        welcomeLabel.numberOfLines = 2
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)

        let signInButton = CustomButton()
        signInButton.setTitle(LocalizedKey.Auth.Action.logIn, for: .normal)
        signInButton.configure(for: .default)
        signInButton.setSize(width: Constants.buttonWidth, height: Constants.buttonHeight)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        let signUpButton = CustomButton()
        signUpButton.setTitle(LocalizedKey.Auth.Action.register, for: .normal)
        signUpButton.configure(for: .secondary)
        signUpButton.setSize(width: Constants.buttonWidth, height: Constants.buttonHeight)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            welcomeLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            welcomeLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.labelTopPadding),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.labelLeadingPadding),

            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.stackViewBottomPadding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewHorizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewHorizontalPadding)
        ])

        navigationController?.navigationBar.barTintColor = .white
    }

    // MARK: - Actions
    @objc private func didTapSignIn() {
        viewModel.handle(.logInTapped)
    }

    @objc private func didTapSignUp() {
        viewModel.handle(.registrationTapped)
    }

    // MARK: - Constants
    private enum Constants {
        static let backgroundImageName = "BackgroundPlaceholder"

        static let welcomeFontName = "Manrope-Bold"
        static let welcomeFontSize: CGFloat = 36
        static let labelTextColorName = "AppWhite"
        static let labelWidth: CGFloat = 345
        static let labelHeight: CGFloat = 100
        static let labelTopPadding: CGFloat = 76
        static let labelLeadingPadding: CGFloat = 24

        static let buttonWidth: CGFloat = 345
        static let buttonHeight: CGFloat = 48

        static let stackViewSpacing: CGFloat = 8
        static let stackViewBottomPadding: CGFloat = 20
        static let stackViewHorizontalPadding: CGFloat = 20
    }
}
