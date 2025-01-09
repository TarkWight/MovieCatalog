//
//  RegistrationViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 04.01.2025.
//

import UIKit

final class RegisterViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel: RegisterViewModel

    private let usernameField = CustomTextField(placeholder: LocalizedKey.Auth.Registration.TextField.username, type: .text)
    private let emailField = CustomTextField(placeholder: LocalizedKey.Auth.Registration.TextField.email, type: .text)
    private let nameField = CustomTextField(placeholder: LocalizedKey.Auth.Registration.TextField.name, type: .text)
    private let passwordField = CustomTextField(placeholder: LocalizedKey.Auth.Registration.TextField.password, type: .password)
    private let confirmPasswordField = CustomTextField(placeholder: LocalizedKey.Auth.Registration.TextField.confirmPassword, type: .password)
    private let birthDateField = CustomTextField(placeholder: LocalizedKey.Auth.Registration.TextField.birthDate, type: .date)
    private let genderPickerView = GenderPickerView()
    private let registerButton = CustomButton()

    // MARK: - Initializers
    init(viewModel: RegisterViewModel) {
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
        configureTitle(LocalizedKey.Auth.Registration.title)
        
        [usernameField, emailField, nameField, passwordField, confirmPasswordField, birthDateField, genderPickerView, registerButton]
            .forEach {
                view.addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        registerButton.setTitle(LocalizedKey.Auth.Registration.button, for: .normal)
        registerButton.configure(for: .disabled)
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            usernameField.heightAnchor.constraint(equalToConstant: 48),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            emailField.heightAnchor.constraint(equalToConstant: 48),
            emailField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            
            nameField.heightAnchor.constraint(equalToConstant: 48),
            nameField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            nameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            
            passwordField.heightAnchor.constraint(equalToConstant: 48),
            passwordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 48),
            confirmPasswordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            confirmPasswordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            
            birthDateField.heightAnchor.constraint(equalToConstant: 48),
            birthDateField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            birthDateField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            birthDateField.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 16),
            
            genderPickerView.heightAnchor.constraint(equalToConstant: 48),
            genderPickerView.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            genderPickerView.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            genderPickerView.topAnchor.constraint(equalTo: birthDateField.bottomAnchor, constant: 16),
            
            registerButton.heightAnchor.constraint(equalToConstant: 48),
            registerButton.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            registerButton.topAnchor.constraint(equalTo: genderPickerView.bottomAnchor, constant: 32)
        ])
    }
    
    // MARK: - ViewModel Binding
    private func bindViewModel() {
        usernameField.onTextChanged = { [weak self] text in
            self?.viewModel.handle(.usernameChanged(text))
            self?.updateRegisterButtonState()
        }
        
        emailField.onTextChanged = { [weak self] text in
            self?.viewModel.handle(.emailChanged(text))
            self?.updateRegisterButtonState()
        }
        
        nameField.onTextChanged = { [weak self] text in
            self?.viewModel.handle(.nameChanged(text))
            self?.updateRegisterButtonState()
        }
        
        passwordField.onTextChanged = { [weak self] text in
            self?.viewModel.handle(.passwordChanged(text))
            self?.updateRegisterButtonState()
        }
        
        confirmPasswordField.onTextChanged = { [weak self] text in
            self?.viewModel.handle(.confirmPasswordChanged(text))
            self?.updateRegisterButtonState()
        }
        
        birthDateField.onTextChanged = { [weak self] text in
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none

            if let date = dateFormatter.date(from: text) {
                self?.viewModel.handle(.birthDateChanged(date))
                self?.updateRegisterButtonState()
            }
        }
        
        genderPickerView.onGenderSelected = { [weak self] gender in
            self?.viewModel.handle(.genderChanged(Gender(rawValue: gender) ?? .male))
            self?.updateRegisterButtonState()
        }
    }
    
    private func updateRegisterButtonState() {
        let areFieldsFilled = !usernameField.textField.text!.isEmpty &&
                              !emailField.textField.text!.isEmpty &&
                              !nameField.textField.text!.isEmpty &&
                              !passwordField.textField.text!.isEmpty &&
                              !confirmPasswordField.textField.text!.isEmpty

        let doPasswordsMatch = passwordField.textField.text == confirmPasswordField.textField.text

        registerButton.isUserInteractionEnabled = areFieldsFilled && doPasswordsMatch
        registerButton.configure(for: areFieldsFilled && doPasswordsMatch ? .default : .disabled)
    }

    // MARK: - Actions
    @objc private func didTapRegister() {
        viewModel.handle(.registerTapped)
    }
}
