//
//  WelcomeViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.08.2025.
//

import Combine
import UIKit

class WelcomeViewController: UIViewController {
    private let store: Store
    private var cancellable: AnyCancellable?

    private let loginButton = UIButton(type: .system)
    private let registerButton = UIButton(type: .system)

    init(store: Store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Welcome"

        loginButton.setTitle("Go to Login", for: .normal)
        registerButton.setTitle("Go to Register", for: .normal)
        [loginButton, registerButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(
                equalTo: view.centerYAnchor,
                constant: -20
            ),
            registerButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            registerButton.topAnchor.constraint(
                equalTo: loginButton.bottomAnchor,
                constant: 16
            ),
        ])

        loginButton.addTarget(
            self,
            action: #selector(onLogin),
            for: .touchUpInside
        )
        registerButton.addTarget(
            self,
            action: #selector(onRegister),
            for: .touchUpInside
        )
    }

    @objc private func onLogin() {
        store.dispatch(.authentication(.login))
    }
    @objc private func onRegister() {
        store.dispatch(.authentication(.register))
    }
}
