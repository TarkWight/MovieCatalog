//
//  FriendViewModel.swift
//  MovieCatalog
//
//  Created by Tark Wight on 13.01.2025.
//

import Foundation


final class FriendViewModel: ViewModel {
    enum Event {
        case fetchFriends
    }

    var onFriendsLoaded: (() -> Void)?
    var onError: ((String) -> Void)?

    private let coordinator: FriendCoordinatorProtocol
    private let fetchFriendsUseCase: FetchFriendsUseCase

    private(set) var friends: [UserShort] = []

    init(coordinator: FriendCoordinatorProtocol, fetchFriendsUseCase: FetchFriendsUseCase) {
        self.coordinator = coordinator
        self.fetchFriendsUseCase = fetchFriendsUseCase
    }

    func handle(_ event: Event) {
        switch event {
        case .fetchFriends:
            fetchFriends()
        }
    }

    private func fetchFriends() {
        Task {
            do {
                let friends = try await fetchFriendsUseCase.execute()
                self.friends = friends
                onFriendsLoaded?()
            } catch {
                onError?("Failed to fetch friends: \(error.localizedDescription)")
            }
        }
    }
}
