//
//  MainTabBarController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

final class MainCoordinatorViewController: UITabBarController, UITabBarControllerDelegate {

    // MARK: - TabBarItem Enum
    enum TabBarItem: Int, CaseIterable {
        case feed
        case movies
        case favorites
        case profile
    }

    // MARK: - Properties
    private let factory: SceneFactory
    private let feedCoordinator: FeedCoordinator
    private let moviesCoordinator: MoviesCoordinator
    private let favoritesCoordinator: FavoritesCoordinator
    private let profileCoordinator: ProfileCoordinator
    

    // MARK: - Initializer
    init(
        factory: SceneFactory,
        feedCoordinator: FeedCoordinator,
        moviesCoordinator: MoviesCoordinator,
        favoritesCoordinator: FavoritesCoordinator,
        profileCoordinator: ProfileCoordinator
    ) {
        self.factory = factory
        self.feedCoordinator = feedCoordinator
        self.moviesCoordinator = moviesCoordinator
        self.favoritesCoordinator = favoritesCoordinator
        self.profileCoordinator = profileCoordinator

        super.init(nibName: nil, bundle: nil)

        generateTabBar()
        setupTabBarAppearance()
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Tab Bar Configuration
extension MainCoordinatorViewController {
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: feedCoordinator.feedViewController,
                title: Constants.titles.feed,
                image: Constants.images.feed
            ),
            generateVC(
                viewController: moviesCoordinator.moviesViewController,
                title: Constants.titles.movie,
                image: Constants.images.movie
            ),
            generateVC(
                viewController: favoritesCoordinator.navigationController,
                title: Constants.titles.favorite,
                image: Constants.images.favorite
            ),
            generateVC(
                viewController: profileCoordinator.profileViewController,
                title: Constants.titles.profile,
                image: Constants.images.profile
            )
        ]
        applyGradientToSelectedTab()
    }

    private func setupTabBarAppearance() {
        let width = tabBar.bounds.width - Constants.tabBar.positionOnX * 2
        let height = Constants.tabBar.height
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: Constants.tabBar.positionOnX,
                y: tabBar.bounds.minY - Constants.tabBar.positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: Constants.tabBar.radius
        )
        
        roundLayer.path = bezierPath.cgPath
        roundLayer.fillColor = Constants.color.background
        tabBar.layer.insertSublayer(roundLayer, at: 0)

        tabBar.itemWidth = (width - (Constants.tabBar.sidePadding * 2)) / Constants.tabBar.countOfItems
        tabBar.itemSpacing = 0.01
        tabBar.itemPositioning = .centered

        tabBar.unselectedItemTintColor = Constants.color.unselected
    }
}

// MARK: - UITabBarControllerDelegate
extension MainCoordinatorViewController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        applyGradientToSelectedTab()
    }

    private func applyGradientToSelectedTab() {
        guard selectedIndex < (tabBar.items?.count ?? 0) else { return }
        
        let item = tabBar.items?[selectedIndex]
        
        if let originalImage = item?.image {
            let gradientImage = UIImage.qImage(
                frame: CGRect(origin: .zero, size: originalImage.size),
                colors: [GradientColor.start, GradientColor.end]
            )
            let blendedImage = blendImage(originalImage, with: gradientImage)
            item?.selectedImage = blendedImage.withRenderingMode(.alwaysOriginal)
        }
        
        let gradientTextImage = UIImage.qImage(
            frame: CGRect(x: 0, y: 0, width: 100, height: 20),
            colors: [GradientColor.start, GradientColor.end]
        )
        let gradientTextColor = UIColor(patternImage: gradientTextImage)
        item?.setTitleTextAttributes([.foregroundColor: gradientTextColor], for: .selected)
    }

    private func blendImage(_ image: UIImage, with gradient: UIImage) -> UIImage {
        let size = image.size
        UIGraphicsBeginImageContextWithOptions(size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: size))
        gradient.draw(in: CGRect(origin: .zero, size: size), blendMode: .sourceIn, alpha: 1.0)
        let blendedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return blendedImage ?? image
    }
}

// MARK: - Constants
extension MainCoordinatorViewController {
    enum Constants {
        enum titles {
            static let feed = LocalizedKey.TabBarTitle.feed
            static let movie = LocalizedKey.TabBarTitle.movie
            static let favorite = LocalizedKey.TabBarTitle.favorite
            static let profile = LocalizedKey.TabBarTitle.user_profile
        }
        
        enum images {
            static let feed = UIImage(named: "Feed Icon")
            static let movie = UIImage(named: "Movies Icon")
            static let favorite = UIImage(named: "Library Icon")
            static let profile = UIImage(named: "Person Icon")
        }
        
        enum tabBar {
            static let height: CGFloat = 64
            static let positionOnX: CGFloat = 24
            static let positionOnY: CGFloat = 8
            static let radius: CGFloat = 16
            static let countOfItems: CGFloat = 4
            static let sidePadding: CGFloat = 8
        }
        
        enum color {
            static let background = UIColor(named: "AppDarkFaded")?.cgColor
            static let unselected = UIColor(named: "AppGrayFaded")
        }
    }
}

extension MainCoordinatorViewController {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        applyGradientToSelectedTab()
    }
}
