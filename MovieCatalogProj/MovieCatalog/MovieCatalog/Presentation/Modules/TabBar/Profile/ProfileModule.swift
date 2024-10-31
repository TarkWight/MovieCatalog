//
//  ProfileModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

enum ProfileModule {
    public static func createModule() -> UIViewController {
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)
        return viewController
    }
}
