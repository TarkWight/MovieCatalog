//
//  WelcomeViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 27.10.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let viewModel: WelcomeViewModel

    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        let welcomeLabel = UILabel()
        welcomeLabel.text = "Добро пожаловать в Movie Catalog"
        welcomeLabel.textAlignment = .center

        let signInButton = UIButton(type: .system)
        signInButton.setTitle("Войти в аккаунт", for: .normal)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)

        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Зарегистрироваться", for: .normal)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, signInButton, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapSignIn() {
        viewModel.didTapSignIn()
    }

    @objc private func didTapSignUp() {
        viewModel.didTapSignUp()
    }
}

