//
//  ProfileCoordinator.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

@MainActor
protocol ProfileCoordinatorProtocol {
    func start() -> UINavigationController
    
}

final class ProfileCoordinator {

    private let factory: SceneFactory
    let navigationController: UINavigationController

    init(factory: SceneFactory) {
        self.factory = factory
        self.navigationController = UINavigationController()
    }



}
