//
//  CustomTextField.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import UIKit

public class CustomTextField: UIView {

    public enum FieldType {
        case text, password, date
    }

    public let textField = UITextField()
    private let iconButton = UIButton(type: .system)
    private var fieldType: FieldType
    public var onTextChanged: ((String) -> Void)?
    
    public var isCalendarButtonHiddenByDefault: Bool = false {
        didSet {
            if fieldType == .date {
                updateCalendarButtonState(isHidden: isCalendarButtonHiddenByDefault)
            }
        }
    }

    // MARK: - Initializer
    public init(placeholder: String, type: FieldType) {
        self.fieldType = type
        super.init(frame: .zero)
        setupViews()
        configureField(for: type, placeholder: placeholder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        addSubview(textField)
        addSubview(iconButton)

        textField.translatesAutoresizingMaskIntoConstraints = false
        iconButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),

            iconButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            iconButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Layout.iconSpacing),
            iconButton.widthAnchor.constraint(equalToConstant: Constants.Layout.iconSize),
            iconButton.heightAnchor.constraint(equalToConstant: Constants.Layout.iconSize)
        ])

        textField.borderStyle = .roundedRect
        textField.backgroundColor = Constants.Colors.textFieldBackground
        textField.textColor = Constants.Colors.textFieldText
        textField.font = Constants.Fonts.textField
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(handleFieldFocus), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(handleFieldBlur), for: .editingDidEnd)

        iconButton.tintColor = Constants.Colors.iconInactive
        iconButton.isHidden = true
    }

    private func configureField(for type: FieldType, placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Constants.Colors.placeholder,
                .font: Constants.Fonts.textField
            ]
        )

        switch type {
        case .text:
            configureTextFieldForTextType()
        case .password:
            configureTextFieldForPasswordType()
        case .date:
            configureTextFieldForDateType()
        }
    }

    private func configureTextFieldForTextType() {
        iconButton.setImage(UIImage(named: Constants.Images.clearIcon), for: .normal)
        iconButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }

    private func configureTextFieldForPasswordType() {
        textField.isSecureTextEntry = true
        iconButton.setImage(UIImage(named: Constants.Images.eyeIcon), for: .normal)
        iconButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }

    private func configureTextFieldForDateType() {
        iconButton.setImage(UIImage(named: Constants.Images.calendarIcon), for: .normal)
        iconButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        updateCalendarButtonState(isHidden: isCalendarButtonHiddenByDefault)
    }

    // MARK: - Actions
    @objc private func textChanged() {
        let hasText = !(textField.text?.isEmpty ?? true)

        if fieldType == .text || fieldType == .password {
            iconButton.isHidden = !hasText
        } else if fieldType == .date {
            updateCalendarButtonState(isHidden: !hasText)
        }

        onTextChanged?(textField.text ?? "")
    }

    @objc private func handleFieldFocus() {
        if fieldType == .date {
            updateCalendarButtonState(isHidden: false)
        }
    }

    @objc private func handleFieldBlur() {
        if fieldType == .date && isCalendarButtonHiddenByDefault {
            updateCalendarButtonState(isHidden: true)
        }
    }

    @objc private func clearText() {
        textField.text = ""
        iconButton.isHidden = true
        onTextChanged?("")
    }

    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let iconName = textField.isSecureTextEntry ? Constants.Images.eyeIcon : Constants.Images.eyeOffIcon
        iconButton.setImage(UIImage(named: iconName), for: .normal)
    }

    @objc private func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

//        datePicker.tintColor = UIColor(named: "AppPrimaryColor")
        datePicker.backgroundColor = UIColor(named: "AppGrayFaded")

        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickingDate))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [flexibleSpace, doneButton]

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
        }
        textField.resignFirstResponder()
    }

    // MARK: - Helper Methods
    private func updateCalendarButtonState(isHidden: Bool) {
        iconButton.isHidden = isHidden
        iconButton.tintColor = isHidden ? Constants.Colors.iconInactive : Constants.Colors.iconActive
    }
}

// MARK: - Constants
private extension CustomTextField {
    enum Constants {
        enum Fonts {
            static let textField = UIFont(name: "Manrope-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
        }

        enum Colors {
            static let textFieldBackground = UIColor(named: "AppDarkFaded") ?? .darkGray
            static let textFieldText = UIColor(named: "AppWhite") ?? .white
            static let placeholder = UIColor(named: "AppGrayFaded") ?? .darkGray
            static let iconActive = UIColor(named: "AppWhite") ?? .white
            static let iconInactive = UIColor(named: "AppGrayFaded") ?? .darkGray
        }

        enum Images {
            static let clearIcon = "Close Icon"
            static let eyeIcon = "Eye Icon"
            static let eyeOffIcon = "Eye Off Icon"
            static let calendarIcon = "Calendar Icon"
        }

        enum Layout {
            static let iconSize: CGFloat = 24
            static let iconSpacing: CGFloat = 12
        }

        enum Texts {
            static let datePickerDone = "Done"
        }
    }
}
