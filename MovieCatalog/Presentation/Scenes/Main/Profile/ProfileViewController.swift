//
//  ProfileViewController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//

import Foundation


final class ProfileViewController: BaseViewController {
    private let viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle("Profile")
        viewModel.handle(.fetchProfile)
    }
}
