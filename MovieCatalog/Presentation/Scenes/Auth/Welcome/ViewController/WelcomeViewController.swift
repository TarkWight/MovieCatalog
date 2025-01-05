//
//  WelcomeViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
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

    @objc private func logInTapped() {
        viewModel.handle(.logInTapped)
    }

    @objc private func registrationTapped() {
        viewModel.handle(.registrationTapped)
    }

    private func setupUI() {
        view.backgroundColor = .white

        let logInButton = UIButton(type: .system)
        logInButton.setTitle("Log In", for: .normal)
        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)

        let registrationButton = UIButton(type: .system)
        registrationButton.setTitle("Register", for: .normal)
        registrationButton.addTarget(self, action: #selector(registrationTapped), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [logInButton, registrationButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
