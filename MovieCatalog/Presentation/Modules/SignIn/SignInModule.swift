//
//  SignInModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 30.10.2024.
//

import UIKit

enum SignInModule {
    static func build(router: RouterProtocol) -> UIViewController {
        let viewModel = SignInViewModel(router: router)
        let viewController = SignInViewController(viewModel: viewModel)
        return viewController
    }
}
