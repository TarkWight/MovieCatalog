//
//  SceneViewFactoryProtocols.swift
//  MovieCatalog
//
//  Created by Tark Wight on 07.01.2025.
//

import Foundation

protocol AuthCoordinatorFactory: LoginSceneFactory,
                                 WelcomeSceneFactory,
                                 RegisterSceneFactory {}

protocol FeedCoordinatorFactory: FeedSceneFactory, MovieDetailsViewFactory {}
protocol MoviesCoordinatorFactory: MoviesSceneFactory {}
protocol FavoritesCoordinatorFactory: FavoritesViewFactory, MovieDetailsViewFactory {}
protocol ProfileCoordinatorFactory: ProfileSceneFactory {}

