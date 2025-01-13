//  WelcomeViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import UIKit

final class WelcomeViewController: BaseViewController {

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
        hideBackButton()
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private Methods
    private func setupUI() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: Constants.Images.background)
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)

        view.backgroundColor = Constants.Colors.background

        let welcomeLabel = UILabel()
        welcomeLabel.text = Constants.Text.welcomeTitle
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = UIFont(name: Constants.Fonts.welcome, size: Constants.Sizes.welcomeFontSize)
        welcomeLabel.textColor = Constants.Colors.labelText
        welcomeLabel.textAlignment = .left
        welcomeLabel.numberOfLines = 2
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)

        let signInButton = CustomButton()
        signInButton.setTitle(Constants.Text.signInButton, for: .normal)
        signInButton.configure(for: .default)
        signInButton.setSize(width: Constants.Sizes.buttonWidth, height: Constants.Sizes.buttonHeight)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        let signUpButton = CustomButton()
        signUpButton.setTitle(Constants.Text.signUpButton, for: .normal)
        signUpButton.configure(for: .secondary)
        signUpButton.setSize(width: Constants.Sizes.buttonWidth, height: Constants.Sizes.buttonHeight)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizes.stackViewSpacing
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            welcomeLabel.widthAnchor.constraint(equalToConstant: Constants.Sizes.labelWidth),
            welcomeLabel.heightAnchor.constraint(equalToConstant: Constants.Sizes.labelHeight),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Paddings.labelTop),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Paddings.labelLeading),

            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Paddings.stackViewBottom),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Paddings.stackViewHorizontal),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Paddings.stackViewHorizontal)
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
        enum Images {
            static let background = "Background"
        }

        enum Fonts {
            static let welcome = "Manrope-Bold"
        }

        enum Colors {
            static let background = UIColor(named: "AppDark") ?? .black
            static let labelText = UIColor(named: "AppWhite") ?? .white
        }

        enum Sizes {
            static let welcomeFontSize: CGFloat = 36
            static let labelWidth: CGFloat = 345
            static let labelHeight: CGFloat = 100
            static let buttonWidth: CGFloat = 345
            static let buttonHeight: CGFloat = 48
            static let stackViewSpacing: CGFloat = 8
        }

        enum Paddings {
            static let labelTop: CGFloat = 76
            static let labelLeading: CGFloat = 24
            static let stackViewBottom: CGFloat = 20
            static let stackViewHorizontal: CGFloat = 20
        }

        enum Text {
            static let welcomeTitle = LocalizedKey.Welcome.title
            static let signInButton = LocalizedKey.Welcome.Button.login
            static let signUpButton = LocalizedKey.Welcome.Button.register
        }
    }
}
