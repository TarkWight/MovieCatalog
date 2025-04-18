//
//  FriendsButton.swift
//  MovieCatalog
//
//  Created by Tark Wight on 14.01.2025.
//

import UIKit

final class FriendsButton: UIButton {

    // MARK: - Properties
    private let avatarStackView = UIStackView()
    private let titleLabel_ = UILabel()

    private var avatars: [UIImage] = [] {
        didSet { updateAvatars() }
    }

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup
    private func setup() {
        backgroundColor = UIColor(named: "AppDarkFaded") ?? .darkGray
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        setupAvatarStackView()
        setupTitleLabel()
    }

    private func setupAvatarStackView() {
        avatarStackView.axis = .horizontal
        avatarStackView.alignment = .center
        avatarStackView.spacing = -8 // Перекрытие аватарок
        avatarStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarStackView)

        NSLayoutConstraint.activate([
            avatarStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarStackView.heightAnchor.constraint(equalToConstant: 32),
            avatarStackView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setupTitleLabel() {
        titleLabel_.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel_.textColor = .white
        titleLabel_.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel_)

        NSLayoutConstraint.activate([
            titleLabel_.leadingAnchor.constraint(equalTo: avatarStackView.trailingAnchor, constant: 16),
            titleLabel_.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel_.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    // MARK: - Public Methods
    func configure(with friends: [UIImage], title: String) {
        self.avatars = friends
        self.titleLabel_.text = title
    }

    // MARK: - Private Methods
    private func updateAvatars() {
        avatarStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let displayedAvatars = avatars.prefix(3) // Отображаем максимум 3 аватарки
        for avatar in displayedAvatars {
            let avatarImageView = UIImageView(image: avatar)
            avatarImageView.layer.cornerRadius = 16
            avatarImageView.clipsToBounds = true
            avatarImageView.contentMode = .scaleAspectFill
            avatarImageView.translatesAutoresizingMaskIntoConstraints = false
            avatarImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
            avatarImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true

            avatarStackView.addArrangedSubview(avatarImageView)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
    }
}
