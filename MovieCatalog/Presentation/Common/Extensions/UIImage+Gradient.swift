//
//  UIImage+Gradient.swift
//  MovieCatalog
//
//  Created by Tark Wight on 12.01.2025.
//

import UIKit

extension UIImage {
    static func qImage(frame: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let render = UIGraphicsImageRenderer(bounds: frame)
        
        return render.image { context in
            gradientLayer.render(in: context.cgContext)
        }
    }
}
