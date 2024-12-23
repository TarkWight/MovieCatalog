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
        didSet {
            label.text = text
            updateWidth()
        }
    }
    
    public var isActive: Bool = false {
        didSet {
            backgroundColor = isActive ? UIColor(named: "AccentColor") : UIColor(named: "AppGray")
        }
    }
    
    public init(text: String, isActive: Bool = false) {
        super.init(frame: .zero)
        self.text = text
        self.isActive = isActive
        setupView()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        addTapGesture()
    }
    
    private func setupView() {
        backgroundColor = isActive ? UIColor(named: "AccentColor") : UIColor(named: "AppGray")
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
    }
    
    private func updateWidth() {
        let labelWidth = label.intrinsicContentSize.width
        widthAnchor.constraint(equalToConstant: labelWidth + 4).isActive = true
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleActiveState))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func toggleActiveState() {
        isActive.toggle()
    }
}
