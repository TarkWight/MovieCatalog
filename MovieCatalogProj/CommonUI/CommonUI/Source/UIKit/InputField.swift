//
//  InputField.swift
//  CommonUI
//
//  Created by Tark Wight on 25.10.2024.
//


//
//  InputField.swift
//  CommonUI
//
//  Created by Tark Wight on 25.10.2024.
//

import UIKit

public class InputField: UIView {
    
    public enum FieldType {
        case text, password, date
    }
    
    private let textField = UITextField()
    private let iconButton = UIButton(type: .system)
    private var fieldType: FieldType
    
    public var onTextChanged: ((String) -> Void)?
    
    public init(placeholder: String, type: FieldType) {
        self.fieldType = type
        super.init(frame: .zero)
        setupViews()
        configureField(for: type, placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(named: "AppDarkFaded")
        textField.textColor = UIColor(named: "AppWhite")
        textField.font = UIFont(name: "Manrope-Regular", size: 14)
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        textField.rightViewMode = .always
        textField.rightView = iconButton
        
        iconButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        iconButton.tintColor = UIColor(named: "AppWhite")
        iconButton.contentMode = .scaleAspectFit
    }
    
    private func configureField(for type: FieldType, placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor(named: "AppGrayFaded") ?? UIColor.lightGray,
                .font: UIFont(name: "Manrope-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
            ]
        )
        
        iconButton.isHidden = true
        
        switch type {
            case .text:
                iconButton.setImage(UIImage(named: "Close"), for: .normal)
                iconButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
            case .password:
                textField.isSecureTextEntry = true
                iconButton.setImage(UIImage(named: "Eye"), for: .normal)
                iconButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
            case .date:
                iconButton.setImage(UIImage(named: "Calendar"), for: .normal)
                iconButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
                iconButton.tintColor = UIColor(named: "AppGrayFaded")
                iconButton.isHidden = false
        }
    }
    
    @objc private func textChanged() {
        let hasText = !(textField.text?.isEmpty ?? true)
        
        if fieldType == .text || fieldType == .password {
            iconButton.isHidden = !hasText
        }
        
        onTextChanged?(textField.text ?? "")
    }
    
    @objc private func clearText() {
        textField.text = ""
        iconButton.isHidden = true
        onTextChanged?("")
    }
    
    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let iconName = textField.isSecureTextEntry ? "Eye" : "Eye Off"
        iconButton.setImage(UIImage(named: iconName), for: .normal)
    }
    
    @objc private func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickingDate))
        toolbar.setItems([doneButton], animated: true)
        
        textField.inputView = datePicker
        textField.inputAccessoryView = toolbar
        textField.becomeFirstResponder()
    }
    
    @objc private func donePickingDate() {
        if let datePicker = textField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            textField.text = dateFormatter.string(from: datePicker.date)
            onTextChanged?(textField.text ?? "")
            iconButton.tintColor = UIColor(named: "AppWhite")
        }
        textField.resignFirstResponder()
    }
}
