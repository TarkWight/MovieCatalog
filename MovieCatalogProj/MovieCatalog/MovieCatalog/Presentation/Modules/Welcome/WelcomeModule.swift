//
//  WelcomeModule.swift
//  MovieCatalog
//
//  Created by Tark Wight on 27.10.2024.
//

import UIKit

enum WelcomeModule {
    static func build(router: RouterProtocol) -> UIViewController {
        let viewModel = WelcomeViewModel(router: router)
        let viewController = WelcomeViewController(viewModel: viewModel)
        return viewController
    }
}

