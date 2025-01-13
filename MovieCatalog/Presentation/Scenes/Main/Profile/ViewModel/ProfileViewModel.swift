//
//  ProfileViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation

final class ProfileViewModel: ViewModel {

    // MARK: - Events
    enum Event {
        case onAppear
        case saveTapped
        case cancelTapped
        case logOutTapped
        case showFriendsTapped
        case emailChanged(String)
        case avatarLinkChanged(String)
        case nameChanged(String)
        case genderChanged(Gender)
        case birthdateChanged(Date)
    }

    // MARK: - Properties
    private var profile: Profile?
    private let coordinator: ProfileCoordinatorProtocol
    private let logoutUseCase: LogoutUseCase
    private let getProfileUseCase: FetchProfileUseCase
    private let updateProfileUseCase: UpdateProfileUseCase
    private let validateEmailUseCase: ValidateEmailUseCase

    // MARK: - Callbacks
    var onProfileLoaded: ((Profile) -> Void)?
    var onError: ((String) -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onDataChanged: ((Bool) -> Void)?

    // MARK: - State
    private(set) var isUpdating = false {
        didSet { onLoadingStateChanged?(isUpdating) }
    }
    private(set) var isDataChanged = false {
        didSet { onDataChanged?(isDataChanged) }
    }

    private var name: String = ""
    private var email: String = ""
    private var avatarLink: String = ""
    private var newAvatarLink: String = ""
    private var gender: Gender = .male
    private var birthdate: Date = Date()

    // MARK: - Initialization
    init(
        coordinator: ProfileCoordinatorProtocol,
        logoutUseCase: LogoutUseCase,
        getProfileUseCase: FetchProfileUseCase,
        updateProfileUseCase: UpdateProfileUseCase,
        validateEmailUseCase: ValidateEmailUseCase
    ) {
        self.coordinator = coordinator
        self.logoutUseCase = logoutUseCase
        self.getProfileUseCase = getProfileUseCase
        self.updateProfileUseCase = updateProfileUseCase
        self.validateEmailUseCase = validateEmailUseCase
    }

    // MARK: - Public Methods
    func handle(_ event: Event) {
        switch event {
        case .onAppear:
            Task { await fetchProfile() }

        case .saveTapped:
            Task { await updateProfile() }

        case .cancelTapped:
            resetChanges()

        case .logOutTapped:
            Task { await logOut() }

        case .emailChanged(let email):
            emailUpdated(email)

        case .avatarLinkChanged(let link):
            avatarLinkUpdated(link)

        case .nameChanged(let name):
            self.name = name
            checkDataIsChanged()

        case .genderChanged(let gender):
            self.gender = gender
            checkDataIsChanged()

        case .birthdateChanged(let date):
            self.birthdate = date
            checkDataIsChanged()
        case .showFriendsTapped:
            showFriends()
        }
        
    }
}

// MARK: - Private Methods
private extension ProfileViewModel {

    func handleError(_ error: Error) {
        if let authError = error as? AuthError, authError == .unauthorized {
            coordinator.unauthorized()
        } else {
            onError?(error.localizedDescription)
        }
    }

    func logOut() async {
        do {
            try await logoutUseCase.execute()
            coordinator.unauthorized()
        } catch {
            handleError(error)
        }
    }

    func fetchProfile() async {
        onLoadingStateChanged?(true)
            do {
                let profile = try await getProfileUseCase.execute()
                self.profile = profile
                handleProfileData(profile)
                onProfileLoaded?(profile)
            } catch {
                handleError(error)
            }
            onLoadingStateChanged?(false)
        
    }

    func handleProfileData(_ profile: Profile) {
        self.name = profile.name
        self.email = profile.email
        self.avatarLink = profile.avatarLink
        self.newAvatarLink = profile.avatarLink
        self.gender = profile.gender
        self.birthdate = profile.birthDate
        checkDataIsChanged()
    }

    func resetChanges() {
        guard let profile else { return }

        name = profile.name
        email = profile.email
        avatarLink = profile.avatarLink
        newAvatarLink = profile.avatarLink
        gender = profile.gender
        birthdate = profile.birthDate
        checkDataIsChanged()
    }

    func updateProfile() async {
        guard let id = profile?.id else { return }

        isUpdating = true

        let updatedProfile = Profile(
            id: id,
            nickName: profile?.nickName ?? "",
            email: email,
            avatarLink: newAvatarLink,
            name: name,
            birthDate: birthdate,
            gender: gender
        )

        
            do {
                try await updateProfileUseCase.execute(profile: updatedProfile)
                self.profile = updatedProfile
                self.avatarLink = updatedProfile.avatarLink
                checkDataIsChanged()
            } catch {
                resetChanges()
                handleError(error)
            }
            isUpdating = false
        
    }

    func emailUpdated(_ email: String) {
        self.email = email

        do {
            try validateEmailUseCase.execute(email)
        } catch {
            onError?(ValidationErrorHandler.message(for: error))
        }

        checkDataIsChanged()
    }

    func avatarLinkUpdated(_ urlString: String) {
        newAvatarLink = urlString

        guard let url = URL(string: urlString) else {
            onError?(LocalizedKey.ErrorMessage.invalidLink)
            return
        }

        Task {
            let isValid = await validateAvatarLink(url)
            if !isValid {
                onError?(LocalizedKey.ErrorMessage.invalidLink)
            } else {
                checkDataIsChanged()
            }
        }
    }

    private func validateAvatarLink(_ url: URL) async -> Bool {
        if let _ = await ImageManagerActor.shared.loadImage(from: url) {
            return true
        }
        return false
    }

    func checkDataIsChanged() {
        guard let profile else { return }

        let isNameChanged = name != profile.name
        let isEmailChanged = email != profile.email
        let isAvatarLinkChanged = newAvatarLink != profile.avatarLink
        let isGenderChanged = gender != profile.gender
        let isBirthdateChanged = !Calendar.current.isDate(birthdate, equalTo: profile.birthDate, toGranularity: .day)

        isDataChanged = isNameChanged || isEmailChanged || isAvatarLinkChanged || isGenderChanged || isBirthdateChanged
    }
    
    func showFriends() {
        print("Show friends")
    }
}
