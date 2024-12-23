//
//  CustumTabBar.swift
//  CommonUI
//
//  Created by Tark Wight on 31.10.2024.
//

import UIKit

open class CustomTabBarController: UITabBarController {

    // MARK: - Initialization
    public init(
        viewControllers: [UIViewController],
        tabTitles: [String],
        tabImages: [String],
        gradientColors: [CGColor],
        unselectedItemColor: UIColor,
        tabBarBackgroundColor: UIColor
    ) {
        self.gradientColors = gradientColors
        self.unselectedItemColor = unselectedItemColor
        self.tabBarBackgroundColor = tabBarBackgroundColor
        super.init(nibName: nil, bundle: nil)
        setupViewControllers(viewControllers, tabTitles: tabTitles, tabImages: tabImages)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Properties
    private var gradientColors: [CGColor]
    private var unselectedItemColor: UIColor
    private var tabBarBackgroundColor: UIColor
    private var didSetInitialSelectedTab = false

    // MARK: - Setup
    private func setupViewControllers(
        _ viewControllers: [UIViewController],
        tabTitles: [String],
        tabImages: [String]
    ) {
        let tabs = zip(viewControllers, zip(tabTitles, tabImages)).map { vc, titleImage in
            createTabBarItem(for: vc, title: titleImage.0, imageName: titleImage.1)
        }

        self.viewControllers = tabs
        customizeTabBarAppearance()
        
        selectedIndex = 0
    }

    private func createTabBarItem(for viewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: imageName)
        return UINavigationController(rootViewController: viewController)
    }

    private func customizeTabBarAppearance() {
        tabBar.backgroundColor = tabBarBackgroundColor
        tabBar.unselectedItemTintColor = unselectedItemColor
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.updateTabBarAppearance()
        }
    }


    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didSetInitialSelectedTab {
            updateTabBarAppearance()
            didSetInitialSelectedTab = true
        }
    }

    private func updateTabBarAppearance() {
        for (index, tabBarItem) in (tabBar.items ?? []).enumerated() {
            guard index < tabBar.subviews.count else { continue }
            let tabBarItemView = tabBar.subviews[index]
            let imageView = tabBarItemView.subviews.compactMap { $0 as? UIImageView }.first
            let titleLabel = tabBarItemView.subviews.compactMap { $0 as? UILabel }.first

            if tabBarItem == selectedViewController?.tabBarItem {
                imageView?.layer.mask = nil
                titleLabel?.layer.mask = nil

                if let imageView = imageView {
                    applyGradientMask(to: imageView, with: gradientColors)
                    imageView.layer.mask?.frame = imageView.bounds
                }
                if let titleLabel = titleLabel {
                    applyGradientMask(to: titleLabel, with: gradientColors)
                    titleLabel.layer.mask?.frame = titleLabel.bounds
                }
            } else {
                imageView?.layer.mask = nil
                imageView?.tintColor = unselectedItemColor
                titleLabel?.layer.mask = nil
                titleLabel?.textColor = unselectedItemColor
            }
        }
    }



    private func applyGradientMask(to view: UIView, with colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = view.bounds
        
        view.layer.mask = nil
        
        let maskLayer = CALayer()
        maskLayer.frame = gradientLayer.bounds
        gradientLayer.mask = maskLayer
        view.layer.mask = gradientLayer
    }

    private func removeGradient(from view: UIView?) {
        view?.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
    }

}
