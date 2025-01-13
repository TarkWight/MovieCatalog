//
//  BaseViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 08.01.2025.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    private var shouldShowBackButton: Bool = true
    private var backgroundImageView: UIImageView?
    private var cornerRadius: CGFloat = 16

    // MARK: - UI Elements
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ChevronLeft")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()

        if !shouldShowBackButton {
            hideCustomBackButton()
        }

        hideSystemBackButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMaskForBackgroundImage()
    }

    // MARK: - Public Methods
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }

    func hideBackButton() {
        shouldShowBackButton = false
    }

    func setBackgroundImage(named imageName: String,
                            topOffset: CGFloat,
                            heightMultiplier: CGFloat,
                            cornerRadius: CGFloat = 16,
                            topGradientHeight: CGFloat = 100,
                            bottomGradientHeight: CGFloat = 100) {
        backgroundImageView?.removeFromSuperview()

        guard let image = UIImage(named: imageName) else { return }

        self.cornerRadius = cornerRadius
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: topOffset),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: heightMultiplier)
        ])

        backgroundImageView = imageView
        applyCustomGradients(to: imageView, topGradientHeight: topGradientHeight, bottomGradientHeight: bottomGradientHeight)
    }

    // MARK: - Private Methods
    private func hideSystemBackButton() {
        navigationItem.hidesBackButton = true
    }

    private func hideCustomBackButton() {
        backButton.isHidden = true
    }

    private func setupBaseUI() {
        view.backgroundColor = UIColor(named: "AppDark")
        view.addSubview(backButton)
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 78),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16)
        ])

        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    private func applyCustomGradients(to imageView: UIImageView, topGradientHeight: CGFloat, bottomGradientHeight: CGFloat) {
        imageView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let topGradientLayer = CAGradientLayer()
        topGradientLayer.colors = [
            UIColor(named: "AppDark")?.cgColor ?? UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        topGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        topGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        let bottomGradientLayer = CAGradientLayer()
        bottomGradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor(named: "AppDark")?.cgColor ?? UIColor.black.cgColor
        ]
        bottomGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        bottomGradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        DispatchQueue.main.async {
            topGradientLayer.frame = CGRect(x: 0, y: 0, width: imageView.frame.width, height: topGradientHeight)
            bottomGradientLayer.frame = CGRect(
                x: 0,
                y: imageView.frame.height - bottomGradientHeight,
                width: imageView.frame.width,
                height: bottomGradientHeight
            )
            imageView.layer.addSublayer(topGradientLayer)
            imageView.layer.addSublayer(bottomGradientLayer)
        }
    }

    private func updateMaskForBackgroundImage() {
        guard let imageView = backgroundImageView else { return }
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: imageView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        ).cgPath
        imageView.layer.mask = maskLayer
    }

    // MARK: - Actions
    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
