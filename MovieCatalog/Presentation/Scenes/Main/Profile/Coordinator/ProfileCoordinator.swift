//
//  ProfileCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

@MainActor
protocol ProfileCoordinatorProtocol {
    func showFriends()
    func unauthorized()
}

final class ProfileCoordinator {
   
    
    // MARK: - Properties
    lazy var profileViewController: ProfileCoordinatorViewController = {
        ProfileCoordinatorViewController(
            coordinator: self,
            profileFactory: factory
        )
        
    }()
    private let handleUnauthorized: () -> Void

    private let factory: SceneFactory

    
    // MARK: - Initializer
    init(
        factory: SceneFactory,
        handleUnauthorized: @escaping () -> Void
    ) {
        self.factory = factory
        self.handleUnauthorized = handleUnauthorized
    }
}



// MARK: - ProfileCoordinatorProtocol
extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func unauthorized() {
        handleUnauthorized()
    }
    
    func showFriends() {
//        let friendsViewController = factory.makeFriendScene(coordinator: self)
//        profileViewController.present(friendsViewController, animated: true)
    }
}
