//
//  MoviesListModel.swift
//  ClientAPI
//
//  Created by Tark Wight on 14.10.2024.
//

import Foundation



public struct MoviesListModel: Codable {

    public var movies: [MovieElementModel]?

    public init(movies: [MovieElementModel]? = nil) {
        self.movies = movies
    }


}
