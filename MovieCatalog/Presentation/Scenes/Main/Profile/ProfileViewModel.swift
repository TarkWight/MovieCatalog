//
//  ProfileViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


final class ProfileViewModel: ViewModel {
    enum Event {
        case fetchProfile
        case logout
    }

    private let coordinator: ProfileCoordinatorProtocol
    private let fetchProfileUseCase: FetchProfileUseCase
    private let updateProfileUseCase: UpdateProfileUseCase
    private let logoutUseCase: LogoutUseCase

    init(
        coordinator: ProfileCoordinatorProtocol,
        fetchProfileUseCase: FetchProfileUseCase,
        updateProfileUseCase: UpdateProfileUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.coordinator = coordinator
        self.fetchProfileUseCase = fetchProfileUseCase
        self.updateProfileUseCase = updateProfileUseCase
        self.logoutUseCase = logoutUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .fetchProfile:
            fetchProfile()
        case .logout:
            logout()
        }
    }

    private func fetchProfile() {
        print("Fetching profile...")
    }

    private func logout() {
        print("Logging out...")
    }
}
