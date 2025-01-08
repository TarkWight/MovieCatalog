//
//  CustomTextField.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import UIKit

final class CustomTextField: UIView {

    public enum FieldType {
        case text, password, date
    }

    // MARK: - Constants
    private enum Constants {
        static let textFieldFontName = "Manrope-Regular"
        static let textFieldFontSize: CGFloat = 14
        static let textFieldBorderColor = UIColor(named: "AppDarkFaded")
        static let textFieldTextColor = UIColor(named: "AppWhite")
        static let textFieldPlaceholderColor = UIColor(named: "AppGrayFaded") ?? UIColor.lightGray
        
        static let iconButtonWidth: CGFloat = 24
        static let iconButtonHeight: CGFloat = 24
        static let eyeIcon = "Eye"
        static let eyeOffIcon = "Eye Off"
        static let closeIcon = "Close"
        static let calendarIcon = "Calendar"
        
        static let datePickerButtonTitle = "Done"
    }

    // MARK: - Properties
    public let textField = UITextField()
    private let iconButton = UIButton(type: .system)
    private var fieldType: FieldType
    public var onTextChanged: ((String) -> Void)?

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

    // MARK: - Setup Methods
    private func setupViews() {
        setupTextField()
        setupIconButton()
    }

    private func setupTextField() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        textField.borderStyle = .roundedRect
        textField.backgroundColor = Constants.textFieldBorderColor
        textField.textColor = Constants.textFieldTextColor
        textField.font = UIFont(name: Constants.textFieldFontName, size: Constants.textFieldFontSize)
        textField.rightViewMode = .always
        textField.rightView = iconButton
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }

    private func setupIconButton() {
        iconButton.frame = CGRect(x: 0, y: 0, width: Constants.iconButtonWidth, height: Constants.iconButtonHeight)
        iconButton.tintColor = Constants.textFieldTextColor
        iconButton.contentMode = .scaleAspectFit
    }

    private func configureField(for type: FieldType, placeholder: String) {
        configurePlaceholder(placeholder)

        switch type {
        case .text:
            configureTextFieldForTextType()
        case .password:
            configureTextFieldForPasswordType()
        case .date:
            configureTextFieldForDateType()
        }
    }

    private func configurePlaceholder(_ placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: Constants.textFieldPlaceholderColor,
                .font: UIFont(name: Constants.textFieldFontName, size: Constants.textFieldFontSize) ?? UIFont.systemFont(ofSize: Constants.textFieldFontSize)
            ]
        )
    }

    // MARK: - Field Type Configurations
    private func configureTextFieldForTextType() {
        iconButton.setImage(UIImage(named: Constants.closeIcon), for: .normal)
        iconButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }

    private func configureTextFieldForPasswordType() {
        textField.isSecureTextEntry = true
        iconButton.setImage(UIImage(named: Constants.eyeIcon), for: .normal)
        iconButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
    }

    private func configureTextFieldForDateType() {
        iconButton.setImage(UIImage(named: Constants.calendarIcon), for: .normal)
        iconButton.tintColor = Constants.textFieldPlaceholderColor
        iconButton.isHidden = false
        iconButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func textChanged() {
        let hasText = !(textField.text?.isEmpty ?? true)
        iconButton.isHidden = (fieldType == .text || fieldType == .password) ? !hasText : false
        onTextChanged?(textField.text ?? "")
    }

    @objc private func clearText() {
        textField.text = ""
        iconButton.isHidden = true
        onTextChanged?("")
    }

    @objc private func togglePasswordVisibility() {
        textField.isSecureTextEntry.toggle()
        let iconName = textField.isSecureTextEntry ? Constants.eyeIcon : Constants.eyeOffIcon
        iconButton.setImage(UIImage(named: iconName), for: .normal)
    }

    @objc private func showDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Constants.datePickerButtonTitle, style: .done, target: self, action: #selector(donePickingDate))
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
            iconButton.tintColor = Constants.textFieldTextColor
        }
        textField.resignFirstResponder()
    }
}
