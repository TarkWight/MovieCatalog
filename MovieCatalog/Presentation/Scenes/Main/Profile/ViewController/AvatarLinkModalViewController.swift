//
//  AvatarLinkModalViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 14.01.2025.
//


import UIKit

final class AvatarLinkModalViewController: UIViewController {
    // MARK: - Callbacks
    var onSave: ((String) -> Void)?
    var onCancel: (() -> Void)?
    
    // MARK: - UI Elements
    private let linkTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите ссылку на изображение"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: "AppDark")
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        view.addSubview(linkTextField)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            linkTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            linkTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            linkTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            linkTextField.heightAnchor.constraint(equalToConstant: 44),
            
            saveButton.topAnchor.constraint(equalTo: linkTextField.bottomAnchor, constant: 16),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            
            cancelButton.topAnchor.constraint(equalTo: linkTextField.bottomAnchor, constant: 16),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 16),
            cancelButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor)
        ])
    }
    
    // MARK: - Actions
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    @objc private func saveTapped() {
        guard let link = linkTextField.text, !link.isEmpty else { return }
        dismiss(animated: true) { [weak self] in
            self?.onSave?(link)
        }
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true) { [weak self] in
            self?.onCancel?()
        }
    }
}