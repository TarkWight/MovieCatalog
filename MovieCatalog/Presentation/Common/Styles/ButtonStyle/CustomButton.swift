//
//  CustomButton.swift
//  MovieCatalog
//
//  Created by Tark Wight on 05.01.2025.
//

import UIKit

final class CustomButton: UIButton {

    // MARK: - Properties
    private var gradientLayer: CAGradientLayer?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Setup Method
    private func setup() {
        titleLabel?.font = Constants.font
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Gradient Background
    private func getGradientColors() -> (UIColor, UIColor) {
        let color1 = UIColor(named: Constants.gradientLeftColorName) ?? Constants.defaultGradientLeftColor
        let color2 = UIColor(named: Constants.gradientRightColorName) ?? Constants.defaultGradientRightColor
        return (color1, color2)
    }

    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        let (color1, color2) = getGradientColors()

        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = Constants.gradientStartPoint
        gradientLayer.endPoint = Constants.gradientEndPoint
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer = gradientLayer
    }

    func setSolidBackground(color: UIColor) {
        gradientLayer?.removeFromSuperlayer()
        backgroundColor = color
    }

    // MARK: - Set Size
    func setSize(width: CGFloat, height: CGFloat) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width),
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }

    // MARK: - Button States
    enum ButtonState {
        case `default`
        case disabled
        case secondary
    }

    func configure(for state: ButtonState) {
        gradientLayer?.removeFromSuperlayer()
        gradientLayer = nil

        switch state {
        case .default:
            isUserInteractionEnabled = true
            setGradientBackground()
            setTitleColor(Constants.defaultTextColor, for: .normal)

        case .disabled:
            isUserInteractionEnabled = false
            setSolidBackground(color: UIColor(named: Constants.disabledBackgroundColorName) ?? Constants.defaultDisabledBackgroundColor)
            setTitleColor(UIColor(named: Constants.disabledTextColorName) ?? Constants.defaultDisabledTextColor, for: .normal)

        case .secondary:
            isUserInteractionEnabled = true
            setSolidBackground(color: UIColor(named: Constants.secondaryBackgroundColorName) ?? Constants.defaultSecondaryBackgroundColor)
            setTitleColor(Constants.defaultTextColor, for: .normal)
        }
    }

    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }

    // MARK: - Constants
    private enum Constants {
        /// Fonts & Style
        static let font: UIFont = .systemFont(ofSize: 16, weight: .bold)
        static let cornerRadius: CGFloat = 10

        /// Gradient
        static let gradientLeftColorName = "gradientLeftColor"
        static let gradientRightColorName = "gradientRightColor"
        static let defaultGradientLeftColor = UIColor.red
        static let defaultGradientRightColor = UIColor.orange
        static let gradientStartPoint = CGPoint(x: 0.0, y: 0.0)
        static let gradientEndPoint = CGPoint(x: 1.0, y: 0.0)

        /// Disabled State
        static let disabledBackgroundColorName = "AppDarkFaded"
        static let defaultDisabledBackgroundColor = UIColor.darkGray
        static let disabledTextColorName = "AppGrayFaded"
        static let defaultDisabledTextColor = UIColor.gray

        /// Secondary State
        static let secondaryBackgroundColorName = "AppDarkFaded"
        static let defaultSecondaryBackgroundColor = UIColor.darkGray

        /// Default Text Color
        static let defaultTextColor = UIColor.white
    }
}
