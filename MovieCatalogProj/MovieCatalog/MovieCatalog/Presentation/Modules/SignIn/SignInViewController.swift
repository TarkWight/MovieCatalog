//
//  SignInViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 30.10.2024.
//

import UIKit
import CommonUI

final class SignInViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: SignInViewModel
    private let usernameField = InputField(placeholder: NSLocalizedString("user_username", comment: ""), type: .text)
    private let passwordField = InputField(placeholder: NSLocalizedString("user_password", comment: ""), type: .password)
    private let signInButton = CustomButton()

    // MARK: - Initializers
    init(viewModel: SignInViewModel) {
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
        bindViewModel()
    }

    // MARK: - Private Methods
    private func setupUI() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        view.backgroundColor = UIColor(named: "AppDark")

        let backButton = BackButton()
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("sign_in_account", comment: "")
        titleLabel.font = UIFont(name: "Manrope-Bold", size: 24)
        titleLabel.textColor = UIColor(named: "AppWhite")
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topStackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        topStackView.axis = .horizontal
        topStackView.spacing = 8
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topStackView)

        let inputStackView = UIStackView(arrangedSubviews: [usernameField, passwordField])
        inputStackView.axis = .vertical
        inputStackView.spacing = 16
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputStackView)

        signInButton.setTitle(NSLocalizedString("sign_in", comment: ""), for: .normal)
        signInButton.configure(for: .disabled)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        let bottomStackView = UIStackView(arrangedSubviews: [signInButton])
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 16
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)

        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 22),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            inputStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40),
            inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            bottomStackView.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 40),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }

    private func bindViewModel() {
            viewModel.onLoginFailure = { [weak self] error in
                self?.showError(error)
            }

            usernameField.onTextChanged = { [weak self] text in
                self?.validateFields()
            }
            
            passwordField.onTextChanged = { [weak self] text in
                self?.validateFields()
            }
        }

        private func validateFields() {
            let isUsernameEmpty = usernameField.textField.text?.isEmpty ?? true
            let isPasswordEmpty = passwordField.textField.text?.isEmpty ?? true

            if isUsernameEmpty || isPasswordEmpty {
                signInButton.configure(for: .disabled)
            } else {
                signInButton.configure(for: .default)
            }
        }

    private func showError(_ error: Error) {
        print(error)
    }

    // MARK: - Actions
    @objc private func didTapBack() {
        
    }

    @objc private func didTapSignIn() {
        let username = usernameField.textField.text
        let password = passwordField.textField.text
        viewModel.login(username: username, password: password)
    }
}
