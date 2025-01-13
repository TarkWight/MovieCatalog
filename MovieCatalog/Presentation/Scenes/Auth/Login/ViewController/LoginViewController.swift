//  LoginViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 06.01.2025.
//

import UIKit

final class LoginViewController: BaseViewController {

    // MARK: - Properties
    private let viewModel: LoginViewModel

    private let usernameField = CustomTextField(placeholder: LocalizedKey.Auth.LigIn.TextField.username, type: .text)
    private let passwordField = CustomTextField(placeholder: LocalizedKey.Auth.LigIn.TextField.password, type: .password)
    private let signInButton = CustomButton()

    // MARK: - Initializers
    init(viewModel: LoginViewModel) {
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

    // MARK: - UI Setup
    private func setupUI() {
        setBackgroundImage(named: "Background",
                           topOffset: 0,
                           heightMultiplier: 0.7,
                           topGradientHeight: 434,
                           bottomGradientHeight: 314)

        configureTitle(LocalizedKey.Auth.LigIn.title)

        [usernameField, passwordField, signInButton]
            .forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }

        
        
        signInButton.setTitle(LocalizedKey.Auth.Button.login, for: .normal)
        signInButton.configure(for: .disabled)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameField.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            usernameField.bottomAnchor.constraint(equalTo: passwordField.topAnchor, constant: -Constants.Layout.inputStackSpacing),

            passwordField.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            passwordField.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -Constants.Layout.buttonTopOffset),

            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.sidePadding),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.sidePadding),
            signInButton.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.Layout.safeAreaPadding)
        ])
    }

    // MARK: - ViewModel Binding
    private func bindViewModel() {
        usernameField.onTextChanged = { [weak self] text in
            self?.viewModel.handle(.usernameChanged(text))
            self?.updateSignInButtonState()
        }

        passwordField.onTextChanged = { [weak self] text in
            self?.viewModel.handle(.passwordChanged(text))
            self?.updateSignInButtonState()
        }

        viewModel.delegate = self
    }

    private func updateSignInButtonState() {
        if isFormValid {
            signInButton.configure(for: .default)
        } else {
            signInButton.configure(for: .disabled)
        }
    }

    private var isFormValid: Bool {
        return !(usernameField.textField.text?.isEmpty ?? true) &&
               !(passwordField.textField.text?.isEmpty ?? true)
    }

    // MARK: - Actions
    @objc private func didTapSignIn() {
        viewModel.handle(.logInTapped)
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func didUpdateLoadingState(isLoading: Bool) {
        signInButton.isUserInteractionEnabled = !isLoading
    }

    func didEncounterError(_ message: String) {
        let alert = UIAlertController(title: NSLocalizedString("error", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default))
        present(alert, animated: true)
    }

    func didCompleteLogin() {
        print("Login Successful")
    }
}

private extension LoginViewController {
    // MARK: - Constants
    private enum Constants {
        enum Layout {
            static let sidePadding: CGFloat = 24
            static let inputStackSpacing: CGFloat = 8
            static let buttonTopOffset: CGFloat = 32
            static let inputFieldHeight: CGFloat = 48
            static let safeAreaPadding: CGFloat = 24
        }
        
        enum Colors {
            static let background = "AppDark"
        }
    }
}
