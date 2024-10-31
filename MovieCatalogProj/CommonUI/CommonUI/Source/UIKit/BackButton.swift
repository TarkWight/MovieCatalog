//
//  BackButton.swift
//  CommonUI
//
//  Created by Tark Wight on 26.10.2024.
//

import UIKit


public class BackButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        self.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(named: "AppDarkFaded")

        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = UIColor(named: "AppDarkFaded")
        configuration.image = UIImage(named: "ChevronLeft")
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading

        
        self.configuration = configuration

        self.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc private func backButtonTapped() {
        print("Back button tapped")
    }
}
