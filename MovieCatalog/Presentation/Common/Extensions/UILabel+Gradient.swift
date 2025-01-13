//
//  UILabel+Gradient.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//

import UIKit

extension UILabel {
    func setGradientText(colors: [UIColor]) {
        guard let text = self.text, let font = self.font else { return }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: font]
        let textSize = (text as NSString).size(withAttributes: textAttributes)
        
        gradientLayer.frame = CGRect(origin: .zero, size: textSize)
        
        UIGraphicsBeginImageContextWithOptions(textSize, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        gradientLayer.render(in: context)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let gradientImage = gradientImage {
            self.textColor = UIColor(patternImage: gradientImage)
        }
    }
}
