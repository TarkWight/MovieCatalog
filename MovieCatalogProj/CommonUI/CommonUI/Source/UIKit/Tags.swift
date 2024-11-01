//
//  Tags.swift
//  CommonUI
//
//  Created by Tark Wight on 01.11.2024.
//

import UIKit

public class TagView: UIView {
    private let label = UILabel()

    var text: String? {
        didSet { label.text = text }
    }
    
    var isActive: Bool = false {
        didSet {
            backgroundColor = isActive ? UIColor(named: "AccentColor") : UIColor(named: "AppGray")
        }
    }

    public init(text: String, isActive: Bool = false) {
        super.init(frame: .zero)
        self.text = text
        self.isActive = isActive
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = isActive ? UIColor(named: "AccentColor") : UIColor(named: "AppGray")
        layer.cornerRadius = 14
        layer.masksToBounds = true
        
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "AppWhite")
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
