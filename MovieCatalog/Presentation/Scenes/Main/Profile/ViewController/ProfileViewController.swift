//
//  ProfileViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import UIKit

final class ProfileViewController: BaseViewController {
    // MARK: - Property
    private let viewModel: ProfileViewModel
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let profileImageView = UIImageView()
    private let greetingLabel = UILabel()
    private let logoutButton = UIButton(type: .system)
    
    private let friendsButton = CustomButton()
    
    private let personalInfoTitle = UILabel()
    
    private let usernameTitle = UILabel()
    private let usernameField = CustomTextField(placeholder: Constants.Localized.usernamePlaceholder, type: .text)
    
    private let emailTitle = UILabel()
    private let emailField = CustomTextField(placeholder: Constants.Localized.emailPlaceholder, type: .text)
    
    private let fullNameTitle = UILabel()
    private let fullNameField = CustomTextField(placeholder: Constants.Localized.namePlaceholder, type: .text)
    
    private let birthDateTitle = UILabel()
    private let birthDateField = CustomTextField(placeholder: Constants.Localized.birthdatePlaceholder, type: .date)
    
    private let gernderTitle = UILabel()
    private let genderPicker = GenderPickerView()
    
    private let saveButton = CustomButton()
    private let cancelButton = CustomButton()
    
    private var isEditingProfile = false {
        didSet { updateUIForEditingState() }
    }
    
    
    // MARK: - Initializer
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        hideBackButton()
        super.viewDidLoad()
        setBackgroundImage(
            named: Constants.Images.background,
            topOffset: 0,
            heightMultiplier: Constants.Layout.backgroundHeightMultiplier,
            cornerRadius: Constants.Layout.backgroundCornerRadius,
            bottomGradientHeight: Constants.Layout.bottomGradientHeight
        )
        setupUI()
        bindViewModel()
        viewModel.handle(.onAppear)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [scrollView, contentView,
         profileImageView, greetingLabel, logoutButton,
         friendsButton,
         personalInfoTitle,
         usernameTitle, usernameField,
         emailTitle, emailField,
         fullNameTitle, fullNameField,
         birthDateTitle, birthDateField,
         gernderTitle, genderPicker,
         saveButton, cancelButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editAvatarTapped))
        profileImageView.addGestureRecognizer(tapGesture)
        
        
        personalInfoTitle.text = Constants.Localized.personalInfoTitle
        personalInfoTitle.font = Constants.Fonts.sectionTitle
        personalInfoTitle.setGradientText(colors: [GradientColor.start, GradientColor.end])
        
        usernameTitle.text = Constants.Localized.usernameTitle
        usernameTitle.font = Constants.Fonts.inputTitle
        usernameTitle.textColor = Constants.Colors.title
        
        emailTitle.text = Constants.Localized.emailTitle
        emailTitle.font = Constants.Fonts.inputTitle
        emailTitle.textColor = Constants.Colors.title
        
        fullNameTitle.text = Constants.Localized.nameTitle
        fullNameTitle.font = Constants.Fonts.inputTitle
        fullNameTitle.textColor = Constants.Colors.title
        
        birthDateTitle.text = Constants.Localized.birthdateTitle
        birthDateTitle.font = Constants.Fonts.inputTitle
        birthDateTitle.textColor = Constants.Colors.title
        
        gernderTitle.text = Constants.Localized.genderTitle
        gernderTitle.font = Constants.Fonts.inputTitle
        gernderTitle.textColor = Constants.Colors.title
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(greetingLabel)
        contentView.addSubview(logoutButton)
        
        contentView.addSubview(friendsButton)
        
        contentView.addSubview(personalInfoTitle)
        
        contentView.addSubview(usernameTitle)
        contentView.addSubview(usernameField)
        
        contentView.addSubview(emailTitle)
        contentView.addSubview(emailField)
        
        contentView.addSubview(fullNameTitle)
        contentView.addSubview(fullNameField)
        
        contentView.addSubview(birthDateTitle)
        contentView.addSubview(birthDateField)
        
        contentView.addSubview(gernderTitle)
        contentView.addSubview(genderPicker)
        
        contentView.addSubview(saveButton)
        contentView.addSubview(cancelButton)
        
        birthDateField.isCalendarButtonHiddenByDefault = true
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Profile Image
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Layout.greetingTopPadding),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.avatarSize),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.avatarSize),
            
            // Greeting Label
            greetingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Layout.greetingTopPadding),
            greetingLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.Layout.greetingSpacing),
            greetingLabel.trailingAnchor.constraint(lessThanOrEqualTo: logoutButton.leadingAnchor, constant: -Constants.Layout.greetingSpacing),
            
            // Logout Button
            logoutButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            logoutButton.widthAnchor.constraint(equalToConstant: 40),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Friends Button
            friendsButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Constants.Layout.sectionSpacing),
            friendsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            friendsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            friendsButton.heightAnchor.constraint(equalToConstant: 64),
            
            // Personal Info Title
            personalInfoTitle.topAnchor.constraint(equalTo: friendsButton.bottomAnchor, constant: Constants.Layout.sectionSpacing),
            personalInfoTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            personalInfoTitle.heightAnchor.constraint(equalToConstant: 24),
            
            // Username Title
            usernameTitle.topAnchor.constraint(equalTo: personalInfoTitle.bottomAnchor, constant: Constants.Layout.stackSpacing),
            usernameTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            usernameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            usernameTitle.heightAnchor.constraint(equalToConstant: 20),
            
            // Username Field
            usernameField.topAnchor.constraint(equalTo: usernameTitle.bottomAnchor, constant: Constants.Layout.inputStackSpacing),
            usernameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            usernameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            usernameField.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            
            // Email Title
            emailTitle.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: Constants.Layout.stackSpacing),
            emailTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            emailTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            emailTitle.heightAnchor.constraint(equalToConstant: 20),
            
            // Email Field
            emailField.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: Constants.Layout.inputStackSpacing),
            emailField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            emailField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            emailField.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            
            // Full Name Title
            fullNameTitle.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: Constants.Layout.stackSpacing),
            fullNameTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            fullNameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            fullNameTitle.heightAnchor.constraint(equalToConstant: 20),
            
            // Full Name Field
            fullNameField.topAnchor.constraint(equalTo: fullNameTitle.bottomAnchor, constant: Constants.Layout.inputStackSpacing),
            fullNameField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            fullNameField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            fullNameField.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            
            // Birth Date Title
            birthDateTitle.topAnchor.constraint(equalTo: fullNameField.bottomAnchor, constant: Constants.Layout.stackSpacing),
            birthDateTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            birthDateTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            birthDateTitle.heightAnchor.constraint(equalToConstant: 20),
            
            // Birth Date Field
            birthDateField.topAnchor.constraint(equalTo: birthDateTitle.bottomAnchor, constant: Constants.Layout.inputStackSpacing),
            birthDateField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            birthDateField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            birthDateField.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            
            // Gender Title
            gernderTitle.topAnchor.constraint(equalTo: birthDateField.bottomAnchor, constant: Constants.Layout.stackSpacing),
            gernderTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            gernderTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            gernderTitle.heightAnchor.constraint(equalToConstant: 20),
            
            // Gender Picker
            genderPicker.topAnchor.constraint(equalTo: gernderTitle.bottomAnchor, constant: Constants.Layout.inputStackSpacing),
            genderPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            genderPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            genderPicker.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            
            // Save Button
            saveButton.topAnchor.constraint(equalTo: genderPicker.bottomAnchor, constant: Constants.Layout.sectionSpacing),
            saveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.contentPadding),
            saveButton.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -Constants.Layout.buttonSpacing),
            saveButton.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),
            
            // Cancel Button
            cancelButton.topAnchor.constraint(equalTo: genderPicker.bottomAnchor, constant: Constants.Layout.sectionSpacing),
            cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.contentPadding),
            cancelButton.heightAnchor.constraint(equalToConstant: Constants.Layout.inputFieldHeight),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Layout.contentPadding)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onProfileLoaded = { [weak self] profile in
            self?.updateUI(with: profile)
        }
        
        viewModel.onError = { errorMessage in
            print("Error:", errorMessage)
        }
    }
    
    
    
    private func updateUI(with profile: Profile) {
        if let avatarLink = URL(string: profile.avatarLink) {
            Task {
                let avatarImage = await ImageManagerActor.shared.loadImage(from: avatarLink)
                DispatchQueue.main.async {
                    self.profileImageView.image = avatarImage ?? Constants.Images.avatarPlaceholder
                }
            }
        } else {
            profileImageView.image = Constants.Images.avatarPlaceholder
        }
        
        updateGreetingLabel(with: profile)
        usernameField.textField.placeholder = profile.nickName
        emailField.textField.placeholder = profile.email
        fullNameField.textField.placeholder = profile.name
        birthDateField.textField.placeholder = DateFormatter.dateOnly.string(from: profile.birthDate)
    }
    
    private func updateGreetingLabel(with profile: Profile) {
        let greetingText = Constants.Localized.greetingPrefix
        let nameText = profile.name
        
        let attributedString = NSMutableAttributedString(
            string: "\(greetingText),\n",
            attributes: [
                .font: Constants.Fonts.greetingP1,
                .foregroundColor: Constants.Colors.lable
            ]
        )
        
        attributedString.append(NSAttributedString(
            string: nameText,
            attributes: [
                .font: Constants.Fonts.greetingP2,
                .foregroundColor: Constants.Colors.lable
            ]
        ))
        
        greetingLabel.attributedText = attributedString
        greetingLabel.numberOfLines = 0
        greetingLabel.lineBreakMode = .byWordWrapping
    }
    
    private func updateUIForEditingState() {
        saveButton.isHidden = !isEditingProfile
        cancelButton.isHidden = !isEditingProfile
        
        [usernameField, emailField, fullNameField, birthDateField].forEach {
            $0.textField.isUserInteractionEnabled = isEditingProfile
        }
    }
    
    @objc private func saveTapped() {
        isEditingProfile = false
        viewModel.handle(.saveTapped)
    }
    
    @objc private func cancelTapped() {
        isEditingProfile = false
        viewModel.handle(.cancelTapped)
    }
    
    @objc private func logoutTapped() {
        viewModel.handle(.logOutTapped)
    }
    
    @objc private func editAvatarTapped() {
        let modalVC = AvatarLinkModalViewController()
            
        modalVC.onSave = { [weak self] newAvatarURL in
            guard let self = self else { return }
            
            self.viewModel.handle(.avatarLinkChanged(newAvatarURL))
            
            Task {
                 self.viewModel.handle(.saveTapped)
            }
            
            self.dismiss(animated: true)
        }

        modalVC.onCancel = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        present(modalVC, animated: true)
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isEditingProfile = true
    }
}
private extension ProfileViewController {
    enum Constants {
        enum Localized {
            static let title = LocalizedKey.Profile.Label.title
            static let greetingPrefix: String = {
                let hour = Calendar.current.component(.hour, from: Date())
                switch hour {
                case 6..<12: return LocalizedKey.Profile.Greeting.morning
                case 12..<18: return LocalizedKey.Profile.Greeting.day
                case 18..<24: return LocalizedKey.Profile.Greeting.evening
                default: return LocalizedKey.Profile.Greeting.night
                }
            }()
            static let friendsButton = LocalizedKey.Profile.Button.friends
            static let personalInfoTitle = LocalizedKey.Profile.Label.title
            static let usernameTitle = LocalizedKey.Profile.Edit.username
            static let emailTitle = LocalizedKey.Profile.Edit.email
            static let nameTitle = LocalizedKey.Profile.Edit.name
            static let birthdateTitle = LocalizedKey.Profile.Edit.birthdate
            static let genderTitle = LocalizedKey.Profile.Edit.gender
            static let usernamePlaceholder = LocalizedKey.Profile.Edit.username
            static let emailPlaceholder = LocalizedKey.Profile.Edit.email
            static let namePlaceholder = LocalizedKey.Profile.Edit.name
            static let birthdatePlaceholder = LocalizedKey.Profile.Edit.birthdate
            static let male = LocalizedKey.Сomponents.Gender.genderMale
            static let female = LocalizedKey.Сomponents.Gender.genderFemale
            static let saveButton = LocalizedKey.Profile.Button.save
            static let cancelButton = LocalizedKey.Profile.Button.cancel
        }
        
        enum Layout {
            static let backgroundHeightMultiplier: CGFloat = 0.2
            static let backgroundCornerRadius: CGFloat = 16
            static let topGradientHeight: CGFloat = 160
            static let bottomGradientHeight: CGFloat = 160
            static let greetingTopPadding: CGFloat = 122
            static let contentPadding: CGFloat = 24
            static let greetingSpacing: CGFloat = 16
            static let avatarSize: CGFloat = 96
            static let sectionSpacing: CGFloat = 24
            static let stackSpacing: CGFloat = 16
            static let inputStackSpacing: CGFloat = 8
            static let inputFieldHeight: CGFloat = 48
            static let buttonSpacing: CGFloat = 16
        }
        
        enum Fonts {
            static func customFont(name: String, size: CGFloat) -> UIFont {
                return UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
            }
            
            static let greetingP1 = customFont(name: "Manrope-Regular", size: 16)
            static let greetingP2 = customFont(name: "Manrope-Bold", size: 24)
            static let sectionTitle = customFont(name: "Manrope-Bold", size: 20)
            static let inputTitle = customFont(name: "Manrope-Regular", size: 16)
            static let buttonTitle = customFont(name: "Manrope-SemiBold", size: 18)
        }
        
        enum Images {
            static let background = "Mountain"
            static let avatarPlaceholder = UIImage(named: "AvatarPlaceholder")
            static let logoutIcon = UIImage(named: "Logout")
        }
        
        enum Colors {
            static let title = UIColor(named: "AppGray") ?? .gray
            static let lable = UIColor(named: "AppWhite") ?? .white
        }
    }
}
