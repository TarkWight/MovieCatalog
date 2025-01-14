//
//  GenderPickerView.swift
//  CommonUI
//
//  Created by Tark Wight on 25.10.2024.
//

import UIKit

final class GenderPickerView: UIView {

    // MARK: - Constants
    private enum Constants {
        enum Colors {
            static let selectedGradientStart = UIColor.red.cgColor
            static let selectedGradientEnd = UIColor.orange.cgColor
            static let deselectedBackground = UIColor.darkGray
            static let textColor = UIColor.white
        }
        
        enum CornerRadius {
            static let value: CGFloat = 10
        }
        
        enum Animation {
            static let duration: TimeInterval = 0.3
        }
        
        enum Localization {
            static let male = LocalizedKey.Сomponents.Gender.genderMale
            static let female = LocalizedKey.Сomponents.Gender.genderFemale
        }
    }

    // MARK: - UI Elements
    private let maleView = UIView()
    private let femaleView = UIView()
    
    private let maleLabel = UILabel()
    private let femaleLabel = UILabel()

    // MARK: - Properties
    var selectedGender: String = Constants.Localization.male {
        didSet {
            updateUI(for: selectedGender)
            onGenderSelected?(selectedGender)
        }
    }
    
    public var onGenderSelected: ((String) -> Void)?
    
    // MARK: - Initializer
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        addGestureRecognizers()
        updateUI(for: selectedGender)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        addGestureRecognizers()
        updateUI(for: selectedGender)
    }
    
    // MARK: - Setup Methods
    private func setupViews() {
        maleView.backgroundColor = Constants.Colors.deselectedBackground
        maleLabel.text = Constants.Localization.male
        maleLabel.textColor = Constants.Colors.textColor
        maleLabel.textAlignment = .center
        maleView.addSubview(maleLabel)
        
        femaleView.backgroundColor = Constants.Colors.deselectedBackground
        femaleLabel.text = Constants.Localization.female
        femaleLabel.textColor = Constants.Colors.textColor
        femaleLabel.textAlignment = .center
        femaleView.addSubview(femaleLabel)
        
        addSubview(maleView)
        addSubview(femaleView)
        
        maleView.translatesAutoresizingMaskIntoConstraints = false
        femaleView.translatesAutoresizingMaskIntoConstraints = false
        maleLabel.translatesAutoresizingMaskIntoConstraints = false
        femaleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            maleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            maleView.topAnchor.constraint(equalTo: self.topAnchor),
            maleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            maleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            femaleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            femaleView.topAnchor.constraint(equalTo: self.topAnchor),
            femaleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            femaleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            
            maleLabel.centerXAnchor.constraint(equalTo: maleView.centerXAnchor),
            maleLabel.centerYAnchor.constraint(equalTo: maleView.centerYAnchor),
            
            femaleLabel.centerXAnchor.constraint(equalTo: femaleView.centerXAnchor),
            femaleLabel.centerYAnchor.constraint(equalTo: femaleView.centerYAnchor),
        ])
        
        setCornerRadius()
    }
    
    private func setCornerRadius() {
        let malePath = UIBezierPath(roundedRect: maleView.bounds,
                                    byRoundingCorners: [.topLeft, .bottomLeft],
                                    cornerRadii: CGSize(width: Constants.CornerRadius.value, height: Constants.CornerRadius.value))
        let maleMask = CAShapeLayer()
        maleMask.path = malePath.cgPath
        maleView.layer.mask = maleMask
        
        let femalePath = UIBezierPath(roundedRect: femaleView.bounds,
                                      byRoundingCorners: [.topRight, .bottomRight],
                                      cornerRadii: CGSize(width: Constants.CornerRadius.value, height: Constants.CornerRadius.value))
        let femaleMask = CAShapeLayer()
        femaleMask.path = femalePath.cgPath
        femaleView.layer.mask = femaleMask
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius()
        updateUI(for: selectedGender)
    }
    
    // MARK: - Gesture Recognizers
    private func addGestureRecognizers() {
        let maleTap = UITapGestureRecognizer(target: self, action: #selector(selectMale))
        let femaleTap = UITapGestureRecognizer(target: self, action: #selector(selectFemale))
        maleView.addGestureRecognizer(maleTap)
        femaleView.addGestureRecognizer(femaleTap)
    }
    
    @objc private func selectMale() {
        selectedGender = Constants.Localization.male
    }
    
    @objc private func selectFemale() {
        selectedGender = Constants.Localization.female
    }
    
    // MARK: - Update UI
    private func updateUI(for gender: String) {
        UIView.animate(withDuration: Constants.Animation.duration) {
            self.maleView.backgroundColor = gender == Constants.Localization.male ? .clear : Constants.Colors.deselectedBackground
            self.femaleView.backgroundColor = gender == Constants.Localization.female ? .clear : Constants.Colors.deselectedBackground
            
            if gender == Constants.Localization.male {
                self.applyGradient(to: self.maleView)
                self.removeGradient(from: self.femaleView)
            } else {
                self.applyGradient(to: self.femaleView, mirrored: true)
                self.removeGradient(from: self.maleView)
            }
            self.setCornerRadius()
        }
    }
    
    private func applyGradient(to view: UIView, mirrored: Bool = false) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.Colors.selectedGradientStart, Constants.Colors.selectedGradientEnd]
        
        if mirrored {
            gradientLayer.startPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0, y: 0.5)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        }
        
        gradientLayer.frame = view.bounds
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func removeGradient(from view: UIView) {
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        view.backgroundColor = Constants.Colors.deselectedBackground
    }
}
