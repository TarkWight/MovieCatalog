//
//  UIView+Gradient.swift
//  CommonUI
//
//  Created by Tark Wight on 01.11.2024.
//

import UIKit

extension UIView {
    open func applyGradient(colors: [UIColor], frame: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.frame = frame
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

