//
//  SignUpModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

enum SignUpModule {
    static func build(router: RouterProtocol) -> UIViewController {
        let viewModel = SignUpViewModel(router: router)
        let viewController = SignUpViewController(viewModel: viewModel)
        return viewController
    }
}
