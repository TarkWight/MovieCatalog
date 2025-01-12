//
//  TagView.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//

import UIKit


final class TagView: UIView {
    private let label = UILabel()
    private var gradientLayer: CAGradientLayer?

    var text: String? {
        didSet {
            label.text = text
            updateWidth()
        }
    }

    var isActive: Bool = false {
        didSet {
            updateGradient()
        }
    }

    var onToggleFavorite: (() -> Void)?

    init(text: String, isActive: Bool = false, onToggleFavorite: (() -> Void)? = nil) {
        self.isActive = isActive
        self.onToggleFavorite = onToggleFavorite
        super.init(frame: .zero)
        self.text = text
        setupView()
        addTapGesture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        addTapGesture()
    }

    private func setupView() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 28).isActive = true

        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "AppWhite")
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        updateGradient()
    }

    private func updateWidth() {
        let labelWidth = label.intrinsicContentSize.width
        widthAnchor.constraint(equalToConstant: labelWidth + 16).isActive = true
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleActiveState))
        addGestureRecognizer(tapGesture)
    }

    private func updateGradient() {
        gradientLayer?.removeFromSuperlayer()
        
        let gradientColors: [UIColor] = isActive
        ? [GradientColor.start, GradientColor.end]
        : [UIColor(named: "AppDarkFaded") ?? .darkGray, UIColor(named: "AppDarkFaded") ?? .darkGray]
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = gradientColors.map { $0.cgColor }
        gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer?.frame = bounds
        gradientLayer?.cornerRadius = 8
        
        if let gradientLayer = gradientLayer {
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }

    @objc private func toggleActiveState() {
        isActive.toggle()
        onToggleFavorite?()
    }
}
