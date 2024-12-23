//
//  GenderPickerView.swift
//  CommonUI
//
//  Created by Tark Wight on 25.10.2024.
//


import UIKit

public class GenderPickerView: UIView {
    
    private let maleView = UIView()
    private let femaleView = UIView()
    
    private let maleLabel = UILabel()
    private let femaleLabel = UILabel()
    
    public var selectedGender: String = NSLocalizedString("gender_male", comment: "Male gender") {
        didSet {
            updateUI(for: selectedGender)
            onGenderSelected?(selectedGender)
        }
    }
    
    public var onGenderSelected: ((String) -> Void)?
    
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
    
    private func setupViews() {
        maleView.backgroundColor = .darkGray
        maleLabel.text = NSLocalizedString("gender_male", comment: "Male gender")
        maleLabel.textColor = .white
        maleLabel.textAlignment = .center
        maleView.addSubview(maleLabel)
        
        femaleView.backgroundColor = .darkGray
        femaleLabel.text = NSLocalizedString("gender_female", comment: "Female gender")
        femaleLabel.textColor = .white
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
                                    cornerRadii: CGSize(width: 10, height: 10))
        let maleMask = CAShapeLayer()
        maleMask.path = malePath.cgPath
        maleView.layer.mask = maleMask
        
        let femalePath = UIBezierPath(roundedRect: femaleView.bounds,
                                      byRoundingCorners: [.topRight, .bottomRight],
                                      cornerRadii: CGSize(width: 10, height: 10))
        let femaleMask = CAShapeLayer()
        femaleMask.path = femalePath.cgPath
        femaleView.layer.mask = femaleMask
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius()
        updateUI(for: selectedGender)
    }
    
    private func addGestureRecognizers() {
        let maleTap = UITapGestureRecognizer(target: self, action: #selector(selectMale))
        let femaleTap = UITapGestureRecognizer(target: self, action: #selector(selectFemale))
        maleView.addGestureRecognizer(maleTap)
        femaleView.addGestureRecognizer(femaleTap)
    }
    
    @objc private func selectMale() {
        selectedGender = NSLocalizedString("gender_male", comment: "Male gender")
    }
    
    @objc private func selectFemale() {
        selectedGender = NSLocalizedString("gender_female", comment: "Female gender")
    }
    
    private func updateUI(for gender: String) {
        UIView.animate(withDuration: 0.3) {
            self.maleView.backgroundColor = gender == NSLocalizedString("gender_male", comment: "Male gender") ? .clear : .darkGray
            self.femaleView.backgroundColor = gender == NSLocalizedString("gender_female", comment: "Female gender") ? .clear : .darkGray
            
            if gender == NSLocalizedString("gender_male", comment: "Male gender") {
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
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
        
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
        view.backgroundColor = .darkGray
    }
}
