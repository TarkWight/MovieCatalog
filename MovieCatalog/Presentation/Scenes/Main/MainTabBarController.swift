//
//  MainTabBarController.swift
//  MovieCatalog
//
//  Created by Tark Wight on 10.01.2025.
//


import UIKit

final class MainCoordinatorViewController: UITabBarController {
    
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
    init(factory: SceneFactory) {
        self.factory = factory
        self.feedCoordinator = FeedCoordinator(factory: factory)
        self.moviesCoordinator = MoviesCoordinator(sceneFactory: factory)
        self.favoritesCoordinator = FavoritesCoordinator(sceneFactory: factory)
        self.profileCoordinator = ProfileCoordinator(factory: factory)

        super.init(nibName: nil, bundle: nil)

        generateTabBar()
        setupTabBarAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MainCoordinatorViewController {
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
}

extension MainCoordinatorViewController {
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

        print(width)
        print(width - (Constants.tabBar.sidePadding * 2))
        print((width - (Constants.tabBar.sidePadding * 2)) / Constants.tabBar.countOfItems)
        tabBar.itemWidth = (width - (Constants.tabBar.sidePadding * 2)) / Constants.tabBar.countOfItems
        tabBar.itemSpacing = 0.01
        tabBar.itemPositioning = .centered

        tabBar.unselectedItemTintColor = Constants.color.unselected
    }
}

extension MainCoordinatorViewController {
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: feedCoordinator.navigationController,
                title: Constants.titles.feed,
                image: Constants.images.feed
            ),
            generateVC(
                viewController: moviesCoordinator.navigationController,
                title: Constants.titles.movie,
                image: Constants.images.movie
            ),
            generateVC(
                viewController: favoritesCoordinator.navigationController,
                title: Constants.titles.favorite,
                image: Constants.images.favorite
            ),
            generateVC(
                viewController: profileCoordinator.navigationController,
                title: Constants.titles.profile,
                image: Constants.images.profile
            )
        ]
    }
}

extension MainCoordinatorViewController {
   
    
    enum Constants {
        enum titles {
            static let feed = LocalizedKey.TabBarTitle.feed
            static let movie = LocalizedKey.TabBarTitle.movie
            static let favorite = LocalizedKey.TabBarTitle.favorite
            static let profile = LocalizedKey.TabBarTitle.user_profile
        }
        
        enum images {
            static let feed = UIImage(named: "tab-bar-feed")
            static let movie = UIImage(named: "tab-bar-movie")
            static let favorite = UIImage(named: "tab-bar-favorite")
            static let profile = UIImage(named: "tab-bar-profile")
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
        
        enum mask {
            func gradient(frame: CGRect) -> UIImage {
                let colors = [GradientColor.start, GradientColor.end]
                return  UIImage.qImage(frame: frame, colors: colors)
            }
        }
    }
}
