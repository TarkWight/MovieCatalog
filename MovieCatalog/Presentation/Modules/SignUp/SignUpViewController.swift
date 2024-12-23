//
//  SignUpViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    // MARK: - UI Elements
    private let backButton = BackButton()
    private let titleLabel = UILabel()
    private let genderPicker = GenderPickerView()
    private let registerButton = CustomButton()
    
    private let usernameField = InputField(placeholder: NSLocalizedString("user_username", comment: ""), type: .text)
    private let emailField = InputField(placeholder: NSLocalizedString("user_email", comment: ""), type: .text)
    private let nameField = InputField(placeholder: NSLocalizedString("user_name", comment: ""), type: .text)
    private let passwordField = InputField(placeholder: NSLocalizedString("user_password", comment: ""), type: .password)
    private let confirmPasswordField = InputField(placeholder: NSLocalizedString("confirm_password", comment: ""), type: .password)
    private let birthdateField = InputField(placeholder: NSLocalizedString("user_birthdate", comment: ""), type: .date)
    
    private let stackView = UIStackView()
    private let viewModel: SignUpViewModel
    
    // MARK: - Initialization
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: "background")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        titleLabel.text = NSLocalizedString("sign_up_screen_label", comment: "")
        titleLabel.textAlignment = .center
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(usernameField)
        stackView.addArrangedSubview(emailField)
        stackView.addArrangedSubview(nameField)
        stackView.addArrangedSubview(passwordField)
        stackView.addArrangedSubview(confirmPasswordField)
        stackView.addArrangedSubview(birthdateField)
        stackView.addArrangedSubview(genderPicker)
        
        registerButton.setTitle(NSLocalizedString("register", comment: ""), for: .normal)
        registerButton.configure(for: .default)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(registerButton)
        
        layoutUI()
    }
    
    private func layoutUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registerButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onRegistrationSuccess = { [weak self] in
            print("Registration successful")
        }
        
        viewModel.onRegistrationFailure = { [weak self] error in
            print("Registration failed: \(error)")
        }
        
        usernameField.onTextChanged = { [weak self] text in self?.viewModel.username = text }
        emailField.onTextChanged = { [weak self] text in self?.viewModel.email = text }
        nameField.onTextChanged = { [weak self] text in self?.viewModel.name = text }
        passwordField.onTextChanged = { [weak self] text in self?.viewModel.password = text }
        confirmPasswordField.onTextChanged = { [weak self] text in self?.viewModel.confirmPassword = text }
        birthdateField.onTextChanged = { [weak self] text in self?.viewModel.birthDate = text }
        genderPicker.onGenderSelected = { [weak self] gender in self?.viewModel.gender = gender }
    }
    
    // MARK: - Actions
    @objc private func registerTapped() {
        viewModel.register()
    }
}

