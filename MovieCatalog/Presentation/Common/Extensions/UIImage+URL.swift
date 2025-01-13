//
//  UIImage+URL.swift
//  MovieCatalog
//
//  Created by Tark Wight on 14.01.2025.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String?, placeholder: UIImage?) {
        self.image = placeholder
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            print("Invalid URL string.")
            return
        }
        
        Task {
            if let downloadedImage = await ImageManagerActor.shared.loadImage(from: url) {
                DispatchQueue.main.async { [weak self] in
                    self?.image = downloadedImage
                }
            } else {
                print("Failed to load image from URL. Using placeholder.")
            }
        }
    }
}


