//
//  Tags.swift
//  CommonUI
//
//  Created by Tark Wight on 01.11.2024.
//

import UIKit

enum TagState {
    case active
    case inactive
}

class TagView: UIView {
    private let label = UILabel()
    private var tagState: TagState = .inactive {
        didSet {
            updateAppearance()
        }
    }
    
    var text: String? {
        didSet {
            label.text = text
            label.sizeToFit()
            frame.size.width = label.bounds.width + 12
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
        
        layer.cornerRadius = 14
        clipsToBounds = true
    }
    
    func setState(_ state: TagState) {
        self.tagState = state
    }
    
    private func updateAppearance() {
        switch tagState {
        case .active:
            applyGradient(colors: [UIColor.blue, UIColor.cyan], frame: bounds)
        case .inactive:
            backgroundColor = UIColor.gray
        }
    }
}

