//
//  SceneDelegate.swift
//  MovieCatalog
//
//  Created by Tark Wight on 03.08.2025.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let store = Store(
        initial: AppState(),
        reducer: appReducer,
        middlewares: []
    )
    private var cancellables = Set<AnyCancellable>()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        store.dispatch(.appStarted)

        store.$state
            .map { $0.routeStack.last }
            .removeDuplicates { "\(String(describing: $0))" == "\(String(describing: $1))" }
            .compactMap { $0 }
            .sink { [weak self] lastRoute in
                guard let self = self else { return }
                let vc: UIViewController

                switch lastRoute {
                case .auth(.welcome):
                    vc = WelcomeViewController(store: store)
                default:
                    vc = ViewController() // Заглушка, если нужно
//                    vc = UIViewController() // Заглушка, если нужно
//                case .auth(.login):
//                    vc = LoginViewController(store: self.store)
//                case .auth(.register):
//                    vc = RegisterViewController(store: self.store)
//                case .tab(let tab):
//                    vc = MainTabBarController(store: self.store, initial: tab)
//                case .fullScreen(let full):
//                    switch full {
//                    case .movieDetails(let id):
//                        vc = MovieDetailsViewController(store: self.store, movieID: id)
//                    case .friends:
//                        vc = FriendsViewController(store: self.store)
//                    case .collection(let tag):
//                        vc = CollectionScreenViewController(store: self.store, tag: tag)
//                    }
//                case .sheetModal(let sheetModal):
//                    switch sheetModal {
//                    case .addReview(let movieID):
//                        let addVC = AddReviewViewController(
//                            store: self.store,
//                            movieID: movieID,
//                            existingReview: nil
//                        )
//                        addVC.modalPresentationStyle = .formSheet
//                        vc = addVC
//                    case .error(let error):
//                        let alert = UIAlertController(
//                            title: "Error",
//                            message: error.localizedDescription,
//                            preferredStyle: .alert
//                        )
//                        alert.addAction(.init(title: "OK", style: .default))
//                        // показываем alert поверх текущего root
//                        self.window?.rootViewController?.present(alert, animated: true)
//                        return
//                    }
                }

                window?.rootViewController = vc
                window?.makeKeyAndVisible()
            }
            .store(in: &cancellables)
    }
}
